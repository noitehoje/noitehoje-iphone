//
//  EventDetailsViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/26/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoiteHojeTableViewController.h"

@interface EventDetailsViewController : NoiteHojeTableViewController

- (IBAction)voltarBarButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *detailsTableView;

@end
