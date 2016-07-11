//
//  JHLoadingVIew.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/5.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHLoadingVIew.h"
#import <QuartzCore/QuartzCore.h>


@implementation JHLoadingVIew
{
    UIImageView* _backLogoView;
    UIImageView* _animationView;
    
    CABasicAnimation* _animation;
}

NSString * const kLoadingAnimation = @"kLoadingAnimation";

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame = CGRectMake((viewWidth() - 120) / 2, 120, 120, 120);
        [self creatLoadingView];
    }
    return self;
}

- (void)creatLoadingView
{
    _backLogoView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backLogoView.image = [UIImage imageNamed:@"loading_bkgnd.png"];
    
    _animationView = [[UIImageView alloc] initWithFrame:self.bounds];
    _animationView.image = [UIImage imageNamed:@"loading_circle.png"];
    
    _backLogoView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin
                                      | UIViewAutoresizingFlexibleTopMargin
                                      | UIViewAutoresizingFlexibleRightMargin
                                      | UIViewAutoresizingFlexibleBottomMargin);
    
    _animationView.autoresizingMask = _backLogoView.autoresizingMask;
    
    [self addSubview:_backLogoView];
    [self addSubview:_animationView];
}

- (void)setIsAnimating:(BOOL)isAnimating
{
    if (_isAnimating != isAnimating) {
        _isAnimating = isAnimating;
        if (_isAnimating) {
            if (!_animation) {
                _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
                _animation.fromValue = [NSNumber numberWithFloat:0];
                _animation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
                _animation.duration = 1.5;
                _animation.repeatCount = 500;
                 // 动画终了后不返回初始状态
                _animation.removedOnCompletion = NO;
//                _animation.fillMode = kCAFillModeForwards;
            }
            [_animationView.layer addAnimation:_animation forKey:kLoadingAnimation];
        }else{
            
            [_animationView.layer removeAnimationForKey:kLoadingAnimation];
        }
    }
}

@end
