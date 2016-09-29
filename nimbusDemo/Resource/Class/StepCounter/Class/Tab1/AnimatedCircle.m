//
//  AnimatedCircle.m
//  测试Demo
//
//  Created by Shenjinghao on 16/9/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "AnimatedCircle.h"

@interface AnimatedCircle ()<CAAnimationDelegate>


@end

@implementation AnimatedCircle
{
    CAShapeLayer *_arcLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _speed = 1;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setBackgroundImage:(NSString *)backgroundImage
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_backgroundImageView];
    }
    _backgroundImageView.image = [UIImage load:backgroundImage];
}

- (void)setForegroundImage:(NSString *)foregroundImage
{
    if (_animatedImageView == nil) {
        _animatedImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_animatedImageView];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGRect rect = _animatedImageView.bounds;
        //????
        //[path addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:(rect.size.height - 30) / 2 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [path addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:(rect.size.height - 30) / 2 startAngle:-M_PI * 0.5 endAngle:2 * M_PI - M_PI * 0.5 clockwise:YES];
        _arcLayer = [CAShapeLayer layer];
        _arcLayer.path = path.CGPath;
        _arcLayer.fillColor = [UIColor clearColor].CGColor;
        _arcLayer.strokeColor = [UIColor blackColor].CGColor;
        _arcLayer.lineWidth = 30;
        _arcLayer.frame = rect;
        _arcLayer.strokeEnd = 0;
        _animatedImageView.layer.mask = _arcLayer;
    }
    
    _animatedImageView.image = [UIImage load:foregroundImage];
}

- (void)setInitAngle:(CGFloat)initAngle
{
    _initAngle = initAngle;
    _arcLayer.transform = CATransform3DMakeRotation(initAngle, 0, 0, 1);
}

- (void)setCurrentPosition:(CGFloat)currentPosition {
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    currentPosition = MAX(0, MIN(currentPosition, 1.0));
    _currentPosition = currentPosition;
    _arcLayer.strokeEnd = currentPosition;
    [CATransaction commit];
}

- (void)setSpeed:(CGFloat)speed {
    if (speed > 0.01) {
        _speed = speed;
    }
}

- (CGFloat)animateFrom:(CGFloat)from to:(CGFloat)to
{
    from = MAX(0, MIN(1, from));
    to = MAX(0, MIN(1, to));
    
    CGFloat distance = fabs(from - to);
    _arcLayer.strokeEnd = to;
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.removedOnCompletion = YES;
    bas.duration = distance / self.speed;
    bas.delegate = self;
    bas.fromValue=[NSNumber numberWithFloat:from];
    bas.toValue=[NSNumber numberWithFloat:to];
    [_arcLayer addAnimation:bas forKey:@"key"];
    return bas.duration;
}

- (CGFloat)animationToPosition:(CGFloat)position
{
    return [self animateFrom:self.currentPosition to:position];
}

@end
