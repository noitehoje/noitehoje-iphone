//
//  LoginViewController.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 9/7/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface LoginViewController : GAITrackedViewController

- (IBAction)onFacebookLoginButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *privacyWarning;

@end
