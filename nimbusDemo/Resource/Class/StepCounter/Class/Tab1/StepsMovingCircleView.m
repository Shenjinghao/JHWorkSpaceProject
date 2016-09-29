//
//  StepsMovingCircleView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/9/26.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "StepsMovingCircleView.h"
#import "AnimatedCircle.h"
#import "UICountingLabel.h"


static const NSInteger kFullSteps = 5000;

@interface StepsMovingCircleView ()

@property (nonatomic, strong) UICountingLabel *tickerLabel;    // 跳动的步数

@end

@implementation StepsMovingCircleView
{
    AnimatedCircle* _animationView;   // 负责动画的圆
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _steps = 4321;
        
        _animationView = [[AnimatedCircle alloc] initWithFrame:self.bounds];
        _animationView.initAngle = M_PI * 0.5;
        _animationView.speed = 0.8;
        _animationView.backgroundImage = @"step_round_back.png";
        _animationView.foregroundImage = @"step_round_back_color.png";
        [self addSubview:_animationView];
        
        _tickerLabel = [[UICountingLabel alloc] initWithFrame: CGRectMake(0, self.height/2 - 20, self.width, 60)];
        if (IOSOVER(7)) {
            _tickerLabel.centerY = self.height / 2;
        }
        
        // iOs6和iOs7下的字体的大小不一样，需要特别注意
        UIFont* tickerFont = [UIFont fontWithName:@"HiraKakuProN-W3" size:40];

        _tickerLabel.backgroundColor = [UIColor clearColor];
        _tickerLabel.font = tickerFont;
        _tickerLabel.format = @"%.0f";
        _tickerLabel.textAlignment = NSTextAlignmentCenter;
        _tickerLabel.text = @"0";
        
        [self addSubview: _tickerLabel];
        
        [self startAnimation];
    }
    return self;
}

//
// 刚开始时候的动画
//
- (void) startAnimation {
    CGFloat duration = [_animationView animationToPosition: (CGFloat)_steps / kFullSteps];
    duration = MAX(duration, 1.0);
    [_tickerLabel countFrom:0 to:_steps withDuration:duration];
}



@end
