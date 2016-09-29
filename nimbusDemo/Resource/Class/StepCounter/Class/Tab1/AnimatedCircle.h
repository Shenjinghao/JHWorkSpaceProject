//
//  AnimatedCircle.h
//  测试Demo
//
//  Created by Shenjinghao on 16/9/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedCircle : UIView

@property (nonatomic) CGFloat initAngle;

// position is 0-1.0, it's a percentage
@property (nonatomic) CGFloat currentPosition;

@property (nonatomic) CGFloat speed;

@property (nonatomic, copy) NSString *backgroundImage;

@property (nonatomic, copy) NSString *foregroundImage;

@property (nonatomic, strong) UIImageView *animatedImageView;

@property (nonatomic, strong) UIImageView *backgroundImageView;

- (CGFloat)animateFrom:(CGFloat)from to:(CGFloat)to;

- (CGFloat)animationToPosition:(CGFloat)position;

@end
