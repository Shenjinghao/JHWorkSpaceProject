//
//  JHLineSeparator.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHLineSeparator.h"

@implementation JHLineSeparator

+ (UIImageView *)lineWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    iv.backgroundColor = color;
    return iv;
}

+ (UIImageView *)lineWithPattern:(NSString *)name width:(NSInteger)width height:(NSInteger)height {
    return [self lineWithColor:[UIColor colorWithPatternImage:[UIImage imageNamed:name]] width:width height:height];
}

+ (UIImageView *)lineWithColor:(UIColor *)color width:(CGFloat)width {
    return [self lineWithColor:color width:width height:0.5];
}

@end
