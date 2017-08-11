//
//  UIColor+Appearance.m
//  Secoo-iPhone
//
//  Created by tuhaisheng on 16/12/28.
//  Copyright © 2016年 tuhaisheng. All rights reserved.
//

#import "UIColor+Appearance.h"

@implementation UIColor (Appearance)

+ (UIColor *)mdf_colorForKey:(NSString *)key
{
    return [self mdf_colorForKey:key alpha:1.0f];
}

+ (UIColor *)mdf_colorForKey:(NSString *)key alpha:(CGFloat)alpha
{
    return [UIColor mdf_colourWithHexString:key alpha:alpha];
}

+ (UIColor *)mdf_randomColor
{
  CGFloat r = arc4random() % 256 / 255.0;
  CGFloat g = arc4random() % 256 / 255.0;
  CGFloat b = arc4random() % 256 / 255.0;
  return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#pragma mark - Others

+ (UIColor *)mdf_colourWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)mdf_colourWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor mdf_colourWithRGBHex:hexNum alpha:alpha];
}

@end
