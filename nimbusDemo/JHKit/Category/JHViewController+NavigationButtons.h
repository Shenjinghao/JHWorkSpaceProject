//
//  JHViewController+NavigationButtons.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"
@class NaviButton;

@interface JHViewController (NavigationButtons)



- (void)showCustomazieLoading:(NSString *) msg;

- (void)hideCustomazieLoading;

@property (nonatomic) BOOL hidesBackButton; // 通过property来实现成员变量
- (NaviButton*) createBackButton:(BOOL)leftArrow; // 返回按钮(背景为尖角或者圆角)
- (NaviButton*) createBackButton:(BOOL)leftArrow title: (NSString*) title;
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton leftCapWidth: (CGFloat) capWidth;
// 返回上一级ViewController
-(void) backToLastController: (id)sender;

// 添加指定title和selector的NavigationBar (Left Button)
//
- (void) setLeftNavigationButtonItem: (NSString*) title selector: (SEL) selector;
//
// 添加指定title和selector的NavigationBar (Right Button)
//
- (void) setRightNavigationButtonItem: (NSString*) title selector: (SEL) selector;

//
// 将button添加到右侧的NavigationBar上, 允许用户定制Button的样式，事件
//
- (void) setRightNavigationButton: (NaviButton*) button;

- (void) setLeftNavigationButton: (NaviButton*) button;


@end


@interface NaviButton : UIButton

@property (nonatomic, assign) BOOL isLeftButton;

@end


@interface NaviView: UIView

@property (nonatomic, assign) BOOL isLeftButton;

@end


