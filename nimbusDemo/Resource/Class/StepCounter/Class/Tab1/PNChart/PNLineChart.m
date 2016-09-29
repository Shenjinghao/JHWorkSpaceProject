//
//  PNLineChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNLineChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"
#import <QuartzCore/QuartzCore.h>

#define kViewRatio (viewWidth()/320)

@implementation PNLineChart {
    UIView* _curveView;
    
    NSMutableArray* _xTextLabels;
    
    CGFloat _yValueMax;
    CGFloat _yHourWidth;
    
    UIImageView* _endPointView;
    
    CGFloat _gridYOffset;
    CGFloat _gridHeight;
}


//
// 期待宽度: 300px
//
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    
        
        _yHourWidth = kViewRatio * 280 / 24.0;
        _xLabelWidth = kViewRatio * 40;
        
        _curveView = [UIView viewWithFrame:self.bounds andBackgroundColor: [UIColor clearColor]];
        _curveView.clipsToBounds = YES;
        [self addSubview: _curveView];
        
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapRound;
		_chartLine.lineJoin = kCALineJoinBevel;
		_chartLine.fillColor   = [[UIColor whiteColor] CGColor];
		_chartLine.lineWidth   = 3.0;
		_chartLine.strokeEnd   = 0.0;

        _curveView.width = 0;
		[_curveView.layer addSublayer:_chartLine];
        
        
        _xTextLabels = [NSMutableArray array];
        
//        _endPointView = [CYResource loadImageView:@"step_end_pt.png" andFrame: CGRectMake(0, 0, 7, 7)];
        _endPointView = [UIImageView imageViewWithImageName:@"step_end_pt.png"];
        _endPointView.frame = CGRectMake(0, 0, 7, 7);
        [_curveView addSubview: _endPointView];
        
        // 上面空5像素，下面空20像素
        _gridYOffset = 5;
        _gridHeight = self.height - 25;
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues {
    _yValues = yValues;
    
    NSInteger max = 0;
    for (NSString * valueString in _yValues) {
        NSInteger value = [valueString intValue];
        if (value > max) {
            max = value;
        }
        
    }
    
    // Min value for Y label
    if (max < 5) {
        max = 5;
    }
    
//    NIDPRINT(@"yValues: %@, andMax: %d", yValues, max);
    _yValueMax = max;
}


-(void)setXLabels:(NSArray *)xLabels {
    
    for (PNChartLabel* label in _xTextLabels) {
        [label removeFromSuperview];
    }
    [_xTextLabels removeAllObjects];

    _xLabels = xLabels;

    UIFont* font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10];
    for (int i = 0; i < xLabels.count; i += 6) {
        NSString* labelText = xLabels[i];

        // 绘制: xLabels
        UILabel *label = [UILabel new];
        label.text = labelText;
        label.font = font;
        label.textColor = RGBCOLOR_HEX(0x2b5161);
        
        [_xTextLabels addObject: label];
        [self addSubview:label];
        
        [label sizeToFit];
        label.centerX = _xLabelWidth / 2 + (i / 6.0) * 70 * kViewRatio;
        label.top = _gridYOffset + _gridHeight + 9;
    }
    
}

