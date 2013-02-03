//
//  EventMapViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventMapViewController.h"
#import "MapPin.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface EventMapViewController ()

@end

@implementation EventMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = @"Event Map Screen";
}

- (void)setMapPinLocation:(CLLocation *)location name:(NSString *)name andDescription:(NSString *)description
{
    _latitude = location.coordinate.latitude;
    _longitude = location.coordinate.longitude;
    _pinName = name;
    _pinDescription = description;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Mapa";
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _latitude;
    zoomLocation.longitude= _longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [self.eventMap setRegion:viewRegion animated:YES];

    MapPin *pin = [[MapPin alloc] initWithCoordinates:zoomLocation placeName:_pinName description:_pinDescription];
    [self.eventMap addAnnotation:pin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
