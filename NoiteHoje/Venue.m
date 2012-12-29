//
//  Venue.m
//  Noite Hoje
//
//  Created by Felipe Lima on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        id location = [json objectForKey:@"location"];
        self.name = [[json objectForKey:@"name"] capitalizedString];
        self.city = [[location objectForKey:@"city"] capitalizedString];

        if(![[location objectForKey:@"street"] isEqual:[NSNull null]]) {
            self.address = [[location objectForKey:@"street"] capitalizedString];
        }
        
        if(![[location objectForKey:@"geo_lat"] isEqual:[NSNull null]] &&
           ![[location objectForKey:@"geo_lon"] isEqual:[NSNull null]]) {

            NSNumber *lat = [location objectForKey:@"geo_lat"];
            NSNumber *lng = [location objectForKey:@"geo_lon"];

            self.location = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
            self.coordinate = self.location.coordinate;
        }
        self.foursquareId = [json objectForKey:@"foursquare_id"];
    }
    return self;
}

@end
