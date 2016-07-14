//
//  MyInformationHeaderView.m
//  ChunyuClinic
//
//  Created by Shenjinghao on 15/8/27.
//  Copyright (c) 2015年 lvjianxiong. All rights reserved.
//




#import "MyInformationHeaderView.h"
#import "UserCenterInfoButton.h"
#import "JHNavigationBarViewController.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, buttonDidClickedTag)
{
    kBadgeButtonTag = 0x4444,
    kSetDetailBubbleButtonTag = 0x55555,
};

@interface MyInformationHeaderView (){

    UIView *_myHeaderView;                  //tableview的头部
    UILabel *_userDetailTextLabel;          //医生信息
    JHNetworkImageView *_headerImageView;   //医生头像
    UIButton *_headerButton;                //头像按钮
    NSArray *_buttonArray;                  //指数的button
    UILabel *_titleTextLabel;               //头部标题
    UILabel *_titleLabel;                   //指数标题
    UILabel *_countLabel;                   //指数数值
    UIView *_settingView;                   //设置按钮
    UIView *_arrowView;                     //箭头按钮
    UIImageView *_circleView;               //红点按钮
    NSString* _fansCount;                   //粉丝数
    BOOL isCompleteInfo;
    NSString* _recommendUrl;                //推荐指数
    //数据不存到user里面防止数据重叠
    NSString* _assessTotalNum;
    NSString* _scoreAccount;
    NSString* _recommendAcount;
    
}


@end




@implementation MyInformationHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化headerview
        _myHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 230)];
        _myHeaderView.backgroundColor = RGBCOLOR_HEX(0x2693dd);
        [self addSubview:_myHeaderView];
        [self requestData];
        [self addUserDataField];
        
        
    }
    return self;
}

- (void) requestData
{   
    isCompleteInfo = YES;
        _circleView.hidden = isCompleteInfo;
        //四项指数数值
        _scoreAccount = @"1";
        _assessTotalNum = @"2";
        _recommendAcount = @"3";
        _fansCount = @"4";
        _recommendUrl = @"www.baidu.com";
    //下面这个是什么鬼啊！！！？？？通过事件响应链来找到第一响应者
        [self.viewController reloadInputViews];

}

#pragma mark 创建headerview的四个指数
- (void)addButtonInHeaderView
{
    
    CGFloat startY = _userDetailTextLabel.bottom + 20;
    CGFloat width = viewWidth() / 4;
    for (NSInteger i = 0; i < 3; i ++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(width * (i + 1), startY + 12, 0.5, 28)];
        lineView.backgroundColor = RGBCOLOR_HEX(0x50a6df);
        [_myHeaderView addSubview:lineView];
        
    }
    NSArray * titles = @[@"月积分", @"粉丝", @"评价", @"推荐指数"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i ++) {
        //创建自定义button
        UserCenterInfoButton *tempButton = [[UserCenterInfoButton alloc] initWithFrame:CGRectMake(0.5 + width * i, startY, width, 70)];
        [tempButton settitleText:titles[i]];
        tempButton.tag = kBadgeButtonTag + i;
        [tempArray addObject:tempButton];
        [tempButton addTarget: self action: @selector(onMessageCenterButtonClicked:)
         forControlEvents: UIControlEventTouchUpInside];
        [_myHeaderView addSubview:tempButton];
    }
    _buttonArray = tempArray;
    // 添加完毕后从本地缓存获取数据,(数值),从新请求四项指数数值
//    NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
//    NSArray* DoctorInfo = [info arrayForKey:kUserCenterDialogData];
//    User* user = [User sharedInstance];
//    if (DoctorInfo) {
        for (NSInteger i = 0 ; i < _buttonArray.count; ++i) {
            UserCenterInfoButton* button = _buttonArray[i];
            if (i == 0) {
                [button setCount:_scoreAccount];
            }else if (i == 1) {
                [button setCount:_fansCount];
            }else if (i == 2){
                [button setCount:_assessTotalNum];
            }else{
            [button setCount: _recommendAcount];
            }
//        }
    }
}

