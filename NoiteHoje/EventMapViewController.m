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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [self.eventMap setRegion:viewRegion animated:YES];

    MapPin *pin = [[MapPin alloc] initWithCoordinates:zoomLocation placeName:@"Nightwish" description:@"Bar Opinião"];
    [self.eventMap addAnnotation:pin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
