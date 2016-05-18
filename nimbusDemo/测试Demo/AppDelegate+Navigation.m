//
//  AppDelegate+Navigation.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/29.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "AppDelegate+Navigation.h"
#import "JHIndexViewController.h"


@implementation AppDelegate (Navigation)

- (void)popToRootViewControllerOnCompletion:(void(^)(void))completion {
    
    [self popToRootViewControllerAnimated:YES onCompletion:completion];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated onCompletion:(void (^)(void))completion {
    NIDASSERT(completion != nil);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.topViewController.navigationController popToRootViewControllerAnimated:animated completion:completion];
    });
}

- (void)popViewControllerOnCompletion:(void (^)(void))completion {
    NIDASSERT(completion != nil);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.topViewController.navigationController popViewControllerAnimated:YES completion:completion];
    });
}

- (void)pushViewController:(UIViewController *)controller onCompletion:(void (^)(void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self pushViewController:controller animated:YES onCompletion:completion];
    });
}

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated onCompletion:(void (^)(void))completion {
    // refer to testChain in RequirementChain.m for why we need to dispatch on main_queue
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.topViewController.navigationController pushViewController:controller animated:animated completion:completion];
    });
}

//
// 在最上层的ViewController上打开一个新的ViewController
//
- (void)pushViewController: (UIViewController*)controller animated: (BOOL) animated {
    [[self topViewController].navigationController pushViewController: controller animated: animated];
}

@end
