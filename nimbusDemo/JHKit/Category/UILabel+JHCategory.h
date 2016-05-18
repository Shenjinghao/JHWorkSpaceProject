//
//  UILabel+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JHCategory)


// 创建一个指定frame和字体的label
// 背景为透明，左对其, 颜色为系统默认
+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (NSInteger) fontsize text: (NSString*) text;
+ (UILabel*) labelWithFrame: (CGRect) frame fontSize: (NSInteger) fontsize fontColor: (UIColor*) color text: (NSString*) text;

+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text;

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text;

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text
                   multiple: (CGFloat) multiple;

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text
                   multiple: (CGFloat) multiple;


- (void)adjustFontSize:(CGFloat)fontSize withMultiple:(CGFloat)multiple;


@end
