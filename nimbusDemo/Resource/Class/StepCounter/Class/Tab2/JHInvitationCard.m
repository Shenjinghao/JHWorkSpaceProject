//
//  JHInvitationCard.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHInvitationCard.h"

@implementation JHInvitationCard {
    UIView *_tapOverlay;
    UIButton *_topInviteBtn;
    
    UIButton *_actionBtn;
    UILabel *_textLabel1;
    UILabel *_textLabel2;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setupTitle:@"好友竞赛" iconName:nil];
    
    CGFloat yOffset = 55 * kPageHeightRatio;
    UIImageView *desc1 = [UIImageView imageViewWithImageName:@"steps-pk-invitation-desc1.png"];
    desc1.top = yOffset + 27 * kPageWidthRatio * kPageWidthRatio * kPageWidthRatio;
    desc1.left = 117*kPageWidthRatio;
    [self addSubview:desc1];
    
    UIImageView *funnyPic = [UIImageView imageViewWithImageName:@"steps-pk-invitation-funny-pic.png"];
    [self addSubview:funnyPic];
    funnyPic.centerX = self.width / 2;
    funnyPic.top = yOffset + 67 * kPageWidthRatio * kPageWidthRatio;
    
    _textLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) fontSize:14 fontColor:RGBCOLOR_HEX(0x737373) text:@"好友竞赛已开启"];
    
    [_textLabel1 sizeToFit];
    [self addSubview:_textLabel1];
    _textLabel1.width = self.width;
    _textLabel1.textAlignment = NSTextAlignmentCenter;
    
    _textLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) fontSize:14 fontColor:RGBCOLOR_HEX(0x737373) text:@"快去通知你的好友一决高下！"];
    [_textLabel2 sizeToFit];
    _textLabel2.textAlignment = NSTextAlignmentCenter;
    _textLabel2.width = self.width;
    [self addSubview:_textLabel2];
    
    [self addTapOverlay];
    
    // invitation btn
    UIButton *inviteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [inviteBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    [inviteBtn setTitleColor:RGBCOLOR_HEX(0xf0705c) forState:UIControlStateNormal];
    inviteBtn.titleLabel.font = [UIFont systemFontOfSize:14 * kPageHeightRatio];
    [inviteBtn sizeToFit];
    [inviteBtn addTarget:self action:@selector(pkAction) forControlEvents:UIControlEventTouchUpInside];
    inviteBtn.right = self.width - 20;
    inviteBtn.centerY = 30 * kPageHeightRatio;
    [self addSubview:inviteBtn];
    _topInviteBtn = inviteBtn;
    
    _actionBtn = [self addActionBtnWithTitle:@"邀请好友" target:self selector:@selector(pkAction)];
    _actionBtn.bottom = self.height - 12;
}

// 这张卡片不能被重用
- (BOOL)reusable {
    return NO;
}

- (void)pkAction {
    NIDASSERT(self.actionBlock);
    if (self.actionBlock) {
        self.actionBlock(kCardActionTypeInviteFriend);
    }
}

- (void)setSelected:(BOOL)selected {
    _topInviteBtn.hidden = selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self doLayout];
}

// 排版氛围图和文案
- (void)doLayout {
    if (IS_iPhone4) {
        if (self.height > 350) {
            _textLabel1.bottom = self.height - 113;
            _textLabel2.bottom = self.height - 88;
        }
        else {
            _textLabel1.bottom = self.height - 82;
            _textLabel2.bottom = self.height - 58;
        }
        _actionBtn.bottom = self.height - 12;
    }
    else {
        if (self.height > 400) {
            _textLabel1.bottom = self.height - 132;
            _textLabel2.bottom = self.height - 106;
            _actionBtn.bottom = self.height - 30;
        }
        else {
            _textLabel1.bottom = self.height - 95;
            _textLabel2.bottom = self.height - 72;
            _actionBtn.bottom = self.height - 12;
        }
    }
}


@end
