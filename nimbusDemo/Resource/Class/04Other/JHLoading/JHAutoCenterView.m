//
//  JHAutoCenterView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/5.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHAutoCenterView.h"

@implementation JHAutoCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addKeyboardEvents];
    }
    return self;
}

#pragma mark 添加键盘事件
- (void)addKeyboardEvents
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePosition) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePosition) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePosition) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePosition) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePosition) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

- (void)updatePosition
{
    CGRect rect = JHNavigationFrame();
    if ([JHUtility JHIsKeyboardVisible]) {
        rect.size.height -= JHKeyboardHeightForOrientation(UIInterfaceOrientationPortrait);
    }
    self.center = CGPointMake(CGRectGetWidth(rect) / 2, rect.origin.y + CGRectGetHeight(rect) / 2);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
