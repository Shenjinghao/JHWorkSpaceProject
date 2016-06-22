//
//  JHTopBannerViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTopBannerViewController.h"
#import "JHFilledColorButton.h"
#import "JHTopYellowBannerManager.h"
#import <ReactiveCocoa.h>
#import "JHWebViewController.h"

@implementation JHTopBannerViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"小黄条";
    [self creatViews];
}

- (void)creatViews
{
    CGRect frame = self.view.frame;
    frame.size.height -= 50.0f;
    JHFilledColorButton *btn = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, frame.size.height, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:COLOR_A10 enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"展示" fontSize:16 isBold:NO];
    [self.view addSubview:btn];
    [[[btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:btn.rac_willDeallocSignal] subscribeNext:^(id x) {
        [[JHTopYellowBannerManager sharedInstance] showTopBannerViewWithUserInfo:[self getTheUserInfo] actionBlock:^{
            //点击后干什么
            JHWebViewController *VC = [[JHWebViewController alloc] initWithUrl:@"wwww.baidu.com" title:@"测试小黄条"];
            [self.navigationController pushViewController:VC animated:YES];
        }];
    }];
}

- (NSDictionary *)getTheUserInfo
{
    NSDictionary *dict = @{@"title":@"你就这样的出现！！！"};
    return dict;
}

@end
