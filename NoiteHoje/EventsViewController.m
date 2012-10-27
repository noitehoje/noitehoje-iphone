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

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize events;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"MainBG.png"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:img];
    
    [self.eventsTableView setBackgroundView:bgView];
    
    self.events = [NSMutableArray arrayWithCapacity:20];
    Event *event = [[Event alloc] init];
    event.title = @"Nightwish";
    event.subtitle = @"Bar Opinião";
    event.date = @"4 de Setembro";
    event.time = @"22h";
    [self.events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Club688";
    event.subtitle = @"Loco Dice and Friends";
    event.date = @"5 de Setembro";
    event.time = @"23h";
    [self.events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Segredo";
    event.subtitle = @"Quarta Sertanejo Universitário";
    event.date = @"7 de Setembro";
    event.time = @"23:30";
    [self.events addObject: event];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 	return [events count];
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
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    cell.event = event;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[self.events removeObjectAtIndex:indexPath.row];
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

@end
