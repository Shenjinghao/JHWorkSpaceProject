//
//  JHFontSettingArrowView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/8.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHFontSettingArrowView.h"

@implementation JHFontSettingArrowView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, RGBCOLOR_HEX(0x1C91E0).CGColor);    CGContextBeginPath(context);
    
    CGFloat topLineY = rect.size.height / 3;
    CGContextMoveToPoint(context, 0, topLineY);
    CGContextAddLineToPoint(context, rect.size.width, topLineY);
    CGContextAddLineToPoint(context, (rect.size.width * 5 / 6), 0);
    CGContextStrokePath(context);
    
    CGFloat bottomLineY = rect.size.height * 2 / 3;
    CGContextMoveToPoint(context, rect.size.width, bottomLineY);
    CGContextAddLineToPoint(context, 0, bottomLineY);
    CGContextAddLineToPoint(context, (rect.size.width / 6), rect.size.height);
    CGContextStrokePath(context);
}

@end
