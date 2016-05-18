//
//  JHOtherViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHOtherViewController.h"
#import "MyInformationHeaderView.h"
#import "MyInformationSetButtonView.h"

//ReactiveCocoa
#import "JHRACViewController.h"
//Block
#import "JHBlockViewController.h"
//Masonry    只要引进下面的类，以前的frame会出现干扰？？？
//#import "MASExampleListViewController.h"

//YYKit
#import "YYRootViewController.h"


@implementation JHOtherViewController

{
    MyInformationHeaderView *_myInfoView;
    NSString* _myHomeUrl;   //我的主页
    BOOL isCompleteInfo;
    NSString* _inviteUrl;    //邀请医生
    NSDictionary* _doctorCouponDict; //4.3邀请码相关
}

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        //不隐藏tabbar
        
        self.hidesBottomBarWhenPushed = NO;
        self.showDefaultLoadingStatus = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //先创建UI
    [self creatHeaderView];
    [self createOtherButtons];

}

- (NSString *)tabTitle {
    return @"我";
}

- (NSString *)tabImageName {
    return @"tabbar_mine_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_mine";
}

#pragma mark 隐藏navigationbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
}


#pragma mark 添加headerview
- (void)creatHeaderView
{
    _myInfoView = [[MyInformationHeaderView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 630)];
    self.tableView.tableHeaderView = _myInfoView;
    
}
#pragma mark 创建下面的其他服务的按钮
- (void)createOtherButtons
{
    NSArray *infoArray = @[@{
                               @"title" : @"诊所服务",
                               @"buttons" : @[@{@"type" : @(kClinicServiceBtnIncomeAccount)},
                                              @{@"type" : @(kClinicServiceBtnHomepage)},
                                              @{@"type" : @(kClinicServiceBtnMyOrder)},
                                              @{@"type" : @(kClinicServiceBtnReleaseTopic)}
                                              ]
                               },
                           @{
                               @"title" : @"其他服务",
                               @"buttons" : @[@{@"type" : @(kOtherServiceBtnStrategy)},
                                              @{@"type" : @(kOtherServiceBtnCodeCard)},
                                              @{@"type" : @(kOtherServiceBtnReadToday)},
                                              @{@"type" : @(kOtherServiceBtnHeartWall)},
                                              @{@"type" : @(kOtherServiceBtnStarDoctor)},
                                              @{@"type" : @(kOtherServiceBtnInviteDoctor)},
                                              @{@"type" : @(kOtherServiceBtnInviteCode)},
                                              @{@"type" : @(kOtherServiceBtnDoctorGroup)},
                                              
                                              ]
                               }
                           ];
    
    CGFloat offSetY = 230;
    for (NSInteger i = 0; i < 2; i ++) {
        NSDictionary *dict = infoArray[i];
        MyInformationSetButtonView *view = [[MyInformationSetButtonView alloc] initWithFrame:CGRectMake(0, offSetY, viewWidth(), 0)
                                                                                       query:dict];
        view.delegate = self;
        [_myInfoView addSubview:view];
        offSetY += view.height;
    }
    
}



#pragma mark 实现代理方法
- (void)MyInfoButtonDidClicked:(id)sender
{
    
    
    
    MyInformationIconTitleButton *button = (MyInformationIconTitleButton *)sender;
    switch (button.type) {
        case kClinicServiceBtnIncomeAccount:{
            NIDPRINT(@"l0");
            JHRACViewController *VC = [[JHRACViewController alloc] initWithQuery:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case kClinicServiceBtnHomepage:{
            NIDPRINT(@"l1");
            JHBlockViewController *VC = [[JHBlockViewController alloc] initWithQuery:nil];
            [self.navigationController pushViewController:VC animated:YES];
         }
            break;
        case kClinicServiceBtnMyOrder:{
            NIDPRINT(@"l2");
            
//            MASExampleListViewController *VC = [[MASExampleListViewController alloc] init];
//            [self.navigationController pushViewController:VC animated:YES];
            
           }
            break;
        case kClinicServiceBtnReleaseTopic:{
            NIDPRINT(@"l3");
            YYRootViewController *VC = [[YYRootViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case kOtherServiceBtnStrategy:{
            NIDPRINT(@"l4");
        }
            break;
        case kOtherServiceBtnCodeCard:{
            NIDPRINT(@"l5");
        }
            break;
        case kOtherServiceBtnReadToday:{
            NIDPRINT(@"l6");
        }
            break;
        case kOtherServiceBtnHeartWall:{
            NIDPRINT(@"l7");
         }
            break;
        case kOtherServiceBtnStarDoctor:{
            NIDPRINT(@"l8");
        }
            break;
        case kOtherServiceBtnInviteDoctor:{
            NIDPRINT(@"l9");
        }
            break;
        case kOtherServiceBtnInviteCode:{
            NIDPRINT(@"20");
         }
            break;
        case kOtherServiceBtnDoctorGroup:{
            NIDPRINT(@"21");
         }
            break;
            
        default:
            break;
    }
    
}


@end