// 绘制: Grid
- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xPosition = _xLabelWidth / 2;
    
    // 绘制24条细竖线
    for (int i = 0; i <= 24; i++) {
        if (i % 3 != 0) {
            CGFloat x = i * _yHourWidth + xPosition;
            CGContextMoveToPoint(context, x, _gridYOffset);
            CGContextAddLineToPoint(context, x, _gridYOffset + _gridHeight);
        }
    }
    
    // 绘制上面三条细模线
    CGFloat xStart = xPosition;
    CGFloat xEnd = xPosition + 24 * _yHourWidth;
    for (int i = 0; i < 3; i++) {
        CGFloat yOffset = _gridYOffset + _gridHeight / 3 * i;
        CGContextMoveToPoint(context, xStart, yOffset);
        CGContextAddLineToPoint(context, xEnd, yOffset);
    }
    
    // 填充细线
    CGContextSetStrokeColorWithColor(context, RGBACOLOR(0xdf, 0xde, 0xe3, 0.4).CGColor);
	//CGContextSetStrokeColorWithColor(context, RGBACOLOR(0xdf, 0xde, 0xe3, 0.2).CGColor);
	CGContextStrokePath(context);
    
    // 绘制8条粗竖线
    for (int i = 0; i <= 8; i++) {
        CGFloat x = i * _yHourWidth * 3 + xPosition;
        CGContextMoveToPoint(context, x, _gridYOffset);
        CGContextAddLineToPoint(context, x, _gridYOffset + _gridHeight);
    }
    
    // 绘制底下的一条粗线
    xStart = xPosition;
    xEnd = xPosition + 24 * _yHourWidth;
    CGFloat yOffset = _gridYOffset + _gridHeight;
    CGContextMoveToPoint(context, xStart, yOffset);
    CGContextAddLineToPoint(context, xEnd, yOffset);
    
    // 填充粗线
	CGContextSetStrokeColorWithColor(context, RGBACOLOR(0xdf, 0xde, 0xe3, 0.6).CGColor);
	CGContextStrokePath(context);
}

//
// 设置画笔的颜色
//
-(void)setStrokeColor:(UIColor *)strokeColor {
	_strokeColor = strokeColor;
	_chartLine.strokeColor = [strokeColor CGColor];
}

-(void)strokeChartWithAnimation: (BOOL) animation {
    _curveView.hidden = NO;
    
    // 只有在需要绘制的时候，才能调用 [Path fill]等操作，否则会有很多WARNING
    [self setNeedsDisplay];
    
    CGFloat xPosition = _xLabelWidth / 2;
    // _xLabelWidth / 2 + 1
    // (index * 259 / 24.0) + xPosition
    
    CGFloat gridBottom = _gridYOffset + _gridHeight;
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    // 首先移动到第一个点:
    CGPoint startPoint = CGPointMake(xPosition, gridBottom);
    [progressline moveToPoint: startPoint];
    
    progressline.lineWidth = 3.0;
    progressline.lineCapStyle = kCGLineCapRound;
    progressline.lineJoinStyle = kCGLineJoinRound;
    
    for (int index = 0; index < _yValues.count; index++) {
        NSInteger value = [_yValues[index] intValue];
        
        float grade = (float)value / (float)_yValueMax;
    
        CGFloat xValue = [_xValues[index] floatValue];
        CGFloat xOffset = xValue * _yHourWidth + xPosition;
        
        CGPoint pt = CGPointMake(xOffset, gridBottom - grade * _gridHeight);
        [progressline addLineToPoint:pt];
    }
        
//    if (_dataEnd) {
//        // 最后一个小时，按照区间统计就是没有数据
//        _endPoint = CGPointMake(_yHourWidth * _yValues.count + xPosition, gridBottom);
//    } else {
//
//    }
//
    _endPoint = CGPointMake(_yHourWidth * [_xValues.lastObject floatValue] + xPosition, gridBottom - [_yValues.lastObject intValue] / _yValueMax * _gridHeight);
    [progressline addLineToPoint: CGPointMake(_endPoint.x, gridBottom)];
    [progressline closePath];
    
    
    _endPointView.left = _endPoint.x - 3; // OK
    _endPointView.top = _endPoint.y - 3;
    
    UIColor* color = RGBCOLOR_HEX(0xcfeef0);
    
    _chartLine.path = progressline.CGPath;
    _chartLine.strokeColor = _strokeColor ? [_strokeColor CGColor] : [color CGColor];
    _chartLine.fillColor = [color CGColor];
    _chartLine.strokeEnd = 1.0;
    
    if (animation) {
        _curveView.width = 0;
    
        [UIView beginAnimations:nil context:nil];
        //设定动画持续时间
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
        _curveView.width = self.width;
        [UIView commitAnimations];
        
    } else {
        // 直接设置宽度
        _curveView.width = self.width;
    }
    
}

- (void)hideLine {
    _curveView.hidden = YES;
}

@end
