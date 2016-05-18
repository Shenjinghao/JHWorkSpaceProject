//
//  UINavigationController+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//


static NSString *const kPendingViewControllerKey = @"kPendingViewControllerKey";
static NSString *const kNavigationAnimationKey = @"kNavigationAnimationKey";
static NSString *const kNavigationCompletionBlockKey = @"kNavigationCompletionBlockKey";

#import "UINavigationController+JHCategory.h"
#import <objc/runtime.h>


@implementation UINavigationController (JHCategory)
/**
 *  重载运行时
 *
 *  @return
 */

- (BOOL)isAnimating {
    NSNumber *num = objc_getAssociatedObject(self, &kNavigationAnimationKey);
    return [num boolValue];
}

- (void)setIsAnimating:(BOOL)isAnimating {
    objc_setAssociatedObject(self, &kNavigationAnimationKey, @(isAnimating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//
- (UIViewController *)viewControllerToBePushed {
    return objc_getAssociatedObject(self, &kPendingViewControllerKey);
}

- (void)setViewControllerToBePushed:(UIViewController *)viewControllerToBePushed {
    objc_setAssociatedObject(self, &kPendingViewControllerKey, viewControllerToBePushed, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//
- (void)setCompletionBlock:(NavigationCompleteBlock)completionBlock {
    objc_setAssociatedObject(self, &kNavigationCompletionBlockKey, completionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NavigationCompleteBlock)completionBlock {
    return objc_getAssociatedObject(self, &kNavigationCompletionBlockKey);
}

#pragma mark public

- (UIViewController *)popViewControllerAnimated:(BOOL)animated completion:(NavigationCompleteBlock)completion {
    self.delegate = self;
    self.completionBlock = completion;
    return [self popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(NavigationCompleteBlock)completion {
    self.delegate = self;
    self.completionBlock = completion;
    return [self popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completion:(NavigationCompleteBlock)completion {
    self.delegate = self;
    self.completionBlock = completion;
    return [self popToRootViewControllerAnimated:animated];
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(NavigationCompleteBlock)completion {
    self.completionBlock = completion;
    [self pushViewController:viewController animated:animated];
}

- (NSString *)tabImageNameSel {
    return [(self.viewControllers)[0] tabImageNameSel];;
}

- (NSString *)tabImageName
{
    return [(self.viewControllers)[0] tabImageName];
}

- (NSString *)tabTitle
{
    return [(self.viewControllers)[0] tabTitle];
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isAnimating = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    self.isAnimating = NO;
    
    NavigationCompleteBlock completionBlock = self.completionBlock;
    self.completionBlock = nil;
    if (completionBlock) {
        completionBlock();
    }
    
    if (self.viewControllerToBePushed) {
        [navigationController pushViewController:self.viewControllerToBePushed animated:NO];
        self.viewControllerToBePushed = nil;
    }
}



@end
