//
//  JHCardView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHCardView.h"


@implementation JHCardView{
    UIView *_tapOverlay;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 12;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGBCOLOR_HEX(0xe5e5e5).CGColor;
        self.clipsToBounds = YES;
        self.backgroundColor = RGBCOLOR_HEX(0xffffff);
    }
    return self;
}

- (void)setupTitle:(NSString *)title iconName:(NSString *)iconName {
    // icon
    _titleIconView = [[NINetworkImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    
//    [_titleIconView makeRound];
    _titleIconView.layer.cornerRadius = self.width / 2;
    _titleIconView.clipsToBounds = YES;
    
    _titleIconView.contentMode = UIViewContentModeScaleAspectFill;
    _titleIconView.center = CGPointMake(31 * kPageWidthRatio, 28 * kPageHeightRatio);
    [self addSubview:_titleIconView];
    
    // title
    _titleLabel = [UILabel labelWithFrame:CGRectMake(16, 0, 100, 23)
                                 fontSize:19 * kPageHeightRatio
                                fontColor:RGBCOLOR_HEX(0x636363)
                                     text:title];
    [_titleLabel sizeToFit];
    _titleLabel.top = 18 * kPageHeightRatio;
    _titleLabel.left = 20 * kPageWidthRatio;
    [self addSubview:_titleLabel];
    
    if (iconName == nil) {
        _titleIconView.hidden = YES;
    }
    else {
        _titleIconView.initialImage = [UIImage imageNamed:iconName];
        _titleLabel.left = _titleIconView.right + 9;
        _titleIconView.hidden = NO;
    }
    
    // 1.5 separator
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width - 38 * kPageWidthRatio, 2)];
    separator.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"steps-pk-title-separator.png"]];
    separator.top = self.titleViewHeight - 1;
    separator.centerX = self.width / 2;
    [self addSubview:separator];
}

- (CGFloat)titleViewHeight {
    return 54 * kPageHeightRatio;
}

- (void)addTapOverlay {
    _tapOverlay = [[UIView alloc] initWithFrame:self.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCard)];
    _tapOverlay.userInteractionEnabled = YES;
    [_tapOverlay addGestureRecognizer:tap];
    [self addSubview:_tapOverlay];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deselectCard)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_tapOverlay addGestureRecognizer:swipe];
}

// 选择事件
- (void)selectCard {
    NIDPRINTMETHODNAME();
    [self.delegate stackablePageSelected:self];
}

- (void)deselectCard {
    [self.delegate stackablePageSelected:self];
}

- (UIButton *)addActionBtnWithTitle:(NSString *)title target:(id)target selector:(SEL)selector {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 34)];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = RGBCOLOR_HEX(0xf6644d);
    [btn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    [self addSubview:btn];
    btn.centerX = self.width / 2;
    
    return btn;
}


@end
