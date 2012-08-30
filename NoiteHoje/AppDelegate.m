//
//  br_com_noitehojeAppDelegate.m
//  NoiteHoje
//
//  Created by felipe on 8/12/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "AppDelegate.h"
#import "Event.h"
#import "EventsViewController.h"

@implementation AppDelegate

NSMutableArray *events;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    events = [NSMutableArray arrayWithCapacity:20];
    Event *event = [[Event alloc] init];
    event.title = @"Centidel Babbleset";
    event.subtitle = @"53170 Ridge Oak Plaza - Emeryville, MN";
    event.date = @"4 de Setembro";
    [events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Devshare Browsebug";
    event.subtitle = @"6985 Dwight Street - Ukiah, PA";
    event.date = @"5 de Setembro";
    [events addObject: event];
    
    event = [[Event alloc] init];
    event.title = @"Eidel Innotype";
    event.subtitle = @"3 Armistice Pass - Upland, ND";
    event.date = @"7 de Setembro";
    [events addObject: event];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
	UINavigationController *navigationController = [[tabBarController viewControllers] objectAtIndex:0];
	EventsViewController *eventsViewController   = [[navigationController viewControllers] objectAtIndex:0];
	eventsViewController.events = events;
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
