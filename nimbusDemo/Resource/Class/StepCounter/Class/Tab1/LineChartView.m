//
//  LineChartView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/9/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "LineChartView.h"

@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *xValues = [NSMutableArray array];
        NSMutableArray *yValuse = [NSMutableArray array];
        NSMutableArray *xLabels = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i ++) {
            [xValues addObject:@(i)];
            [yValuse addObject:@(i * 10000)];
            [xLabels addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        
        self.xValues = xValues;
        self.yValues = yValuse;
        self.xLabels = xLabels;
    }
    return self;
}

@end
