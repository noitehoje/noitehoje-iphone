//
//  SidebarViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/16/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "SidebarViewController.h"
#import "SidebarCell.h"
#import "User.h"
#import "NHApplication.h"
#import "UIColor+Extensions.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>
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

/* Eliminate empty footer: http://stackoverflow.com/questions/1369831/eliminate-extra-separators-below-uitableview-in-iphone-sdk */
- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // To "clear" the footer view
    return [UIView new];
}
/* End hack */

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
    
    if(indexPath.section == 0) {
        // skip User Name, Festas and Shows
        object = nil;
    }
    else if(indexPath.section == 2) {
        object = @"Logout";
    }
    
    [_selectedCell removeIcon];
    [cell setCellIconImage:@"CitySelector"];
    _selectedCell = cell;
    
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
        NHApplication *app = [NHApplication instance];
        User *user = app.currentUser;
        cell.label.text = [user displayName];
        [cell setCellIconView:[user avatarImageWithRect:CGRectMake(5, 8, 30, 30)]];
    }
    else if(indexPath.section == 2){
        cell.label.text = @"Sair";
        [cell setCellIconImage:@"LogoutIcon"];
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0) {
            [cell setCellIconImage:@"CitySelector"];
            _selectedCell = cell;
        }
        cell.label.text = _cities[indexPath.row];
    }

    
    return cell;
}

@end
