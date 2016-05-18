//
//  JHServiceViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHServiceViewController.h"

@implementation JHServiceViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"服务";
}

- (NSString *)tabTitle {
    return @"服务";
}

- (NSString *)tabImageName {
    return @"tabbar_service_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_service";
}

@end
