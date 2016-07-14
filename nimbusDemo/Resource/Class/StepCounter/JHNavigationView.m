//
//  JHNavigationView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#define kSpace 4  //四个按钮的间距

#import "JHNavigationView.h"

@implementation JHNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (IOSOVER(7)) {
        if (_isLeftButton) {
            insets = UIEdgeInsetsMake(0, kSpace, 0, 0);
        }else { // IF_ITS_A_RIGHT_BUTTON
            insets = UIEdgeInsetsMake(0, 0, 0, kSpace);
        }
    }
    return insets;
}

//
// naviBtn的点击区域过大导致用户手误，这里对点击区域做了限制
//
- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView: self];
    return CGRectContainsPoint(self.bounds, point);
}

@end


@implementation JHNavigationButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (IOSOVER(7)) {
        if (_isLeftButton) {
            insets = UIEdgeInsetsMake(0, kSpace, 0, 0);
        }else { // IF_ITS_A_RIGHT_BUTTON
            insets = UIEdgeInsetsMake(0, 0, 0, kSpace);
        }
    }
    return insets;
}

@end
