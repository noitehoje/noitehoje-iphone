//
//  UIColor+Extensions.h
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CGComponentIndexRed = 0,
    CGComponentIndexGreen,
    CGComponentIndexBlue,
    CGComponentIndexAlpha,
    CGComponentIndexCount,
} CGComponentIndex;

#pragma mark -

@interface UIColor (Extensions)

@property (readonly) CGFloat red;
@property (readonly) CGFloat green;
@property (readonly) CGFloat blue;
@property (readonly) CGFloat alpha;

+ (UIColor *)colorWithHex:(NSInteger)value;
+ (UIColor *)colorWithHex:(NSInteger)colorValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRedInteger:(UInt8)red greenInteger:(UInt8)green blueInteger:(UInt8)blue alpha:(CGFloat)alpha;

- (CGFloat)colorFromComponentIndex:(NSInteger)index;

- (BOOL)isEqualToColor:(UIColor *)otherColor;

@end
