//
//  Event.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "Event.h"
#import "Venue.h"

@implementation Event

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.title = [[json objectForKey:@"title"] capitalizedString];
        self.subtitle = [[[json objectForKey:@"venue"] objectForKey:@"name"] capitalizedString];
        self.time = [json objectForKey:@"start_time"];
        self.date = [self parseDate:[json objectForKey:@"start_date"] andTime:[json objectForKey:@"start_time"]];
        self.description = [json objectForKey:@"description"];
        self.source = [json objectForKey:@"source"];
        self.eventID = [json objectForKey:@"_id"];
        self.shortURL = [json objectForKey:@"short_url"];
        
        NSString *ret = [[json objectForKey:@"evt_type"] capitalizedString];

        if ([ret isEqualToString:@"Party"])
            self.type = @"Festa";
        else if ([ret isEqualToString:@"Show"])
            self.type = @"Show";
        
        self.venue = [[Venue alloc] initWithJSON:[json objectForKey:@"venue"]];
    }
    return self;
}

- (NSString *)parseDate:(NSString *)date andTime:(NSString *)time
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale ISOCountryCodes]
                                                                           objectAtIndex:0]]];
    
    NSString *formatter = [NSString stringWithFormat:@"%@ HH:mm", EVENTINFO_DATE_ORIGINAL];
    NSString *dateS = [NSString stringWithFormat:@"%@ %@", date, time.length > 0 ? time : @"21:00"];
    [inputFormatter setDateFormat:formatter];
    NSDate *dt = [inputFormatter dateFromString:dateS];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [outputFormatter setDateFormat:EVENTINFO_DATE_ABSOLUTE];
    
    NSString *ret = [[outputFormatter stringFromDate:dt] capitalizedString];
    
    return ret;
}

@end
