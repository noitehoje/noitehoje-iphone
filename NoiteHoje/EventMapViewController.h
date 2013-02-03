//
//  EventMapViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GAITrackedViewController.h"

@interface EventMapViewController : GAITrackedViewController
{
    CLLocationDegrees _latitude;
    CLLocationDegrees _longitude;
    NSString *_pinName;
    NSString *_pinDescription;
}

@property (weak, nonatomic) IBOutlet MKMapView *eventMap;

- (void)setMapPinLocation:(CLLocation *)location name:(NSString *)name andDescription:(NSString *)description; \

@end
