//
//  EventCell.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 8/31/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "EventCell.h"

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

@end
