//
//  LoginViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 9/7/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "NHApplication.h"
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>

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
    
    self.privacyWarning.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.privacyWarning.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.privacyWarning.layer.shadowOpacity = 1.0f;
    self.privacyWarning.layer.shadowRadius = 1.0f;
    CGRect frame = self.privacyWarning.frame;
    frame.origin.y = self.view.frame.size.height - frame.size.height - 10;
    self.privacyWarning.frame = frame;
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self performSegueWithIdentifier:@"LoginSuccessSegue" sender:self];
    }
    else {
        // Failed to authorize the user via Facebook
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
}
@end
