//
//  JHAPIHost.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/21.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHAPIHost.h"

@implementation JHAPIHost

+ (instancetype)sharedInstance
{
    static JHAPIHost *instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instace = [[JHAPIHost alloc] init];
    });
    return instace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  拼接的短链接的头
         */
        _apiHost = [JHUtility userDefaultObjectForKey:kDefaultApiHostKey];
        if (_apiHost == nil) {
            _apiHost = kDefaultApiHost;
        }
    }
    return self;
}


@end
