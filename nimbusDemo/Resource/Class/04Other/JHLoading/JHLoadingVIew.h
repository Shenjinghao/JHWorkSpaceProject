//
//  JHLoadingVIew.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/5.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHAutoCenterView.h"

@interface JHLoadingVIew : JHAutoCenterView

@property (nonatomic, assign) BOOL isAnimating;

- (instancetype)initWithFrame:(CGRect)frame;
extern NSString *const kLoadingAnimation;

@end
