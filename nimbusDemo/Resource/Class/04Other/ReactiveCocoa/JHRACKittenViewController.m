//
//  JHRACKittenViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/1/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHRACKittenViewController.h"

@implementation JHRACKittenViewController
{
    NSString *_title;
}


- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        _title = query[@"title"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = _title;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"kitten.jpg"]];
    
}

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(KittenBlock)completeBlock
{
    double delayInSeconds = 0.7;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)delayInSeconds *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        BOOL success = [username isEqualToString:@"user"] && [password isEqualToString:@"password"];
        completeBlock(success);
    });
}

- (void)dealloc
{
    
}

@end
