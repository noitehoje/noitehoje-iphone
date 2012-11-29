//
//  SidebarViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/16/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "SidebarViewController.h"
#import "SidebarCell.h"
#import "UIColor+Extensions.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (id)initWithCities:(NSArray *)cities
{
    self = [super init];
    if(self) {
        _cities = cities;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:SidebarCell.class forCellReuseIdentifier:@"SidebarCell"];
    self.tableView.separatorColor = [UIColor colorWithHex:0x020102];
    self.tableView.backgroundColor = [UIColor colorWithHex:0x211121];

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    self.searchBar.tintColor = [UIColor colorWithHex:0x211121];
    self.searchBar.placeholder = @"Buscar";
    self.tableView.tableHeaderView = self.searchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 1;
    }
    return _cities.count + 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return @"";
    }
    return @"MENU";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 0.0;
    }
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sidebarDelegate sidebarViewController:self didSelectObject:nil atIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return nil;
    }

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, tableView.bounds.size.width - 10, 20)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor colorWithHex:0x191919];
    label.textColor = [UIColor colorWithHex:0xc2acc2];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0.f, 2.f);
    label.font = [UIFont boldSystemFontOfSize:13];
    
    [headerView addSubview:label];
    headerView.backgroundColor = [UIColor colorWithHex:0x191919];
    
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SidebarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SidebarCell"];
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        if([[FBSession activeSession] isOpen]) {
            FBRequest *me = [FBRequest requestForMe];
            [me startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *my, NSError *error) {
                cell.label.text = my.name;
                NSLog(@"id = %@", my.id);
                FBProfilePictureView *avatar = [[FBProfilePictureView alloc] initWithFrame:cell.icon.frame];
                avatar.profileID = my.id;
                [cell.icon addSubview:avatar];
            }];
        }
    }
    else {
        if(indexPath.row == 0) {
            cell.label.text = @"Festas";
        }
        else if(indexPath.row == 1) {
            cell.label.text = @"Shows";
        }
        else {
            cell.label.text = _cities[indexPath.row - 2];
        }
    }
    
    return cell;
}

@end
