//
//  SidebarViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/16/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SidebarViewControllerDelegate;

@interface SidebarViewController : UITableViewController

@property (nonatomic, assign) id <SidebarViewControllerDelegate> sidebarDelegate;

@end


@protocol SidebarViewControllerDelegate <NSObject>

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController;

@end