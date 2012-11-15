//
//  EventDetailsViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/26/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "UIColor+Extensions.h"
#import "EventDetailsCell.h"
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]];
    
    self.flyerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.flyerImageView.clipsToBounds = YES;
    self.eventDescriptionWebView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    self.eventDescriptionWebView.opaque = NO;
    self.eventDescriptionWebView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.event.title;
    self.eventDateLabel.text = [self.event localizedDate];
    self.eventTitleLabel.text = self.event.title;
    self.eventVenueLabel.text = self.event.venue.name;
    [self.flyerImageView setImageWithURL:[NSURL URLWithString:self.event.flyerUrl]];
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
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[shareText, [NSURL URLWithString:self.event.shortURL], self.flyerImageView.image]
     applicationActivities:nil];
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if(buttonIndex == 0) {
//        NSArray *permissions = [[FBSession activeSession] permissions];
//        
//        if ([permissions indexOfObject:@"publish_stream"] == NSNotFound) {
//            [[FBSession activeSession] reauthorizeWithPublishPermissions:@[@"publish_stream"]
//                                                         defaultAudience:FBSessionDefaultAudienceEveryone
//                                                       completionHandler:^(FBSession *session, NSError *error) { }];
//        }
//        BOOL displayedNativeDialog =
//        [FBNativeDialogs
//         presentShareDialogModallyFrom:self
//         initialText:@"asdsdad"
//         image:[UIImage imageNamed:@"star.png"]
//         url:[NSURL URLWithString:@"http://www.example.com"]
//         handler:^(FBNativeDialogResult result, NSError *error) {
//             if (error) {
//                 NSLog(@"%@", error);
//             } else {
//                 if (result == FBNativeDialogResultSucceeded) {
//                     NSLog(@"Success");
//                 } else {
//                     NSLog(@"Cancelled");
//                 }
//             }
//         }];
//        if (!displayedNativeDialog) {
//            SLComposeViewController *fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            
//            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
//                SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result) {
//                    
//                    [fbController dismissViewControllerAnimated:YES completion:nil];
//                    
//                    switch(result) {
//                        case SLComposeViewControllerResultCancelled:
//                        default: {
//                            NSLog(@"Cancelled.....");
//                        }
//                        break;
//                        case SLComposeViewControllerResultDone: {
//                            NSLog(@"Posted....");
//                        }
//                        break;
//                    }
//                };
//                
//                [fbController addImage:self.flyerImageView.image];
////                [fbController setInitialText:shareText];
//                [fbController addURL:[NSURL URLWithString:self.event.shortURL]];
//                [fbController setCompletionHandler:completionHandler];
//                
//                [self presentViewController:fbController animated:YES completion:nil];
//            }
//        }
//    }
//    else if(buttonIndex == 1) {
//        // twitter
//    }
//}

@end
