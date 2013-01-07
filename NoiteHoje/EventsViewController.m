//
//  EventViewController.m
//  Noite Hoje
//
//  Created by Felipe Lima on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EventsViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "EventDetailsViewController.h"
#import "PagedEvents.h"
#import "UIColor+Extensions.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "SidebarViewController.h"
#import "LocationManager.h"
#import "AppDelegate.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [LocationManager singleton]; // initialize location services
    
    self.navigationItem.title = @"Voltar";
    
    UIImage *img = [UIImage imageNamed:@"MainBG.png"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:img];

    [self reloadAllData];
    
    self.eventsTableView.backgroundView = bgView;
    self.eventsTableView.hidden = YES;
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor purpleColor];
    [refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.eventsTableView addSubview:refreshControl];
    
    self.sectionDateFormatter = [[NSDateFormatter alloc] init];
    [self.sectionDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [self.sectionDateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [self.sectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [self.cellDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [self.cellDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.cellDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    CGRect f = self.activityView.frame;
    f.origin.y = self.view.center.y - 100;
    self.activityView.frame = f;
    
    self.navigationItem.revealSidebarDelegate = self;
}

- (void)reloadAllData
{
    self.sections = [NSMutableDictionary dictionary];
    
    [PagedEvents firstPage:^(PagedEvents *events) {
        [self onReloadComplete:events];
    }];
}

- (void)reloadAllData:(NSString *)city
{
    self.sections = [NSMutableDictionary dictionary];
    
    [PagedEvents firstPage:^(PagedEvents *events) {
        [self onReloadComplete:events];
    } andCity:city];
}

- (void)onReloadComplete:(PagedEvents *)events
{
    self.eventsTableView.hidden = NO;
    [self.activityView removeFromSuperview];
    self.pagedEvents = events;
    [self loadSections];
    [self.eventsTableView reloadData];
}

- (void)loadSections
{
    if(refreshControl.refreshing) {
        [refreshControl endRefreshing];
    }
    
    for (Event *event in self.pagedEvents.events) {
        switch ([self.segmentedControl selectedSegmentIndex]) {
            case 0:
                break;
            case 1:
                if (![event.type isEqualToString:@"Festa"]) continue;
                break;
            case 2:
                if (![event.type isEqualToString:@"Show"]) continue;
                break;
            default: break;
        }

        // Reduce event start date to date components (year, month, day)
        NSDate *eventDate = [self dateAtBeginningOfDayForDate:event.formattedDate];
        
        // If we don't yet have an array to hold the events for this day, create one
        NSMutableArray *eventsOnThisDay = [self.sections objectForKey:eventDate];
        if (eventsOnThisDay == nil) {
            eventsOnThisDay = [NSMutableArray array];
            
            // Use the reduced date as dictionary key to later retrieve the event list this day
            [self.sections setObject:eventsOnThisDay forKey:eventDate];
        }
        
        // Add the event to the list for this day
        [eventsOnThisDay addObject:event];
    }
    
    // Create a sorted list of days
    NSArray *unsortedDays = [self.sections allKeys];
    self.sortedDays = [unsortedDays sortedArrayUsingSelector:@selector(compare:)];
}

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDate *date = [self.sortedDays objectAtIndex:section];
    NSArray *evts = [self.sections objectForKey:date];

    if(![self.pagedEvents isLastPage] && section == self.sections.count - 1) {
        return evts.count + 1;
    }
    return evts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *date = [self.sortedDays objectAtIndex:section];
    return [self.sectionDateFormatter stringFromDate:date];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    
    headerView.backgroundColor = [UIColor colorWithHex:0x191919];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 20)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor colorWithHex:0x191919];
    label.textColor = [UIColor colorWithHex:0xafafaf];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0.f, 2.f);
    label.font = [UIFont boldSystemFontOfSize:14];
    
    [headerView addSubview:label];
    return headerView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventCell *eventCell = sender;
    EventDetailsViewController *destController = [segue destinationViewController];
    destController.event = eventCell.event;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *date = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *evts = [self.sections objectForKey:date];

    if(![self.pagedEvents isLastPage] && indexPath.row == evts.count) {
        [self.pagedEvents nextPage:^(PagedEvents *events) {
            self.pagedEvents = events;
            [self loadSections];
            [self.eventsTableView reloadData];
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    NSDate *eventDate = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:eventDate];
    
    if (indexPath.row < eventsOnThisDay.count) {
        Event *event = [eventsOnThisDay objectAtIndex:indexPath.row];
        cell.event = event;
    }
    else if (![self.pagedEvents isLastPage]){
        [cell showLoading];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
        //[self.events removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addButtonTapped:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Novo evento"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancelar"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Festa", @"Show", nil];
    
    // Show the sheet
    [sheet showInView:self.view];
}

- (IBAction)menuButtonTapped:(id)sender
{
    [self revealLeftSidebar:sender];
}

- (IBAction)filterValueChanged:(id)sender
{
    self.sections = [NSMutableDictionary dictionary];
    [self loadSections];
    [self.eventsTableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        NSLog(@"New party");
    }
    else if (buttonIndex == 1) {
        NSLog(@"New show");        
    }
}

#pragma mark -
#pragma mark Pull to Refresh

- (void)handleRefresh
{
	[self reloadAllData];
}

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

#pragma mark -
#pragma mark JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UIViewController
- (UIView *)viewForLeftSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    SidebarViewController *controller = self.leftSidebarViewController;
    if (!controller) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.leftSidebarViewController = [[SidebarViewController alloc] initWithCities:delegate.cities];
        self.leftSidebarViewController.sidebarDelegate = self;
        controller = self.leftSidebarViewController;
        controller.title = @"LeftSidebarViewController";
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    // Example to disable userInteraction on content view while sidebar is revealing
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

#pragma mark -
#pragma mark SidebarViewControllerDelegate

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath
{
    if(object) {
        [self reloadAllData:(NSString *)object];
    }
    [self revealLeftSidebar:nil];
}

@end
