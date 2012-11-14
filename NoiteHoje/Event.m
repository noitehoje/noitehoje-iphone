//
//  Event.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "Event.h"
#import "Venue.h"
#import "LocationManager.h"

@implementation Event

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.title = [[json objectForKey:@"title"] capitalizedString];
        self.subtitle = [[[json objectForKey:@"venue"] objectForKey:@"name"] capitalizedString];
        self.time = [json objectForKey:@"start_time"];
        self.date = [json objectForKey:@"start_date"];
        self.description = [json objectForKey:@"description"];
        self.source = [json objectForKey:@"source"];
        self.eventID = [json objectForKey:@"_id"];
        self.shortURL = [json objectForKey:@"short_url"];
        self.flyerUrl = [json objectForKey:@"flyer"];
        
        NSString *ret = [[json objectForKey:@"evt_type"] capitalizedString];

        if ([ret isEqualToString:@"Party"])
            self.type = @"Festa";
        else if ([ret isEqualToString:@"Show"])
            self.type = @"Show";
        
        self.venue = [[Venue alloc] initWithJSON:[json objectForKey:@"venue"]];
    }
    return self;
}

// Returns the distance string in Km to the user's current location
- (NSString *)relativeDistance
{
    if ([[LocationManager singleton] hasRecentLocation]) {
        CLLocation *here = [[LocationManager singleton] recentLocation];
        CLLocation *location = self.venue.location;
        CLLocationDistance meters = [here distanceFromLocation:location];
        return [LocationManager distanceStringForMeters:meters];
    }
    NSLog(@" no recent location");
    return @"";
}

// Festa amanhã
- (NSString *)dateRelative
{    
    NSDate *date = [self formattedDate];
    
    // Count days
    NSDate *now = [NSDate date];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDateComponents *breakdown = [sysCalendar components:NSDayCalendarUnit fromDate:now toDate:date options:0];
    
    NSInteger day = [breakdown day];
    // Kind of a hack ;-)
    if ([date compare:now] == NSOrderedAscending)
    {
        return [NSString stringWithFormat:NSLocalizedString(@"%@ agora", @""), [self type]];
    }
    
    switch (day) {
        case 0:
            return [NSString stringWithFormat:NSLocalizedString(@"%@ hoje", @""), self.type];
        case 1:
            return [NSString stringWithFormat:NSLocalizedString(@"%@ amanhã", @""), self.type];
        default:
            return [NSString stringWithFormat:NSLocalizedString(@"%@ em %d dias", @""), self.type, [breakdown day]];
    }
}

// Returns an NSDate object with the event date/time
- (NSDate *)formattedDate
{
    // Format input
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale ISOCountryCodes] objectAtIndex:0]]];
    
    NSString *formatter = [NSString stringWithFormat:@"%@ HH:mm", EVENTINFO_DATE_ORIGINAL];
    NSString *dateS = [NSString stringWithFormat:@"%@ %@", self.date, self.time.length > 0 ? self.time : @"21:00"];
    
    [inputFormatter setDateFormat:formatter];
    return [inputFormatter dateFromString:dateS];
}

// Returns the event date/time in the user's current date/time format
- (NSString *)localizedDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [outputFormatter setDateFormat:EVENTINFO_DATE_ORIGINAL];
    
    return [[outputFormatter stringFromDate:[self formattedDate]] capitalizedString];
}

@end
