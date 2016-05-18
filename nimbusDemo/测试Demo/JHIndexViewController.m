//
//  JHIndexViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHIndexViewController.h"
#import "JHNavigationController.h"
#import "JHHomeViewController.h"
#import "JHPatientViewController.h"
#import "JHServiceViewController.h"
#import "JHOtherViewController.h"

@implementation JHIndexViewController
{
    NSArray                         *_tabControllerArray;
    NSInteger                       _currentSelected;
    NSInteger                       _currentSelectedNavigation;
    UIView*                         _contentView;
    NSArray*                        _prevViewControllers;// 当前navigationController中的viewcontrollers
}


/**
 *  初始化只运行一次
 *
 *  @return
 */
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (JHIndexViewController *)sharedInstance
{
    static dispatch_once_t onceToken;
    static JHIndexViewController *VC = nil;
    dispatch_once(&onceToken, ^{
        VC = [[self alloc]init];
    });
    return VC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildTabbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**
     *  如果需要设置 title 需要实现下面的方法？？？？
     */
    self.navigationController.navigationBarHidden = YES;
}

-(void) buildTabbar
{
    if (!_tabControllerArray) {
        JHHomeViewController *homeVC = [[JHHomeViewController alloc] initWithQuery:nil];
        JHPatientViewController *patientVC = [[JHPatientViewController alloc] initWithQuery:nil];
        JHServiceViewController *serviceVC = [[JHServiceViewController alloc] initWithQuery:nil];
        JHOtherViewController *otherVC = [[JHOtherViewController alloc] initWithQuery:nil];
        
        JHNavigationController *homeNav = [[JHNavigationController alloc] initWithRootViewController:homeVC];
        JHNavigationController *patientNav = [[JHNavigationController alloc] initWithRootViewController:patientVC];
        JHNavigationController *serviceNav = [[JHNavigationController alloc] initWithRootViewController:serviceVC];
        JHNavigationController *otherNav = [[JHNavigationController alloc] initWithRootViewController:otherVC];
        
        _tabControllerArray = @[homeNav,patientNav,serviceNav,otherNav];
        
        // 设置navigationDelegate设置tabBar出现和隐藏
        for (UINavigationController* controller in _tabControllerArray) {
            controller.delegate = self;
        }
    }
    
    if (!_tabbarController) {
        _tabbarController = [[JHTabBarController alloc] init];
        [_tabbarController setViewControllers:_tabControllerArray];
        _tabbarController.view.frame = self.view.frame;
        [self.view addSubview:_tabbarController.view];
        [self addChildViewController:_tabbarController];
        
    }
    
    //默认选中第一个tab
    [_tabbarController setSelectedIndex:0];
}

#pragma mark- UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
    
}

#pragma mark - find tabbar controller

- (JHTabBarController*)rootTabbarController
{
    __block JHTabBarController* controller = nil;
    [self.childViewControllers enumerateObjectsUsingBlock:^(JHTabBarController* ctr, NSUInteger idx, BOOL *stop) {
        
        if ([ctr isKindOfClass:[JHTabBarController class]]) {
            
            controller = ctr;
            *stop = YES;
        }
    }];
    return controller;
}

@end
