//
//  JHStartStepsFriendPKCard.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHStartStepsFriendPKCard.h"

@implementation JHStartStepsFriendPKCard {
    UIImageView *_backgroundView;
    UIImageView *_animatedFigure1;
    UIImageView *_animatedFigure2;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIImageView *img = [UIImageView imageViewWithImageName:@"steps-pk-open-center-img.png"];
    img.frame = CGRectMake(0, 14, 267, 208);
    img.centerX = self.width / 2;
    [self addSubview:img];
    
    UILabel *label1 = [UILabel labelWithFrame:CGRectZero fontSize:14 fontColor:RGBCOLOR_HEX(0x737373) text:@"想知道小伙伴们今天走了多少步?"];
    [label1 sizeToFit];
    label1.centerX = self.width / 2;
    label1.bottom = self.height - (IS_iPhone4 ? 150 : 180);
    [self addSubview:label1];
    
    UILabel *label2 = [UILabel labelWithFrame:CGRectZero fontSize:14 fontColor:RGBCOLOR_HEX(0x737373) text:@"绑定微信邀请他们一起参加竞赛吧!"];
    [label2 sizeToFit];
    label2.centerX = self.width / 2;
    label2.bottom = self.height - (IS_iPhone4 ? 132 : 160);
    [self addSubview:label2];
    
    UILabel *label3 = [UILabel labelWithFrame:CGRectZero fontSize:16 fontColor:RGBCOLOR_HEX(0xf0705c) text:@"一起走，让计步更有乐趣!"];
    [label3 sizeToFit];
    label3.centerX = self.width / 2;
    label3.bottom = self.height - (IS_iPhone4 ? 86 : 108);
    [self addSubview:label3];
    
    [self addTapOverlay];
    
    UIButton *btn = [self addActionBtnWithTitle:@"开启好友竞赛" target:self selector:@selector(openFriendsPK)];
    btn.bottom = self.height - (IS_iPhone4 ? 13 : 30);
    
    // layout
    CGFloat top = img.bottom;
    CGFloat bottom = btn.top;
    CGFloat space = bottom - top - (label1.height + label2.height + 5) - label3.height;
    
    label1.top = top + space / 6;
    label2.top = label1.bottom + 5;
    label3.top = label2.bottom + space / 3;
}

- (BOOL)reusable {
    return NO;
}

- (void)openFriendsPK {
    NIDPRINTMETHODNAME();
    NIDASSERT(self.actionBlock);
    if (self.actionBlock) {
        self.actionBlock(kCardActionTypeOpenContest);
    }
}



@end
