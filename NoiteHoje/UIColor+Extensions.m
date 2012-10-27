//
//  UIColor+Extensions.m
//  NoiteHoje-v2
//
//  Created by Felipe Lima on 10/27/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (SIExtension)

+ (UIColor *)colorWithHex:(NSInteger)value
{
    return [UIColor colorWithHex:value alpha:1.f];
}

+ (UIColor *)colorWithHex:(NSInteger)value alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((CGFloat)((value & 0xFF0000) >> 16))/255.0
                           green:((CGFloat)((value & 0xFF00) >> 8))/255.0
                            blue:((CGFloat)(value & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithRedInteger:(UInt8)red greenInteger:(UInt8)green blueInteger:(UInt8)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)red / 255.f
                           green:(CGFloat)green / 255.f
                            blue:(CGFloat)blue / 255.f
                           alpha:alpha];
}

- (CGFloat)colorFromComponentIndex:(NSInteger)index
{
    CGColorRef colorStruct = [self CGColor];
    if (CGColorGetNumberOfComponents(colorStruct) != CGComponentIndexCount)
        [NSException raise:NSInvalidArgumentException format:@"Invalid argument '%d'", index];
    
    const CGFloat *components = CGColorGetComponents(colorStruct);
    return components[index];
}

- (CGFloat)red
{
    return [self colorFromComponentIndex:CGComponentIndexRed];
}

- (CGFloat)green
{
    return [self colorFromComponentIndex:CGComponentIndexGreen];
}

- (CGFloat)blue
{
    return [self colorFromComponentIndex:CGComponentIndexBlue];
}

- (CGFloat)alpha
{
    return [self colorFromComponentIndex:CGComponentIndexAlpha];
}

- (BOOL)isEqualToColor:(UIColor *)otherColor
{
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color)
    {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome)
        {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate(colorSpaceRGB, components);
            UIColor * retVal = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return retVal;
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];
}

@end
