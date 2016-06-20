//
//  JHPopWindowView.h
//  JHPopWindow
//
//  Created by Shenjinghao on 16/3/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PopWindowViewShowDirection) {
    kPopWindowViewFromCenter,
    kPopWindowViewFromBottom,
    kPopWindowViewNomal,
    kPopWindowViewNone
};

@class JHPopWindowView;

//PopWindowView消失的block
typedef void(^PopWindowViewDismissBlock)(JHPopWindowView *PopWindowView, NSDictionary *result);


@interface JHPopWindowView : UIView

@property (nonatomic, copy) PopWindowViewDismissBlock dismissBlock;
@property (nonatomic) PopWindowViewShowDirection direction;
@property (nonatomic) BOOL isShowing;
@property (nonatomic) BOOL isInWindow;
@property (nonatomic, strong) NSDictionary *result;
@property (nonatomic, strong) NSDictionary *addResult;   //额外传递的参数
@property (nonatomic) BOOL tapBackgroundToDismiss;
@property (nonatomic) CGFloat popWindowLevel;
@property (nonatomic, strong) UIColor *popWindowBackgroundColor;
@property (nonatomic, strong) UIView *popWindowBackView;

//某些情况下JHPopWindowView上的window需要占据alert位置时使用
- (instancetype) initWithFrame:(CGRect)frame windowLevel:(UIWindowLevel)windowLevel;

+ (UIWindow *) window;
+ (UIWindow *) windowWithLevel:(UIWindowLevel)windowLevel;
+ (void)hideWindow;

- (void) show:(PopWindowViewShowDirection)direction isInWindow:(BOOL)isInWindow;
- (void) dismiss;
- (void) dismissWithResult:(NSDictionary *)result;

@end
