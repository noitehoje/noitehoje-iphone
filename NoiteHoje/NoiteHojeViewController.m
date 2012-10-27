//
//  NoiteHojeViewController.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "NoiteHojeViewController.h"

@interface NoiteHojeViewController ()

@end

@implementation NoiteHojeViewController

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
    
    UIImage *titleImg = [UIImage imageNamed:@"NavigationBarLogo.png"];
    UIImageView *barTitle = [[UIImageView alloc] initWithImage:titleImg];
    
    self.navigationItem.titleView = barTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
