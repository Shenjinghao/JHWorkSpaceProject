//
//  UINavigationBar+JHDynamicChangeNavigationBar.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (JHDynamicChangeNavigationBar)

- (void)jh_setBackgroundColor:(UIColor *)backgroundColor;
- (void)jh_setElementsAlpha:(CGFloat)alpha;
- (void)jh_setTranslationY:(CGFloat)translationY;
- (void)jh_reset;

@end
