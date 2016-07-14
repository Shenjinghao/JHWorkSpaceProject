//
//  IndexStepsViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "IndexStepsViewController.h"
#import "JHUserTopView.h"
#import "UIView+JHGesturesBlock.h"
#import "JHNavigationView.h"

#import "StepsMainViewController.h"
#import "StepsFriendPKViewController.h"
#import "DataCenterViewController.h"
#import "IntelligenceAssistantTableViewController.h"

@interface IndexStepsViewController ()

@property (nonatomic, strong) JHUserTopView *userTopView;

@property (nonatomic, strong) JHNavigationButton *pkFriendBtn;
@property (nonatomic, strong) JHNavigationButton *pedometerBtn;
@property (nonatomic, strong) JHNavigationButton *dataCenterBtn;
@property (nonatomic, strong) JHNavigationButton *assistantBtn;
@property (nonatomic, strong) JHNavigationButton *lastTabBtn;   //存储切换到最后一个的按钮

@property (nonatomic, strong) UIViewController *lastTabViewController;        //存储切换到最后一个的控制器

@property (nonatomic, strong) StepsMainViewController *stepsMainViewController;
@property (nonatomic, strong) StepsFriendPKViewController *stepsFriendPKViewController;
@property (nonatomic, strong) DataCenterViewController *stepsDataCenterViewController;
@property (nonatomic, strong) IntelligenceAssistantTableViewController *stepsAssistantViewController;

@end

@implementation IndexStepsViewController

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [self creatUserTopView];
    [self creatFourTab];
    
    UINavigationBar *appearance = self.navigationController.navigationBar;
    [appearance setBarTintColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBackButton = YES;
}

- (StepsMainViewController *)stepsMainViewController {
    if (_stepsMainViewController == nil) {
        _stepsMainViewController = [[StepsMainViewController alloc] initWithQuery:nil];
    }
    return _stepsMainViewController;
}

- (StepsFriendPKViewController *)stepsFriendPKViewController {
    NIDPRINTMETHODNAME();
    if (_stepsFriendPKViewController == nil) {
        _stepsFriendPKViewController = [[StepsFriendPKViewController alloc] initWithQuery:nil];
    }
    return _stepsFriendPKViewController;
}

- (DataCenterViewController *)stepsDataCenterViewController {
    if (_stepsDataCenterViewController == nil) {
        _stepsDataCenterViewController = [[DataCenterViewController alloc] initWithQuery:nil];
    }
    return _stepsDataCenterViewController;
}

- (IntelligenceAssistantTableViewController *)stepsAssistantViewController {
    if (_stepsAssistantViewController == nil) {
        _stepsAssistantViewController = [IntelligenceAssistantTableViewController sharedInstance];
    }
    return _stepsAssistantViewController;
}

#pragma mark 计步器头像
- (void)creatUserTopView
{
    self.userTopView = [[JHUserTopView alloc] initWithFrame:CGRectMake(0, self.topOffset, 44, 44)];
    self.userTopView.userInteractionEnabled = YES;
    [self.userTopView jhAddTapGestureWithActionBlock:^(UIGestureRecognizer *gesture) {
        
        NIDPRINT(@"头像点击");
    }];
    
    UIBarButtonItem *userTopItenm = [[UIBarButtonItem alloc] initWithCustomView:self.userTopView];
    self.navigationItem.rightBarButtonItem = userTopItenm;
    
}

