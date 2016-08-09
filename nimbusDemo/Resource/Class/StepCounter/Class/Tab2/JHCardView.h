//
//  JHCardView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHStackablePage.h"


typedef NS_ENUM(NSInteger, CardActionType) {
    kCardActionTypeInviteFriend,
    kCardActionTypeOpenContest,
};

typedef void (^CardActionBlock)(CardActionType actionType);


@interface JHCardView : StackablePage
{
    
}

- (void)setupTitle:(NSString *)title iconName:(NSString *)iconName;

- (void)addTapOverlay;

- (UIButton *)addActionBtnWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

@property (nonatomic, copy) CardActionBlock actionBlock;
- (void)setActionBlock:(CardActionBlock)actionBlock;

@property (nonatomic, readonly) CGFloat titleViewHeight;
@property (nonatomic, readonly) NINetworkImageView *titleIconView;
@property (nonatomic, readonly) UILabel *titleLabel;

@end

