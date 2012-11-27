//
//  LoginViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 9/7/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(sessionStateChanged:)
        name:FBSessionStateChangedNotification
        object:nil];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self performSegueWithIdentifier:@"LoginSuccessSegue" sender:self];
    }
    else {
        // failed to authorize the user via Facebook
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onFacebookLoginButtonClicked:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [appDelegate openSessionWithAllowLoginUI:YES];
    
//    [FBSession openActiveSessionWithPermissions:nil
//                                   allowLoginUI:YES
//                              completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
//                                  if (session.isOpen) {
//                                      FBRequest *me = [FBRequest requestForMe];
//                                      [me startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *my, NSError *error) {
//                                          NSEnumerator *enumerator = [my keyEnumerator];
//                                          id key;
//                                          while ((key = [enumerator nextObject])){
//                                              //NSLog(@"%@ - %@", key, [my objectForKey: key]);
//                                          }
//                                      }];
//                                  }
//                              }];
}
@end
