//
//  SidebarCell.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/17/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "SidebarCell.h"
#import "UIColor+Extensions.h"

@implementation SidebarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 3, self.frame.size.width - 20, 40)];
        self.icon = [[UIView alloc] initWithFrame:CGRectMake(5, 3, 30, 30)];
    
        [self addSubview:self.label];
        [self addSubview:self.icon];
                     
        self.backgroundColor = [UIColor colorWithHex:0x211121];
        
        UIView *lineView = lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.bounds.size.width, 1.0f)];
                                       
        lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        lineView.backgroundColor = [UIColor colorWithHex:0x372937];

        [self addSubview:lineView];
        
        UIView *selectedBgview = [[UIView alloc] initWithFrame:self.frame];
        selectedBgview.backgroundColor = [UIColor colorWithHex:0x110011];
        self.selectedBackgroundView = selectedBgview;
    }
    return self;
}

- (void)setPadding:(NSUInteger)padding
{
    CGRect frame = self.label.frame;
    frame.origin.x = padding;
    self.label.frame = frame;
}

- (void)setCellIcon:(NSString *)imageName
{
    UIImage *icon = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:icon];
    CGRect frame = imageView.frame;
    frame.origin.x = 5;
    frame.origin.y = 7;
    imageView.frame = frame;
    [self addSubview:imageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor colorWithHex:0xc2acc2];
}

@end
