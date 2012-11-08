//
//  LocationManager.m
//  MobileGuides
//
//  Created by Felipe Kellermann on 12/22/09.
//  Copyright 2009 Nyvra. All rights reserved.
//
// $Id$
//

#import "LocationManager.h"

@implementation LocationManager

- (id) init
{
	if (self = [super init]) {
		self.delegateList = [[NSMutableArray alloc] init];
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.distanceFilter = kCLDistanceFilterNone;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		self.intervalOld = -300;
	}
	
	return self;
}

+ (LocationManager *)singleton
{
	static LocationManager	*locationManager = nil;
	
	@synchronized(self) {
		if (locationManager == nil) {
			locationManager = [[LocationManager alloc] init];
			[locationManager.locationManager startUpdatingLocation];
		}
	}
	
	return locationManager;
}

- (void) addDelegate:(id)delegate
{
	if (! [self.delegateList containsObject:delegate])
		[self.delegateList addObject:delegate];
	
	if (self.lastLocation != nil && [self isLocationRecent:self.lastLocation])
		[delegate locationManager:self.locationManager didUpdateToLocation:self.lastLocation fromLocation:self.oldLocation];
}

- (id) removeDelegate:(id)delegate
{
	if ([self.delegateList containsObject:delegate]) {
		[self.delegateList removeObject:delegate];
		return delegate;
	} else
		return nil;
}

- (BOOL)isLocationRecent:(CLLocation *)location
{
	NSTimeInterval howRecent;
	
	if (location == nil)
		return NO;
	
#if TARGET_IPHONE_SIMULATOR
	return YES;
#endif
	
	howRecent = [location.timestamp timeIntervalSinceNow];
	if (howRecent < self.intervalOld)
		return NO;
	else
		return YES;	
}

- (BOOL)hasRecentLocation
{
	if (self.lastLocation == nil)
		return NO;

	return [self isLocationRecent:self.lastLocation];
}

- (CLLocation *)recentLocation
{
	return self.lastLocation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)fromLocation
{
	if (! [self isLocationRecent:newLocation])
		return;

	self.lastLocation = newLocation;
	self.oldLocation = fromLocation;
	
	for (id<CLLocationManagerDelegate> delegate in self.delegateList) {
		[delegate locationManager:self.locationManager didUpdateToLocation:newLocation fromLocation:self.oldLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"Location did fail with error: %@", error);

	for (id<CLLocationManagerDelegate> delegate in self.delegateList) {
		[delegate locationManager:self.locationManager didFailWithError:error];
	}
}

// Converts a given distance to a distance description.
+ (NSString *)distanceStringForMeters:(CLLocationDistance)meters
{
	NSString *distStr;
	
	if (meters >= 1000.0) {
		distStr = [NSString stringWithFormat:@"%.1fkm", (meters / 1000.0)];
	} else
		distStr = [NSString stringWithFormat:@"%0.fm", meters];
	
	return distStr;
}

- (void)dealloc
{
	self.locationManager = nil;
	self.lastLocation = nil;
	self.oldLocation = nil;
	[self.delegateList removeAllObjects];
	self.delegateList = nil;
}

@end
