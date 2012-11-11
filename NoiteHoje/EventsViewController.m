//
//  EventViewController.m
//  Noite Hoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventsViewController.h"
#import "Event.h"
#import "EventCell.h"
#import "EventDetailsViewController.h"
#import "APIWrapper.h"
#import "UIColor+Extensions.h"
#import "EGORefreshTableHeaderView.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize events;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isLastPage = NO;
    
    self.navigationItem.title = @"Lista";
    
    UIImage *img = [UIImage imageNamed:@"MainBG.png"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:img];
    
    APIWrapper *apiWrapper = [[APIWrapper alloc] init];
    [apiWrapper requestWithCallback:^(NSArray *evts) {
        self.events = [[NSArray alloc] initWithArray:evts];
        [self loadSections];
        [self.eventsTableView reloadData];
    }];
    
    [self.eventsTableView setBackgroundView:bgView];
    
    self.sectionDateFormatter = [[NSDateFormatter alloc] init];
    [self.sectionDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [self.sectionDateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [self.sectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [self.cellDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"]];
    [self.cellDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.cellDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.eventsTableView.bounds.size.height,
                                                                                                      self.eventsTableView.frame.size.width,
                                                                                                      self.eventsTableView.frame.size.height)];
		view.delegate = self;
		[self.eventsTableView addSubview:view];
		_refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)loadSections
{
    self.sections = [NSMutableDictionary dictionary];
    for (Event *event in self.events)
    {
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

    if(!_isLastPage && section == self.sections.count - 1) {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    NSDate *eventDate = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:eventDate];
    
    if (indexPath.row < eventsOnThisDay.count) {
        Event *event = [eventsOnThisDay objectAtIndex:indexPath.row];
        cell.event = event;
    }
    else {
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

- (void)reloadTableViewDataSource
{
}

- (void)doneLoadingTableViewData
{
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return NO;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date];
}

@end
