//
//  EventDetailsCell.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventDetailsCell.h"

@implementation EventDetailsCell

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

    UIImage *rowBackground = [UIImage imageNamed:@"RowCellBG.png"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:rowBackground];
    self.backgroundView = bgView;
    
    self.textLabel.font = [UIFont systemFontOfSize:17];
    self.textLabel.opaque = NO;
    self.textLabel.clearsContextBeforeDrawing = NO;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
}

@end
