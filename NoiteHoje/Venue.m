//
//  Venue.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.name = [[json objectForKey:@"name"] capitalizedString];
        self.city = [[[json objectForKey:@"location"] objectForKey:@"city"] capitalizedString];
        self.address = [[[json objectForKey:@"location"] objectForKey:@"street"] capitalizedString];
        
        NSNumber *lat = [[json objectForKey:@"location"] objectForKey:@"geo_lat"];
        NSNumber *lng = [[json objectForKey:@"location"] objectForKey:@"geo_lon"];

        self.location = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
        self.coordinate = self.location.coordinate;
        self.foursquareId = [json objectForKey:@"foursquare_id"];
    }
    return self;
}

@end
