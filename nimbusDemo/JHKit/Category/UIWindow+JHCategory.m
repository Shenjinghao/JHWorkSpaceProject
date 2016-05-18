//
//  UIWindow+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/15.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIWindow+JHCategory.h"

@implementation UIWindow (JHCategory)

- (UIView *)findFirstResponder
{
    return [self findFirstResponderInView:self];
}

- (UIView *)findFirstResponderInView:(UIView *)topView
{
    if ([topView isFirstResponder]) {
        return topView;
    }
    for (UIView *subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        UIView *firstResponderView = [self findFirstResponderInView:subView];
        if (firstResponderView != nil) {
            return firstResponderView;
        }
    }
    return nil;
}


@end


