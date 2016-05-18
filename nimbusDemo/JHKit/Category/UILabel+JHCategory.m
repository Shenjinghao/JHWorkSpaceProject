//
//  UILabel+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UILabel+JHCategory.h"

@implementation UILabel (JHCategory)


+ (UILabel*) labelWithFontSize: (CGFloat)fontSize fontColor:(UIColor *)color text: (NSString *)text {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    
    [label adjustFontSize:fontSize withMultiple:1.1];
    
    label.text = text;
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (NSInteger) fontsize
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    [label adjustFontSize:fontsize withMultiple:1.1];
    
    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize: fontsize];
    
    [label adjustFontSize:fontsize withMultiple:1.1];
    
    return label;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text {
    
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    
    label.text = text;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize: fontsize];
    
    [label adjustFontSize:fontsize withMultiple:1.1];
    
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
                   fontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text
                   multiple: (CGFloat) multiple {
    UILabel *label = [UILabel labelWithFrame:frame fontSize:fontsize fontColor:color text:text];
    
    [label adjustFontSize:fontsize withMultiple:multiple];
    
    return label;
}

+ (UILabel*) labelWithFrame: (CGRect) frame
               boldFontSize: (NSInteger) fontsize
                  fontColor: (UIColor*) color
                       text: (NSString*) text
                   multiple: (CGFloat) multiple {
    UILabel *label = [UILabel labelWithFrame:frame boldFontSize:fontsize fontColor:color text:text];
    
    [label adjustFontSize:fontsize withMultiple:multiple];
    
    return label;
}

- (void)adjustFontSize:(CGFloat)fontSize withMultiple:(CGFloat)multiple {
#ifdef INC_FONT_SIZE_FOR_6PLUS
    
    if (_IPHONE6PLUS_) {
        self.font = [UIFont systemFontOfSize:fontSize * multiple];
    }
#endif
}



@end
