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
#import "EGORefreshTableHeaderView.h"
#import "PagedEvents.h"

@interface EventsViewController : NoiteHojeViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
}

@property (nonatomic, strong) PagedEvents *pagedEvents;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;
@property (strong, nonatomic) NSDateFormatter *cellDateFormatter;

- (IBAction)addButtonTapped:(id)sender;

@end
