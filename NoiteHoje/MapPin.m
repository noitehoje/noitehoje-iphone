//
//  MapPin.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description
{
    self = [super init];
    if (self) {
        _coordinate = location;
        _title = placeName;
        _subtitle = description;
    }
    return self;
}

@end
