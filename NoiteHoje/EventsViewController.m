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

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize events;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.events = [NSMutableArray arrayWithCapacity:20];
    Event *event = [[Event alloc] init];
    event.title = @"Nightwish";
    event.subtitle = @"Bar Opinião";
    event.date = @"4 de Setembro";
    [self.events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Club688";
    event.subtitle = @"Loco Dice and Friends";
    event.date = @"5 de Setembro";
    [self.events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Segredo";
    event.subtitle = @"Quarta Sertanejo Universitário";
    event.date = @"7 de Setembro";
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    Event *event = [self.events objectAtIndex:indexPath.row];
    cell.titleLabel.text = event.title;
    cell.subtitleLabel.text = event.subtitle;
    UIImageView * favoriteImageView = (UIImageView *)[cell viewWithTag:102];
    favoriteImageView.image = [UIImage imageNamed:@"star.png"];
    
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
