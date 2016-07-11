//
//  MyInformationSetButtonView.m
//  ChunyuClinic
//
//  Created by Shenjinghao on 15/8/31.
//  Copyright (c) 2015年 lvjianxiong. All rights reserved.
//

#import "MyInformationSetButtonView.h"

@implementation MyInformationSetButtonView

-(id)initWithFrame:(CGRect)frame query:(NSDictionary *)query
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        NSArray *buttonArray = query[@"buttons"];
        NSInteger count = buttonArray.count;
        NSInteger row = count % 4 == 0 ? count / 4 : count / 4 + 1;
        //设置背景
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), scaleWidthWith320(90) * row)];
        backGroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:backGroundView];
        //标题
        UILabel *titleLables = [UILabel labelWithFrame:CGRectMake(15, 10, viewWidth()-30, 15)
                                                       fontSize:13
                                                      fontColor:COLOR_A4
                                                           text:query[@"title"]];
        [backGroundView addSubview:titleLables];
        
        // 按钮
        for (NSInteger i = 0; i < buttonArray.count; i++) {
            NSDictionary* dict = buttonArray[i];
            MyInformationIconTitleButton *button = [[MyInformationIconTitleButton alloc] initWithFrame:CGRectMake(0 + viewWidth() / 4 * (i % 4), 33 + (i / 4) * scaleWidthWith320(90), 0, 0)];
            [button setButtonType:[dict[@"type"] integerValue]];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [backGroundView addSubview:button];
        }
        // 最上面的横向分隔线
        UIView *firstSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 33, viewWidth(), 0.5)];
        firstSepLine.backgroundColor = COLOR_A7;
        [backGroundView addSubview:firstSepLine];
        
        // 其他横向分隔线
        for (NSInteger i = 0; i < row; i++) {
            UIView *sepLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 33 + scaleWidthWith320(90) + scaleWidthWith320(90) * i, viewWidth(), 0.5)];
            sepLine1.backgroundColor = COLOR_A7;
            [backGroundView addSubview:sepLine1];
            
            // 三条竖分隔线
            for (NSInteger j = 0; j < 3; j++) {
                UIView *sepLine2 = [[UIView alloc] initWithFrame:CGRectMake(viewWidth() / 4 * (j + 1), 33 + scaleWidthWith320(90) * i, 0.5, scaleWidthWith320(90))];
                sepLine2.backgroundColor = COLOR_A7;
                [backGroundView addSubview:sepLine2];
            }
        }
        //添加中间的分栏效果
        self.height = scaleWidthWith320(90) * row + 33;
    }
    return self;
}
// 某个服务按钮被点击
- (void)buttonPressed:(id)sender {
    [self.delegate MyInfoButtonDidClicked:sender];
}

@end


@implementation MyInformationIconTitleButton{

    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), viewWidth() / 4, scaleWidthWith320(90))];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //  图标
        _iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 30, 30)];
        _iconImageView.center = CGPointMake(self.width / 2, self.height / 2 - 10);
        _iconImageView.backgroundColor = [UIColor clearColor];
        [self addSubview: _iconImageView];
        
        //  title
        _titleLabel = [UILabel labelWithFrame: CGRectMake(0, _iconImageView.bottom + 10, self.width, 15)
                                     fontSize: 12
                                    fontColor: COLOR_A4
                                         text: @""];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.centerX = self.centerX - self.left;
        [self addSubview: _titleLabel];
    }
    return self;
}
- (void)setButtonType:(MyInfoIconTitleButtonType)type
{
    _type = type;
    _titleLabel.text = [self titleForType:type];
    _iconImageView.image = [UIImage load:[self iconForType:type]];
    
}
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? COLOR_A9 : [UIColor whiteColor];
}
#pragma mark 为button设置图片
- (NSString *) iconForType:(MyInfoIconTitleButtonType)type{
    switch (type) {
        case kClinicServiceBtnIncomeAccount:
            return @"my_income.png";
        case kClinicServiceBtnHomepage:
            return @"my_home_page.png";
        case kClinicServiceBtnMyOrder:
            return @"my_order.png";
        case kClinicServiceBtnReleaseTopic:
            return @"my_topic.png";
        case kOtherServiceBtnStrategy:
            return @"my_strategy.png";
        case kOtherServiceBtnCodeCard:
            return @"my_doctor_card.png";
        case kOtherServiceBtnReadToday:
            return @"my_today_news.png";
        case kOtherServiceBtnHeartWall:
            return @"my_reward_wall.png";
        case kOtherServiceBtnStarDoctor:
            return @"my_star_doctor.png";
        case kOtherServiceBtnInviteDoctor:
            return @"invite_doctor.png";
            break;
        case kOtherServiceBtnInviteCode:
            return @"my_invite.png";
        case kOtherServiceBtnDoctorGroup:
            return @"doctor_group_tab.png";
        default:
            return @"";
    }
}

#pragma mark 为button设置标题
- (NSString *) titleForType:(MyInfoIconTitleButtonType)type{
    switch (type) {
        case kClinicServiceBtnIncomeAccount:
            return @"ReactiveCocoa";
            
        case kClinicServiceBtnHomepage:
            return @"Block";
            
        case kClinicServiceBtnMyOrder:
            return @"Masonry";
            
        case kClinicServiceBtnReleaseTopic:
            return @"YYKit";
            
        case kOtherServiceBtnStrategy:
            return @"FMDB";
            
        case kOtherServiceBtnCodeCard:
            return @"小黄条";
            
        case kOtherServiceBtnReadToday:
            return @"无限聊天";
            
        case kOtherServiceBtnHeartWall:
            return @"pop window";
            
        case kOtherServiceBtnStarDoctor:
            return @"滑动滑块";
            
        case kOtherServiceBtnInviteDoctor:
            return @"LoadingAnimation";
            
        case kOtherServiceBtnInviteCode:
            return @"字体设置";
            
        case kOtherServiceBtnDoctorGroup:
            return @"医生集团";
            
        default:
            return @"";
            break;
    }
}

@end
