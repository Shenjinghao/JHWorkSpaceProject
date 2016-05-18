//
//  JHPatientViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHPatientViewController.h"

@implementation JHPatientViewController

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
    self.title = @"患者";
}

- (NSString *)tabTitle {
    return @"患者";
}

- (NSString *)tabImageName {
    return @"tabbar_patient_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_patient";
}


@end
