//
//  UIColor+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIColor+JHCategory.h"

@implementation UIColor (JHCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor*) viewBackgroundColor {
    static UIColor* color = nil;
    if (color == nil) {
        color = RGBCOLOR_HEX(0xf1f1f1);
//        color = [UIColor whiteColor];
    }
    return color;
}

@end
