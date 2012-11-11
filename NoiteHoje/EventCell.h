//
//  EventCell.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 8/31/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCell : UITableViewCell

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

@end
