//
//  JHPopWindowView.m
//  JHPopWindow
//
//  Created by Shenjinghao on 16/3/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//


#define IOSOVER(v) ([[UIDevice currentDevice].systemVersion floatValue] >= v)


#import "JHPopWindowView.h"



static UIWindow *popWindow;

@implementation JHPopWindowView

//重写全能初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _popWindowLevel = UIWindowLevelNormal;
        _tapBackgroundToDismiss = YES;
        _direction = kPopWindowViewNone;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame windowLevel:(UIWindowLevel)windowLevel
{
    self = [self initWithFrame:frame];
    if (self) {
        _popWindowLevel = windowLevel;
    }
    return self;
}

+ (UIWindow *)window
{
    return [self windowWithLevel:UIWindowLevelNormal];
}

+ (UIWindow *)windowWithLevel:(UIWindowLevel)windowLevel
{
    if (popWindow == nil) {
        popWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        popWindow.windowLevel = windowLevel;
        if (!IOSOVER(7)) {
            [popWindow makeKeyAndVisible];
        }
    }else{
        
    }
    popWindow.hidden = NO;
    return popWindow;
}
#pragma mark 显示浮层
- (void) show:(PopWindowViewShowDirection)direction isInWindow:(BOOL)isInWindow
{
    if (_isShowing) {
        return;
    }
    [self creatViewsInWindow:isInWindow];
    //获取当前的direction
    _direction = direction;
    //展示的方式不同
    if (_direction == kPopWindowViewFromCenter) {
        [self showFromCenter];
    }else if (_direction == kPopWindowViewFromBottom) {
        [self showFromBottom];
    }else if (_direction == kPopWindowViewNomal) {
        [self showFromNormal];
    }
}
- (void) creatViewsInWindow:(BOOL)isInWindow
{
    _isInWindow = isInWindow;
    _popWindowBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    // 取消蒙版
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _popWindowBackView.frame.size.width, _popWindowBackView.frame.size.height)];
    
    if (_popWindowBackgroundColor) {
        [cancelBtn setBackgroundColor:_popWindowBackgroundColor];
    }else {
        [cancelBtn setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    }
    [_popWindowBackView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelTapped) forControlEvents:UIControlEventTouchUpInside];
    
    if (_isInWindow) {
        [[JHPopWindowView windowWithLevel:_popWindowLevel] addSubview:_popWindowBackView];
    }else{
        _popWindowBackView.frame = [[UIApplication sharedApplication].delegate window].rootViewController.view.bounds;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_popWindowBackView];
    }
    
    
    
}
#pragma mark 三种展示浮层方法
- (void) showFromCenter
{
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
    }];
    [self showFromNormal];
    
}

- (void) showFromBottom
{
    [_popWindowBackView addSubview:self];
    _isShowing = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.frame;
//        tempFrame.origin.y = _popWindowBackView.frame.size.height - tempFrame.size.height;
//        tempFrame.origin.x = _popWindowBackView.frame.size.width / 2 + tempFrame.size.width / 2;
        tempFrame.origin.y = 50;
        tempFrame.origin.x = 50;
        self.frame = tempFrame;
        
    }];
}

- (void) showFromNormal
{
    self.center = CGPointMake(_popWindowBackView.frame.size.width / 2, _popWindowBackView.frame.size.height / 2);
    [_popWindowBackView addSubview:self];
    _isShowing = YES;
}
#pragma mark 取消按钮点击
- (void)cancelTapped {
    if (self.tapBackgroundToDismiss) {
        [self dismiss];
    } else {
        [self dismiss];
    }
}

+ (void)hideWindow
{
    //???
    if (popWindow.subviews.count == 0) {
        
        NSLog(@"haha");
        
    }
    [popWindow resignKeyWindow];
    popWindow = nil;
}

#pragma mark 处理消失的逻辑
- (void)dismiss
{
    [self dismissWithResult:nil];
}

- (void) dismissWithResult:(NSDictionary *)result
{
    _result = result;
    switch (_direction) {
        case kPopWindowViewFromCenter:
            [self dismissToCenter];
            break;
        case kPopWindowViewFromBottom:
            [self dismissToBottom];
            break;
        case kPopWindowViewNomal:
            [self didDismissed];
            break;
        default:
            break;
    }
    
}
#pragma mark 三种消失方式
- (void)dismissToBottom {
    [UIView animateWithDuration: 0.3
                     animations: ^{
                         //直接赋值有问题-->“expression is not assignable”
                         CGRect tempFrame = self.frame;
                         tempFrame.origin.y = _popWindowBackView.frame.size.height;
                         self.frame = tempFrame;
                         
                     }
                     completion: ^(BOOL finished) {
                         [self didDismissed];
                     }];
}

- (void)dismissToCenter {
    _popWindowBackView.hidden = YES;
    [self didDismissed];
}

- (void)didDismissed
{
    if (_addResult) {
        NSMutableDictionary *tempDict = [_result mutableCopy];
        [tempDict addEntriesFromDictionary:_addResult];
        _result = tempDict;
    }
    if (self.dismissBlock) {
        self.dismissBlock(self, _result);
    }
    [_popWindowBackView removeFromSuperview];
    if (_isInWindow) {
        [JHPopWindowView hideWindow];
    }
    [self clean];
}

- (void) clean
{
    if (_isShowing) {
        _isShowing = NO;
        _result = nil;
    }
}

- (void)dealloc
{
    [self clean];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