#pragma mark 创建 标题 头像 资料等
- (void)addUserDataField
{
    //创建标题
    _titleTextLabel = [UILabel labelWithFrame: CGRectMake(0, 34, viewWidth(), 18)
                                 boldFontSize: 17
                                    fontColor: [UIColor whiteColor]
                                         text: @"我的资料"];
    _titleTextLabel.textAlignment = NSTextAlignmentCenter;
    [_myHeaderView addSubview: _titleTextLabel];
    
    //添加设置按钮
    _settingView = [[UIView alloc] initWithFrame:CGRectMake(viewWidth()-100, 0, 100, 60)];
    [_myHeaderView addSubview:_settingView];
    
    //settingView用户交互打开
    _settingView.userInteractionEnabled = YES;
    UIImageView *settingImageView = [[UIImageView alloc] initWithImage:[UIImage load:@"user_center_setting.png"]];
    settingImageView.frame = CGRectMake(100 - 38, 34, 18, 18);
    [_settingView addSubview:settingImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushIntoSetAction)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_settingView addGestureRecognizer:tap];

    // 箭头
    _arrowView = [[UIView alloc] initWithFrame:CGRectMake(viewWidth()-100, 60, 100, 60)];
    _arrowView.backgroundColor = [UIColor clearColor];
    [_myHeaderView addSubview:_arrowView];
    //arrowView用户交互打开
    _arrowView.userInteractionEnabled = YES;
    UIImageView *rightArrow = [UIImageView imageViewWithImageName:@"message_center_right" andFrame:CGRectMake(77, 35, 8, 14)];
    [_arrowView addSubview:rightArrow];
    
    //添加小红点
    _circleView = [[UIImageView alloc]initWithFrame:CGRectMake(67, 39.5, 6, 6)];
    _circleView.layer.cornerRadius = 3;
    _circleView.backgroundColor = COLOR_A11;
    [_arrowView addSubview:_circleView];
    
    UITapGestureRecognizer *tapArrow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushIntoArrowAction)];
    tapArrow.numberOfTapsRequired = 1;
    tapArrow.numberOfTouchesRequired = 1;
    [_arrowView addGestureRecognizer:tapArrow];
    
    //创建头像
    _headerImageView = [[JHNetworkImageView alloc] initWithFrame:CGRectMake((viewWidth() - 56) / 2, 75, 56, 56)];
    _headerImageView.layer.cornerRadius = 28;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.borderWidth = 1.5;
    _headerImageView.layer.borderColor = RGBCOLOR_HEX(0x0f81cd).CGColor;
    //边界超出可以被点击
    _myHeaderView.clipsToBounds = YES;
    _headerImageView.defaultImage = [UIImage load:@"doctor_default.png"];
    
    [_myHeaderView addSubview:_headerImageView];
    
    //
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.backgroundColor = [UIColor clearColor];
    _headerButton.frame = CGRectMake(0, 34, scaleWidthWith320(320 - 34), 230 - 104);
    _headerButton.tag = kSetDetailBubbleButtonTag;
    [_headerButton addTarget: self
                      action: @selector(onMessageCenterButtonClicked:)
            forControlEvents: UIControlEventTouchUpInside];
    [_myHeaderView addSubview: _headerButton];
    
//    将button隐藏
    
    
    //创建医生简介
    NSString* welcomeTextStr = [NSString stringWithFormat:@"haha 哈哈"];
    _userDetailTextLabel = [UILabel labelWithFrame:CGRectMake(0, _headerImageView.bottom + 10, viewWidth(), 16) boldFontSize:15 fontColor:[UIColor whiteColor] text:welcomeTextStr];
    _userDetailTextLabel.textAlignment = NSTextAlignmentCenter;
    [_myHeaderView addSubview:_userDetailTextLabel];
    
    //  医生数据。积分，排名等
    // 如果医生数据完善了，则展示积分等；如果没有完善，则要求完善
//    if ([user.avatarInClinic isNonEmpty]) {
//        [self addButtonInHeaderView];
//    } else {
//        [self addCompleteInfoBubble];
//    }
    [self addButtonInHeaderView];
}




#pragma mark  创建一个指定样式的 UILabel
- (UILabel *) createLabel: (CGRect) frame
                     font: (UIFont *) font
                textColor: (UIColor *) textColor
              shadowColor: (UIColor *) shadowColor
             shadowOffset: (CGSize) shadowOffset {
    
    UILabel * label = [[UILabel alloc] initWithFrame: frame];
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    if (shadowColor) {
        label.shadowOffset = shadowOffset;
        label.shadowColor = shadowColor;
    }
    return label;
}

#pragma mark 设置按钮点击方法
- (void) pushIntoSetAction
{
    NIDPRINT(@"ssssssss");
    

}

#pragma mark 箭头按钮点击方法
- (void) pushIntoArrowAction
{
    NIDPRINT(@"aaa");
}

#pragma mark - 处理其他按钮的点击事件
- (void) onMessageCenterButtonClicked: (id) sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case kSetDetailBubbleButtonTag:{    //医生资料
            NIDPRINT(@"s2");
            break;
            
        }
        case kBadgeButtonTag:{              //月积分
            NIDPRINT(@"s3");
            
            JHNavigationBarViewController *VC = [[JHNavigationBarViewController alloc] initWithQuery:nil];
            [[AppDelegate sharedInstance].topViewController.navigationController pushViewController:VC animated:YES];
            
            break;
        }
        case kBadgeButtonTag + 1:{          //粉丝
            NIDPRINT(@"s4");
            break;
        }
        case kBadgeButtonTag + 2:{          //评价
            NIDPRINT(@"s5");
            break;
        }
        case kBadgeButtonTag + 3:{          //推荐指数
            NIDPRINT(@"s6");
            break;
        }
            
        default:
            break;
    }
}



@end
