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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 1;
    }
    else if(section == 2) {
        return 1;
    }
    return _cities.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return @"";
    }
    if(section == 2) {
        return @"OUTROS";
    }
    return @"CIDADES";
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
    SidebarCell *cell = (SidebarCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSObject *object = cell.label.text;
    
    if(indexPath.section == 0 || indexPath.row == 0 || indexPath.row == 1) {
        // skip User Name, Festas and Shows
        object = nil;
    }
    
    [self.sidebarDelegate sidebarViewController:self didSelectObject:object atIndexPath:indexPath];
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
    
    if(indexPath.section == 0) {
        if([[FBSession activeSession] isOpen]) {
            FBRequest *me = [FBRequest requestForMe];
            [me startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *my, NSError *error) {
                cell.label.text = my.name;
                FBProfilePictureView *avatar = [[FBProfilePictureView alloc] initWithFrame:cell.icon.frame];
                avatar.profileID = my.id;
                [cell.icon addSubview:avatar];
            }];
        }
    }
    else if(indexPath.section == 2){
        cell.label.text = @"Sair";
        [cell setCellIcon:@"LogoutIcon"];
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 1) {
            [cell setCellIcon:@"CitySelector"];
        }
        cell.label.text = _cities[indexPath.row];
    }

    
    return cell;
}

@end
