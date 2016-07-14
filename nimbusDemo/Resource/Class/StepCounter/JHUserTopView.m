//
//  JHUserTopView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHUserTopView.h"

@interface JHUserTopView ()

@property (nonatomic, strong) NINetworkImageView *userTopView;

@end

@implementation JHUserTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView
{
    if (_userTopView) {
        [_userTopView removeFromSuperview];
        _userTopView = nil;
    }
    _userTopView = [[NINetworkImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //图片的填充状态
    _userTopView.contentMode = UIViewContentModeScaleAspectFill;
    
    _userTopView.initialImage = [UIImage imageNamed:@"doctor_default.png"];
    
    _userTopView.center = CGPointMake(self.width / 2, self.height / 2);
    _userTopView.layer.cornerRadius = _userTopView.width / 2;
    _userTopView.clipsToBounds = YES;
    _userTopView.layer.borderColor = RGBCOLOR_HEX(0x7c7c7c).CGColor;
    _userTopView.layer.borderWidth = 1.5;
    [self addSubview:_userTopView];
}


@end
