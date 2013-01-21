//
//  EventsViewController.h
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITableView.h>
#import "NoiteHojeViewController.h"
#import "PagedEvents.h"
#import "JTRevealSidebarV2Delegate.h"
#import "SidebarViewController.h"

@interface EventsViewController : NoiteHojeViewController<UITableViewDelegate,
                                                          UITableViewDataSource,
                                                          UIActionSheetDelegate,
                                                          JTRevealSidebarV2Delegate,
                                                          SidebarViewControllerDelegate>
{
    UIRefreshControl *refreshControl;
}

@property (nonatomic, strong) PagedEvents *pagedEvents;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;
@property (strong, nonatomic) NSDateFormatter *cellDateFormatter;
@property (nonatomic, retain) SidebarViewController *leftSidebarViewController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


- (IBAction)addButtonTapped:(id)sender;
- (IBAction)menuButtonTapped:(id)sender;
- (IBAction)filterValueChanged:(id)sender;

@end
