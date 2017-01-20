//
//  JHMoveModel.m
//  测试Demo
//
//  Created by Shenjinghao on 2017/1/18.
//  Copyright © 2017年 Shenjinghao. All rights reserved.
//

#import "JHMoveModel.h"

@implementation JHMoveModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArray = [NSArray arrayWithObjects:
                         @{@"title": @"生活缴费"},
                         @{@"title": @"淘票票"},
                         @{@"title": @"股票"},
                         @{@"title": @"滴滴出行"},
                         @{@"title": @"红包"},
                         @{@"title": @"亲密付"},
                         @{@"title": @"生超市惠"},
                         @{@"title": @"我的快递"},
                         @{@"title": @"游戏中心"},
                         @{@"title": @"我的客服"},
                         @{@"title": @"爱心捐赠"},
                         @{@"title": @"亲情账户"},
                         @{@"title": @"淘宝"},
                         @{@"title": @"天猫"},
                         @{@"title": @"天猫超市"},
                         @{@"title": @"城市服务"},
                         @{@"title": @"保险服务"},
                         @{@"title": @"飞机票"}, nil];
        self.singleTag = [NSArray arrayWithObjects:@"100", @"101", @"102", @"103", @"104", @"105", @"106", @"107", @"108", @"109", @"110", @"111", @"112", @"113", @"114", @"115", @"116", @"117", nil];
    }
    return self;
}

@end
