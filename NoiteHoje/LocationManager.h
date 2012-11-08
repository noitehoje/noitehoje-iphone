//
//  LocationManager.h
//  MobileGuides
//
//  Created by Felipe Kellermann on 12/22/09.
//  Copyright 2009 Nyvra. All rights reserved.
//
// $Id$
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

+ (LocationManager *) singleton;
- (void) addDelegate:(id)delegate;
- (id) removeDelegate:(id)delegate;
- (BOOL)isLocationRecent:(CLLocation *)location;
- (BOOL)hasRecentLocation;
- (CLLocation *)recentLocation;
+ (NSString *)distanceStringForMeters:(CLLocationDistance)meters;

@property(nonatomic, retain) CLLocationManager	*locationManager;
@property(nonatomic, retain) CLLocation			*lastLocation;
@property(nonatomic, retain) CLLocation			*oldLocation;
@property(nonatomic, retain) NSMutableArray		*delegateList;
@property(nonatomic, assign) NSTimeInterval		intervalOld;

@end
