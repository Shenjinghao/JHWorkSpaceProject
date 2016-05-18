//
//  JHIndexViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"
#import "JHTabBarController.h"

@interface JHIndexViewController : JHViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) JHTabBarController *tabbarController;

+ (JHIndexViewController *) sharedInstance;
/**
 *  找到tabbarController
 *
 *  @return <#return value description#>
 */
- (JHTabBarController*)rootTabbarController;

@end
