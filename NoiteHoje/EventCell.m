//
//  EventCell.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 8/31/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+Extensions.h"

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    UIImage *img = [UIImage imageNamed:@"RowCellBG.png"];
    UIImage *highlightedImg = [UIImage imageNamed:@"RowCellSelectedBG.png"];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:img];
    UIImageView *highlightedView = [[UIImageView alloc] initWithImage:highlightedImg];

    self.backgroundView = bgView;
    self.selectedBackgroundView = highlightedView;
}

- (void)setEvent:(Event *)event
{
    _event = event;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.y = 0;
    self.titleLabel.frame = titleFrame;
    CGRect frame = self.thumbImageView.frame;
    frame.size.width = 68;
    frame.size.height = 58;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.thumbImageView.frame = frame;
    self.titleLabel.text = event.title;
    self.subtitleLabel.text = [event relativeDistance];
    self.venueLabel.text = event.venue.name;
    self.thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbImageView.clipsToBounds = YES;
    self.thumbImageView.backgroundColor = [UIColor colorWithHex:0x191a1f];
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:event.flyerUrl]];
}

- (void)showLoading
{
    self.titleLabel.text = @"Carregando...";
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.y = 18;
    self.titleLabel.frame = titleFrame;
    self.venueLabel.text = @"";
    self.subtitleLabel.text = @"";

    self.accessoryType = UITableViewCellAccessoryNone;
    self.thumbImageView.backgroundColor = [UIColor clearColor];
    self.thumbImageView.animationImages = @[
        [UIImage imageNamed:@"loading0.gif"],
        [UIImage imageNamed:@"loading1.gif"],
        [UIImage imageNamed:@"loading2.gif"],
        [UIImage imageNamed:@"loading3.gif"],
        [UIImage imageNamed:@"loading4.gif"],
        [UIImage imageNamed:@"loading5.gif"],
        [UIImage imageNamed:@"loading6.gif"],
        [UIImage imageNamed:@"loading7.gif"]
    ];
    self.thumbImageView.animationDuration = 0.7f;
    CGRect frame = self.thumbImageView.frame;
    frame.size.width = 25;
    frame.size.height = 25;
    frame.origin.x = 23;
    frame.origin.y = 15;
    self.thumbImageView.frame = frame;
    self.thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.thumbImageView startAnimating];
}

@end