- (CGFloat)topOffset {
    int topOffset = 0;
    if (IOSOVER(7)) {
        topOffset = 20;
    }
    return topOffset;
}
#pragma mark 创建左边的四个按钮
- (void)creatFourTab
{
    self.pedometerBtn = [[JHNavigationButton alloc] initWithFrame:CGRectMake(58, self.topOffset, 44, 44)];
//    self.pedometerBtn.space = 12;
    self.pedometerBtn.isLeftButton = YES;
    self.pedometerBtn.centerX = 26;
    [self.pedometerBtn setImage:[UIImage imageNamed:@"tab-pedometer.png"] forState:UIControlStateNormal];
    [self.pedometerBtn setImage:[UIImage imageNamed:@"tab-pedometer-selected.png"] forState:UIControlStateSelected];
    [self.pedometerBtn addTarget:self action:@selector(showPedometer) forControlEvents:UIControlEventTouchUpInside];
    
    self.assistantBtn = [[JHNavigationButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.assistantBtn.isLeftButton = YES;
//    self.assistantBtn.space = 4;
    self.assistantBtn.centerX = 75;
    [self.assistantBtn setImage:[UIImage imageNamed:@"tab-assistant.png"] forState:UIControlStateNormal];
    [self.assistantBtn setImage:[UIImage imageNamed:@"tab-assistant-selected.png"] forState:UIControlStateSelected];
    [self.assistantBtn addTarget:self action:@selector(showAssistantCenter) forControlEvents:UIControlEventTouchUpInside];
    
    self.pkFriendBtn = [[JHNavigationButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.pkFriendBtn.isLeftButton = YES;
//    self.pkFriendBtn.space = 4;
    self.pkFriendBtn.centerX = 134;
    [self.pkFriendBtn setImage:[UIImage imageNamed:@"tab-friends-pk.png"] forState:UIControlStateNormal];
    [self.pkFriendBtn setImage:[UIImage imageNamed:@"tab-friends-pk-selected.png"] forState:UIControlStateSelected];
    [self.pkFriendBtn addTarget:self action:@selector(showFriendPK) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataCenterBtn = [[JHNavigationButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.dataCenterBtn.isLeftButton = YES;
//    self.dataCenterBtn.space = 4;
    self.dataCenterBtn.centerX = 134 + 59;
    [self.dataCenterBtn setImage:[UIImage imageNamed:@"tab-data-center.png"] forState:UIControlStateNormal];
    [self.dataCenterBtn setImage:[UIImage imageNamed:@"tab-data-center-selected.png"] forState:UIControlStateSelected];
    [self.dataCenterBtn addTarget:self action:@selector(showDataCenter) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithCustomView:self.pedometerBtn];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.assistantBtn];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.pkFriendBtn];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:self.dataCenterBtn];
    
    self.navigationItem.leftBarButtonItems = @[item0, item1, item2, item3];
    
}

- (void)showPedometer
{
    NIDPRINT(@"1");
    if (_lastTabViewController == nil || _lastTabViewController != _stepsMainViewController) {
        
        [self changeToViewController:
         self.stepsMainViewController naviTabBtn:_pedometerBtn];
    }
    
}
- (void)showFriendPK
{
    NIDPRINT(@"2");
    if (_lastTabViewController == nil || _lastTabViewController != _stepsFriendPKViewController) {
        
        [self changeToViewController:self.stepsFriendPKViewController naviTabBtn:self.pkFriendBtn];
    }
}
- (void)showDataCenter
{
    NIDPRINT(@"3");
    if (_lastTabViewController == nil || _lastTabViewController != _stepsDataCenterViewController) {
        
        [self changeToViewController:self.stepsDataCenterViewController naviTabBtn:self.dataCenterBtn];
    }
}
- (void)showAssistantCenter
{
    NIDPRINT(@"4");
    if (_lastTabViewController == nil || _lastTabViewController != _stepsAssistantViewController) {
        
        [self changeToViewController:self.stepsAssistantViewController naviTabBtn:self.assistantBtn];
    }
    
}

- (void)changeToViewController:(UIViewController *)controller naviTabBtn:(JHNavigationButton *)naviTabBtn
{
    //移除所有控制器
    [self removeChildViewControllers];
    //添加当前控制器
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    self.lastTabViewController = controller;
    
    self.lastTabBtn.selected = NO;
    self.lastTabBtn = naviTabBtn;
    self.lastTabBtn.selected = YES;
}

- (void)removeChildViewControllers {
    for (UIViewController *sub in self.childViewControllers) {
        [sub willMoveToParentViewController:nil];
        [sub.view removeFromSuperview];
        [sub removeFromParentViewController];
    }
}

@end
