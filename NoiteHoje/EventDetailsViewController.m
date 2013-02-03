//
//  EventDetailsViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/26/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "UIColor+Extensions.h"
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>
#import "Social/Social.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+Extensions.h"
#import "EventMapViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    self.flyerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.flyerImageView.clipsToBounds = YES;
    self.eventDescriptionWebView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    self.eventDescriptionWebView.opaque = NO;
    self.eventDescriptionWebView.backgroundColor = [UIColor clearColor];
    self.trackedViewName = @"Event Details Screen";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.event.title;
    self.eventDateLabel.text = [self.event localizedDate];
    self.eventTitleLabel.text = self.event.title;
    self.eventVenueLabel.text = self.event.venue.name;
    if(self.event.flyerUrl && ![self.event.flyerUrl isEqual:[NSNull null]]) {
        [self.flyerImageView setImageWithURL:[NSURL URLWithString:self.event.flyerUrl]];
    }
    else {
        [self.flyerImageView setImage:[UIImage imageNamed:@"ImagePlaceHolder.png"]];
    }
    [self loadPageWithTemplate];
}

- (void)loadPageWithTemplate
{
    NSString *pathTp = [[NSBundle mainBundle] pathForResource:@"DescriptionTemplate" ofType:@"tp"];
    NSString *template = [NSString stringWithContentsOfFile:pathTp encoding:NSUTF8StringEncoding error:nil];
    NSString *htmlDescription = [template stringByReplacingOccurrencesOfString:@"%%%DESCRIPTION%%%" withString:self.event.description];
    
    [self.eventDescriptionWebView loadHTMLString:[NSString stringWithFormat:@"%@ (Fonte: %@)", htmlDescription, self.event.source] baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventMapViewController *destController = [segue destinationViewController];
    [destController setMapPinLocation:self.event.venue.location name:self.event.venue.name andDescription:self.event.venue.address];
}

- (IBAction)sendButtonTapped:(id)sender
{
    NSString *shareText = [NSString stringWithFormat:@"%@ %@, %@ @ %@",
                           self.event.type,
                           self.event.title,
                           self.event.localizedDate,
                           self.event.venue.name];

    NSArray *items = @[shareText, [NSURL URLWithString:self.event.shortURL]];
    NSMutableArray *activityItems = [NSMutableArray arrayWithArray:items];
    
    if(self.flyerImageView.image) {
        [activityItems addObject:self.flyerImageView.image];
    }
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}

@end
