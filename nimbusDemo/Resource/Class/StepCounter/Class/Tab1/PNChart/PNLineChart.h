//
//  PNLineChart.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define chartMargin     10
#define xLabelMargin    5
#define yLabelMargin    15
#define yLabelHeight    11

@interface PNLineChart : UIView

/**
 * This method will call and troke the line in animation
 */

//-(void)strokeChart;
-(void)strokeChartWithAnimation: (BOOL) animation;

- (void)hideLine;


@property (strong, nonatomic) NSArray * xLabels;
@property (strong, nonatomic) NSArray * yLabels;
@property (strong, nonatomic) NSArray * xValues;
@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic) CGFloat xLabelWidth;


@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic) CGPoint endPoint;
@property (nonatomic, assign) BOOL dataEnd;


@end