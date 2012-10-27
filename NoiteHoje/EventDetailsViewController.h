//
//  EventDetailsViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/26/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoiteHojeTableViewController.h"
#import "Event.h"

@interface EventDetailsViewController : NoiteHojeTableViewController

@property (strong, nonatomic) IBOutlet UITableView *detailsTableView;
@property (nonatomic, retain) Event *event;

- (IBAction)voltarBarButtonClicked:(id)sender;

@end
