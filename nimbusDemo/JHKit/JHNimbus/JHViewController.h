//
//  JHViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHViewController : UIViewController
/**
 *  view已加载完成
 */
@property (nonatomic, readonly) BOOL hasViewAppeared;

/**
 * The view is about to appear and has not appeared yet.
 */
@property (nonatomic, readonly) BOOL isViewAppearing;
/**
 *  viewDidAppear -> viewWillDisappear
 */
@property (nonatomic) BOOL isViewAppeared;
/**
 * Determines if the view will be resized automatically to fit the keyboard.
 */
@property (nonatomic) BOOL autoresizesForKeyboard;
/**
 *  是否需要NavigationBar
 *
 *  @return bool
 */
@property (nonatomic) BOOL needNavigationBar;

/**
 *  是否需要借助 ParentViewController的NavigationController
 如果某个JHViewController是作为一个子ViewController, 没有放在Navigation Stack中，为了代码中可以正常使用
 self.navigationController 可以将改属性设置为 YES
*/
@property (nonatomic) BOOL needParentNavigationController;
/**
 *  是否需要ScrollView
 */
@property (nonatomic) BOOL needScrollView;
/**
 *  jhScrollView
 */
@property (nonatomic, strong) JHScrollView *jhScrollView;

/**
 *  初始化方法
 *
 *  @param query 参数传入（字典）
 *
 *  @return 
 */
- (id) initWithQuery:(NSDictionary *)query;
/**
 *  将当前的UIViewController从NavigationStack中弹出
 *
 *  @param animated
 */
- (void) jhPopViewControllerAnimated: (BOOL) animated;
/**
 * Sent to the controller before the keyboard slides in.
 */
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller before the keyboard slides out.
 */
- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller after the keyboard has slid in.
 */
- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds;

/**
 * Sent to the controller after the keyboard has slid out.
 */
- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds;
/**
 *  通过颜色来生成一个纯色的背景图片
 *
 *  @param color color
 *
 *  @return image
 */
- (UIImage *) getImageFromColor:(UIColor *)color;

/**
 * show laoding animation
 */

@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, strong) UIView* errorView;

@property (nonatomic, strong) UIView* emptyView;

@property (nonatomic, retain) UIBarButtonItem * backNavigationButton;

//
// 用于Flurry中用作Event的名字; 默认为当前页面的title，但是如果title是可变的，则最好重现实现 flurryTitle
//
@property (nonatomic, strong) NSString* flurryTitle;

- (void)showLoading:(BOOL)show;
- (void)showLoading:(BOOL)show withText:(NSString *)text;


- (void)showError:(BOOL)show;
- (void)showError:(BOOL)show withText:(NSString *)text;

- (void)showEmpty:(BOOL)show;
- (void)showEmpty:(BOOL)show withText:(NSString *)text;

- (void)reloadOnError;



@end
