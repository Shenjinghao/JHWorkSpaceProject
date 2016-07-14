//
//  IntelligenceAssistantTableViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "IntelligenceAssistantTableViewController.h"

@implementation IntelligenceAssistantTableViewController

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithQuery:nil];
    });
    return instance;
}

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}

@end
