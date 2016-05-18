//
//  JHHomeViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHTabBarController.h"

@implementation JHHomeViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
        self.hidesBackButton = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    JHTabBarController *VC = (JHTabBarController *)self.tabBarController;
    [VC setBadgeNumberAtIndex:0 value:33];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBackButton = YES;
}

- (NSString *)tabTitle {
    return @"首页";
}

- (NSString *)tabImageName {
    return @"tabbar_home_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_home";
}


@end
