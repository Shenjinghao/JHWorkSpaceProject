//
//  JHLineSeparator.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHLineSeparator : NSObject


+ (UIImageView *)lineWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;
+ (UIImageView *)lineWithColor:(UIColor *)color width:(CGFloat)width;

+ (UIImageView *)lineWithPattern:(NSString *)name width:(NSInteger)width height:(NSInteger)height;


@end
