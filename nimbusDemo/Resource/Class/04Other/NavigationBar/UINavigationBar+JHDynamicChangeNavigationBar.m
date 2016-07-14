//
//  UINavigationBar+JHDynamicChangeNavigationBar.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "UINavigationBar+JHDynamicChangeNavigationBar.h"

/**
 *  具体解析请看http://www.cocoachina.com/ios/20150409/11505.html
 */

@implementation UINavigationBar (JHDynamicChangeNavigationBar)

/**
 *  先创建个属性
 */
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark 将overlay作为navigation的backview
- (void)jh_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)jh_setElementsAlpha:(CGFloat)alpha
{
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.alpha = alpha;
        *stop = YES;
    }];
}

- (void)jh_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)jh_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
