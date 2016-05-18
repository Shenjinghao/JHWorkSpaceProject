//
//  UINavigationController+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

typedef void (^NavigationCompleteBlock) ();

#import <UIKit/UIKit.h>

@interface UINavigationController (JHCategory)<UINavigationControllerDelegate>

@property (nonatomic) BOOL isAnimating;   //是否在进行push 或 pop动画

/*
 通过通知或网络请求push进来的vc，可能会导致
 Unbalanced calls to begin/end appearance transitions for <uivewcontroller>
 原因就是上次动画还没结束，然后又开始了新的动画。
 */
@property (nonatomic, strong) UIViewController *viewControllerToBePushed;

@property (nonatomic, copy) NavigationCompleteBlock completionBlock;

- (void)setCompletionBlock:(NavigationCompleteBlock)completionBlock;
//push pop
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(NavigationCompleteBlock)completion;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(NavigationCompleteBlock)completion;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(NavigationCompleteBlock)completion;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(NavigationCompleteBlock)completion;

- (NSString *)tabImageName;

- (NSString *)tabTitle;

- (NSString *)tabImageNameSel;


@end
