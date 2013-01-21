//
//  EventCell.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 8/31/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventCell.h"
#import <QuartzCore/QuartzCore.h>
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
    titleFrame.origin.y = 10;
    self.titleLabel.frame = titleFrame;
    CGRect frame = self.thumbImageView.frame;
    frame.size.width = 68;
    frame.size.height = 58;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.thumbImageView.frame = frame;
    self.thumbImageView.hidden = NO;
    _activityView.hidden = YES;
    [_activityView stopAnimating];
    self.titleLabel.text = event.title;
    self.subtitleLabel.text = [event relativeDistance];
    self.venueLabel.text = event.venue.name;
    self.thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbImageView.clipsToBounds = YES;
    self.thumbImageView.backgroundColor = [UIColor colorWithHex:0x191a1f];

    if(event.flyerUrl && ![event.flyerUrl isEqual:[NSNull null]]) {
        [self.thumbImageView setImageWithURL:[NSURL URLWithString:event.flyerUrl]];
    }
    else {
        [self.thumbImageView setImage:[UIImage imageNamed:@"RowImagePlaceHolder.png"]];
    }
}

- (void)showLoading
{
    self.titleLabel.text = @"Carregando...";
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.y = 20;
    self.titleLabel.frame = titleFrame;
    self.venueLabel.text = @"";
    self.subtitleLabel.text = @"";
    self.accessoryType = UITableViewCellAccessoryNone;
    self.thumbImageView.hidden = YES;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityView.frame = CGRectMake(15, 15, 30, 30);
    _activityView.hidden = NO;
    [self addSubview:_activityView];
    [_activityView startAnimating];
}

@end
