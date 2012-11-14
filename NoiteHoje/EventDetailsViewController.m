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
    
    UIImage *img = [UIImage imageNamed:@"MainBG.png"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:img];
    
    [self.backgroundView insertSubview:bgView atIndex:0];

    self.flyerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.flyerImageView.clipsToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.event.title;
    self.eventDateLabel.text = [self.event localizedDate];
    self.eventTitleLabel.text = self.event.title;
    self.eventVenueLabel.text = self.event.venue.name;
    self.eventDescriptionTextView.text = self.event.description;
    [self.flyerImageView setImageWithURL:[NSURL URLWithString:self.event.flyerUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    EventDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventDetailsCell"];
//    NSUInteger index = [indexPath section];
//        
//    if(index == 0) {
//        cell.textLabel.text = self.event.title;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    else if(index == 1) {
//        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.event.date, self.event.time];
//    }
//    else if(index == 2) {
//        cell.textLabel.text = self.event.subtitle;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSString *text;
//    if(section == 0) {
//        text = @"O que?";
//    }
//    else if(section == 1) {
//        text = @"Quando?";
//    }
//    else {
//         text = @"Onde?";
//    }
//    
//    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 20)];
//    
//    UILabel *headerLabel = [[UILabel alloc] initWithFrame:customView.frame];
//    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.font = [UIFont boldSystemFontOfSize:18];
//    headerLabel.text =  text;
//    headerLabel.textColor = [UIColor colorWithHex:0xac59ac];
//    headerLabel.shadowColor = [UIColor blackColor];
//    headerLabel.shadowOffset = CGSizeMake(0.f, -1.f);
//    
//    [customView addSubview:headerLabel];
//    
//    return customView;
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)sendButtonTapped:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Compartilhe com seus amigos"
                                        delegate:self
                               cancelButtonTitle:@"Cancelar"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"Facebook", @"Twitter", @"E-mail", nil];
    
    // Show the sheet
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        NSArray *permissions = [[FBSession activeSession] permissions];
        
        if ([permissions indexOfObject:@"publish_stream"] == NSNotFound) {
            [[FBSession activeSession] reauthorizeWithPublishPermissions:@[@"publish_stream"]
                                                         defaultAudience:FBSessionDefaultAudienceEveryone
                                                       completionHandler:^(FBSession *session, NSError *error) { }];
        }
        BOOL displayedNativeDialog =
        [FBNativeDialogs
         presentShareDialogModallyFrom:self
         initialText:@"asdsdad"
         image:[UIImage imageNamed:@"star.png"]
         url:[NSURL URLWithString:@"http://www.example.com"]
         handler:^(FBNativeDialogResult result, NSError *error) {
             if (error) {
                 NSLog(@"%@", error);
             } else {
                 if (result == FBNativeDialogResultSucceeded) {
                     NSLog(@"Success");
                 } else {
                     NSLog(@"Cancelled");
                 }
             }
         }];
        if (!displayedNativeDialog) {
            SLComposeViewController *fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result) {
                    
                    [fbController dismissViewControllerAnimated:YES completion:nil];
                    
                    switch(result) {
                        case SLComposeViewControllerResultCancelled:
                        default: {
                            NSLog(@"Cancelled.....");
                        }
                        break;
                        case SLComposeViewControllerResultDone: {
                            NSLog(@"Posted....");
                        }
                        break;
                    }
                };
                
                [fbController addImage:[UIImage imageNamed:@"star.png"]];
                [fbController setInitialText:@"Test post."];
                [fbController addURL:[NSURL URLWithString:@"http://google.com/"]];
                [fbController setCompletionHandler:completionHandler];
                
                [self presentViewController:fbController animated:YES completion:nil];
            }
        }
    }
    else if(buttonIndex == 1) {
        // twitter
    }
}

@end
