//
//  JHDateBaseManager.m
//  测试Demo
//
//  Created by Shenjinghao on 2017/1/22.
//  Copyright © 2017年 Shenjinghao. All rights reserved.
//

#import "JHDateBaseManager.h"

@implementation JHDateBaseManager

+ (instancetype) sharedInstance
{
    static JHDateBaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHDateBaseManager alloc] init];
    });
    return manager;
}

@end
