//
//  Venue.h
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>

@interface Venue : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) CLLocation *location;
@property (nonatomic, copy) NSString *foursquareId;
@property (nonatomic) CLLocationCoordinate2D coordinate;


- (id)initWithJSON:(NSDictionary *)json;

@end
