//
//  JHLoadingViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/5.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHLoadingViewController.h"
#import "JHFilledColorButton.h"
#import "JHLoadingVIew.h"
#import <ReactiveCocoa.h>

@implementation JHLoadingViewController

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView
{
    JHLoadingVIew *view = [[JHLoadingVIew alloc] initWithFrame:CGRectMake((viewWidth() - 120) / 2, 120, 120, 120)];
    view.isAnimating = YES;
    
    JHFilledColorButton *btn1 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, 300, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"展示" fontSize:16 isBold:NO];
    
    WEAK_VAR(self);
    [[[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:btn1.rac_willDeallocSignal] subscribeNext:^(id x) {
        [_self.view addSubview:view];
    }];
    [self.view addSubview:btn1];
    
    JHFilledColorButton *btn2 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, btn1. bottom + 20, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"去掉" fontSize:16 isBold:NO];
    
    [[[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:btn1.rac_willDeallocSignal] subscribeNext:^(id x) {
        [view removeFromSuperview];
    }];
    [self.view addSubview:btn2];
    
}

@end
