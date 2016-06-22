//
//  JHTopYellowBannerManager.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/25.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTopYellowBannerManager.h"
#import <ReactiveCocoa.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JHViewController.h"
#import "AppDelegate.h"
#import "UIView+JHGesturesBlock.h"

@interface JHTopYellowBannerManager ()

@property (nonatomic, strong) NSMutableArray *topBannerViews;

@end

@implementation JHTopYellowBannerManager

+ (instancetype)sharedInstance
{
    static JHTopYellowBannerManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHTopYellowBannerManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _topBannerViews = [NSMutableArray array];
    }
    return self;
}

- (void)showTopBannerViewWithUserInfo:(NSDictionary *)userInfo actionBlock:(void (^)())actionBlock
{
    JHTopYellowBannerView *view = [[JHTopYellowBannerView alloc] initWithFrame:CGRectZero];
    view.userInfo = userInfo;
    view.showFinishBlock = ^(){
        //如果当前页有presentedViewController,并且不为navigationcontroller则先让它消失
        JHViewController *vc = [AppDelegate sharedInstance].topViewController;
        if (vc.presentedViewController && ![vc.presentedViewController isKindOfClass:[UINavigationController class]]) {
            [vc dismissViewControllerAnimated:YES completion:^{
                if (actionBlock) {
                    actionBlock();
                }
            }];
        }else{
            if (actionBlock) {
                actionBlock();
            }
        }
    };
    
    [view updateWithTitle:userInfo[@"title"]];
    
    UIWindow *window = self.window ? : [AppDelegate sharedInstance].window;
    [self removeAllTopBannerViewWithAnimation:YES completion:^{
        [_topBannerViews addObject:view];
        [view showInWindow:window];
    }];
    
}

- (void)removeAllTopBannerViewWithAnimation:(BOOL)isAnimated completion:(void (^)())completion
{
    if (isAnimated) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            for (JHTopYellowBannerView *view in _topBannerViews) {
                view.alpha = 0;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                for (JHTopYellowBannerView *view in _topBannerViews) {
                    [view removeFromSuperview];
                }
                [_topBannerViews removeAllObjects];
                if (completion) {
                    completion();
                }
            }
        }];
    }else{
        for (JHTopYellowBannerView *view in _topBannerViews) {
            [view removeFromSuperview];
        }
        [_topBannerViews removeAllObjects];
        if (completion) {
            completion();
        }
    }
}

- (void)removeTopBannerViewsAtIndex:(NSInteger)index
{
    if (index >= self.topBannerViews.count || self.topBannerViews.count <= 0) {
        return;
    }
    //处理多个小黄条出现的问题
    if (index == self.topBannerViews.count - 1) {
        //如果是最后一个
        [self.topBannerViews removeObjectAtIndex:index];
    }else{
        for (NSInteger i = index + 1; i < self.topBannerViews.count; i ++) {
            JHTopYellowBannerView *view = self.topBannerViews[i];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                view.top -= view.height + 2;
            } completion:^(BOOL finished) {
                
            }];
        }
        [self.topBannerViews removeObjectAtIndex:index];
    }
    
}

@end

@implementation JHTopYellowBannerView
{
    UILabel *_topViewLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat top = NIStatusBarHeight() + 44;
    frame = CGRectMake(2, top+2, viewWidth() - 4, 40);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(255, 178, 45, 0.95);
        
        [self jhAddTapGestureWithTarget:self selector:@selector(tapOnTopBanaerView:)];
        
        _topViewLabel = [UILabel labelWithFrame:CGRectMake(15, 12.5, viewWidth() - 50, 15)
                                fontSize:15
                               fontColor:[UIColor whiteColor]
                                    text:nil];
        [self addSubview:_topViewLabel];
        //右边关闭
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 38 , 0, 38, 40)];
        [closeBtn setImage:[UIImage imageNamed:@"close_button_icon"]
                  forState:UIControlStateNormal];
        [[[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:closeBtn.rac_willDeallocSignal] subscribeNext:^(id x) {
            [self close];
        }];
        closeBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 10, 11, 10);
        
        [self addSubview:closeBtn];
        
    }
    return self;
}

- (void)tapOnTopBanaerView:(id)sender
{
    if (self.showFinishBlock) {
        self.showFinishBlock();
    }
    [self close];
}

- (void)updateWithTitle:(NSString *)title
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    _topViewLabel.text = title;
}

- (void)showInWindow:(UIWindow *)window
{
    [window addSubview:self];
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)close
{
    [self closeWithAnimation:NO completion:nil];
}

- (void)closeWithAnimation:(BOOL)isAnimated completion:(void (^)())completion
{
    if (isAnimated) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self clear];
                if (completion) {
                    completion();
                }
            }
        }];
    }else{
        [self clear];
        if (completion) {
            completion();
        }
    }
}

- (void)clear
{
    [self removeFromSuperview];
    //获取index
    NSInteger index = [[JHTopYellowBannerManager sharedInstance].topBannerViews indexOfObject:self];
    //根据index移除topBanaerView
    [[JHTopYellowBannerManager sharedInstance] removeTopBannerViewsAtIndex:index];
}

@end

