//
//  SidebarViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/16/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIWrapper.h"

@protocol SidebarViewControllerDelegate;

@class SidebarCell;

@interface SidebarViewController : UITableViewController
{
    NSArray *_cities;
    SidebarCell *_selectedCell;
}

@property (nonatomic, assign) id <SidebarViewControllerDelegate> sidebarDelegate;
@property (nonatomic, retain) UISearchBar *searchBar;

- (id)initWithCities:(NSArray *)cities;

@end


@protocol SidebarViewControllerDelegate <NSObject>

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController;

@end