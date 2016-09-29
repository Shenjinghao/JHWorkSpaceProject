//
//  StepsMainViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "StepsMainViewController.h"
#import "StepsMovingCircleView.h"
#import "UICountingLabel.h"
#import "LineChartView.h"

@interface StepsMainViewController ()

@property (nonatomic, strong) StepsMovingCircleView *movingCircleView;         // 步数的大圆


@end
#define kViewRatio (viewWidth()/320)

@implementation StepsMainViewController
{
    LineChartView *_lineChartView;    //折线图
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.movingCircleView];
    
    // 线图
    CGFloat lineChartTop = IS_iPhone4 ? self.movingCircleView.bottom + 20 : 290 * pow(kViewRatio, 1.3);
    lineChartTop -= 3;
    CGFloat lineChartHeight = IS_iPhone4 ? 83 : 103 * kViewRatio;
    _lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, lineChartTop, viewWidth() , lineChartHeight)];
    [self.view addSubview: _lineChartView];
}

#define kViewRatio (viewWidth()/320)
- (StepsMovingCircleView *)movingCircleView {
    if (_movingCircleView == nil) {
        CGFloat circleTop = IS_iPhone4 ? 38 : 52 * kViewRatio;
        CGFloat circleWidth = IS_iPhone4 ? 162 : 180 * kViewRatio;
        CGRect frame = CGRectMake(0, circleTop, circleWidth, circleWidth);
        _movingCircleView = [[StepsMovingCircleView alloc] initWithFrame: frame];
        _movingCircleView.centerX = self.view.width / 2;
    }
    return _movingCircleView;
}

@end
