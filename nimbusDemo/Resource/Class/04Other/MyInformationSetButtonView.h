//
//  MyInformationSetButtonView.h
//  ChunyuClinic
//
//  Created by Shenjinghao on 15/8/31.
//  Copyright (c) 2015年 lvjianxiong. All rights reserved.
//

/**
 *添加头像下面的其他服务的button
 */

#import <UIKit/UIKit.h>


/**
 * 按钮类型
 */
typedef NS_ENUM(NSInteger, MyInfoIconTitleButtonType) {
    //诊所服务
    kClinicServiceBtnIncomeAccount = 1110,  	// 收入结算
    kClinicServiceBtnHomepage,				    // 主页预览
    kClinicServiceBtnMyOrder,				    // 我的订单
    kClinicServiceBtnReleaseTopic,				// 发布话题
    
    //其他服务
    kOtherServiceBtnStrategy,					// 春雨攻略
    kOtherServiceBtnCodeCard,					// 二维码名片
    kOtherServiceBtnReadToday,					// 今日必读
    kOtherServiceBtnHeartWall,					// 心意墙
    kOtherServiceBtnStarDoctor,			     	// 明星医生
    kOtherServiceBtnInviteDoctor,			    // 邀请医生
    kOtherServiceBtnInviteCode,                 // 邀请码
    kOtherServiceBtnDoctorGroup,			    // 医生集团
    
    kMyInfoBtnUnKnown = 99999,
    
};


/**
 * 按钮点击设置代理，在vc中实现
 */
@protocol MyInfoInfoButtonDelegate <NSObject>

- (void)MyInfoButtonDidClicked:(id)sender;

@end

/**
 * 添加背景view
 */
@interface MyInformationSetButtonView : UIView

@property (nonatomic) id<MyInfoInfoButtonDelegate>delegate;

- (id)initWithFrame:(CGRect)frame query:(NSDictionary *)query;

@end

/**
 * 设置按钮的属性
 */
@interface MyInformationIconTitleButton : UIButton

@property (nonatomic) MyInfoIconTitleButtonType type;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconPath;

- (void) setButtonType:(MyInfoIconTitleButtonType)type;

@end



