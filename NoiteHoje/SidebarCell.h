//
//  SidebarCell.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 11/17/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarCell : UITableViewCell

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIView *icon;

- (void)setPadding:(NSUInteger)padding;
- (void)setCellIconImage:(NSString *)imageName;
- (void)setCellIconView:(UIView *)view;
- (void)removeIcon;

@end
