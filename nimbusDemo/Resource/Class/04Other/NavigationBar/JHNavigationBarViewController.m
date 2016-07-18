//
//  JHNavigationBarViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHNavigationBarViewController.h"
#import <ReactiveCocoa.h>
#import "JHNavigationBarVC1.h"
#import "JHNavigationBarVC2.h"


@implementation JHNavigationBarViewController

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
    
    JHFilledColorButton *btn1 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, 300, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"动态修改UINavigationBar的背景色" fontSize:16 isBold:NO];
    
    WEAK_VAR(self);
    [[[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:btn1.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        JHNavigationBarVC1 *VC = [[JHNavigationBarVC1 alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    [self.view addSubview:btn1];
    
    JHFilledColorButton *btn2 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, btn1. bottom + 20, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"动态修改UINavigationBar的背景色" fontSize:16 isBold:NO];
    
    [[[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:btn1.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        JHNavigationBarVC2 *VC = [[JHNavigationBarVC2 alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    [self.view addSubview:btn2];
    
}

@end
