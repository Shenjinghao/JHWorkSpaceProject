//
//  JHBlockViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/1/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHBlockViewController.h"

typedef NSString *(^inToStrBlock1)(NSUInteger number);


@implementation JHBlockViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Block";
    
    [self creatView];
}

- (void) creatView
{
    //独立Block 使用方式
    NSString *(^inToStrBlock)(NSUInteger) = ^(NSUInteger number){
        NSString *result = [NSString stringWithFormat:@"%ld",number];
        return result;
    };
    
    NSString *str = inToStrBlock(10);
    NIDPRINT(@"%@",str);
    
    //将Block Object 当作参数，在方法之间传递，调用
    NSString* str1 = [self inToStr:110 withBlcok:inToStrBlock];
    NIDPRINT(@"%@",str1);
    
    //内联Block!!!
    
    
}

- (NSString *)inToStr:(NSUInteger)number withBlcok:(inToStrBlock1)block
{
    return block(number);
}


- (void)dealloc
{
    
}


@end



