//
//  UIColor+Appearance.h
//  Secoo-iPhone
//
//  Created by tuhaisheng on 16/12/28.
//  Copyright © 2016年 tuhaisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Appearance)

// 根据key来获取颜色 (alpha 默认为 1)
+ (UIColor *)mdf_colorForKey:(NSString *)key;

// 根据key 与 alpha 来获取颜色
+ (UIColor *)mdf_colorForKey:(NSString *)key alpha:(CGFloat)alpha;

// 随机颜色
+ (UIColor *)mdf_randomColor;

@end
