//
//  JHTopYellowBannerManager.h
//  测试Demo
//
//  Created by Shenjinghao on 16/5/25.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTopYellowBannerManager : NSObject

@property (nonatomic, weak) UIWindow *window;

+ (instancetype)sharedInstance;

- (void)showTopBannerViewWithUserInfo:(NSDictionary *)userInfo actionBlock:(void (^)())actionBlock;

//- (void)showTopBannerViewWithView:(UIView *)view WithUserInfo:(NSDictionary *)userInfo actionBlock:(void (^)())actionBlock;

- (void)removeAllTopBannerViewWithAnimation:(BOOL)isAnimated completion:(void (^)())completion;

@end


typedef void (^ShowFinishBlock)(void);

@interface JHTopYellowBannerView : UIView

@property (nonatomic, copy) ShowFinishBlock showFinishBlock;

@property (nonatomic, strong) NSDictionary *userInfo;

- (void)showInWindow:(UIWindow *)window;

- (void)updateWithTitle:(NSString *)title;

- (void)close;

- (void)closeWithAnimation:(BOOL)isAnimated completion:(void (^)())completion;

@end

