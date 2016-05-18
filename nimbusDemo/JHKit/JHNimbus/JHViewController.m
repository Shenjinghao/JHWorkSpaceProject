//
//  JHViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"
#import "NSNotificationCenter+RACSupport.h"
#import "RACSignal.h"
#import "NSObject+RACDeallocating.h"
#import "RACSignal+Operations.h"

@implementation JHViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.hidesBottomBarWhenPushed = YES;
        
        //注意，如果这里对view进行操作，那子类必然会初始化view，必然会viewdidload，会导致viewdidload在init之前！！！
//        self.view.backgroundColor = [JHResource viewBackgroundColor];
        
        self.needScrollView = NO;
        if ([JHUtility JHOveriOS:7]) {
            self.extendedLayoutIncludesOpaqueBars = YES;
            self.automaticallyAdjustsScrollViewInsets = YES;
            // http://blog.jaredsinclair.com/post/61507315630/wrestling-with-status-bars-and-navigation-bars-on-ios-7
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
        WEAK_VAR(self);
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            
            [_self showLoading: NO];
        }];
    }
    return self;
}

/**
 *  - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 中初始化函数也会被调用
 *
 *  @param query
 *
 *  @return
 */
- (id)initWithQuery:(NSDictionary *)query
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}
/**
 *  默认的构造函数最终resort to initWithNibName:bundle
 *
 *  @return <#return value description#>
 */
- (id)init {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    NIDPRINT(@"%@ has been dealloced",[self class]);
    /**
     *  停止监控键盘
     */
    self.autoresizesForKeyboard = NO;
    
}


- (BOOL) needNavigationBar {
    return YES;
}

- (BOOL) defaultNavigationBarAnimation {
    return YES;
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return (NSUInteger)(UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationPortrait == toInterfaceOrientation | UIInterfaceOrientationPortraitUpsideDown == toInterfaceOrientation;
}

- (void)loadView
{
    // 注意: 此代码可能被 Category给覆盖了
    if (nil != self.nibName) {
        [super loadView];
        
    } else{
        CGRect frame = self.wantsFullScreenLayout ? JHScreenBounds() : JHNavigationFrame();
        if (self.needScrollView) {
            self.view = [[UIView alloc] initWithFrame:frame];
            /**
             *  一个布尔值来决定是否接收其范围变化时自动调整它的子视图
             */
            self.view.autoresizesSubviews = YES;
            /**
             *  一个整数位屏蔽时,决定了接收机调整本身它的父视图的范围内变化。
             */
            self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            self.jhScrollView = [[JHScrollView alloc] initWithFrame:frame];
            self.jhScrollView.autoresizesSubviews = YES;
            self.jhScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }else{
            self.view = [[UIView alloc] initWithFrame:frame];
            self.view.autoresizesSubviews = YES;
            self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
        //背景色
        self.view.backgroundColor = [JHResource viewBackgroundColor];
    }
    
    //这里的viewStack为什么是nil？？？？？
//    NSArray* viewStack = self.navigationController.viewControllers;
//    if (([viewStack count] > 1) && (self.navigationItem.leftBarButtonItem == nil)){}
    
    
    // 除了首页，其他页面都需要"Back　Button" 箭头形式的返回键
    if (self.navigationItem.leftBarButtonItem == nil) {
        NaviButton* backButton = [self createBackButton: YES]; // YES
        backButton.isLeftButton = YES;
        
        self.backNavigationButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = self.backNavigationButton;
        
    }
    
}

#pragma mark 设置navigationbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isViewAppeared = YES;
    _hasViewAppeared = YES;
    
    // 3. 首页NavigationBar被隐藏，但是其他页面需要NavigationBar
    if ([self needNavigationBar]) {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated: [self defaultNavigationBarAnimation]];
        }
        
    } else {
        if (!self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:YES animated: [self defaultNavigationBarAnimation]];
        }
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _isViewAppeared = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isViewAppeared = NO;
    _isViewAppearing = NO;
}

- (void)didReceiveMemoryWarning
{
    if (_hasViewAppeared && !_isViewAppearing) {
        [super didReceiveMemoryWarning];
        _hasViewAppeared = NO;
        
    } else {
        [super didReceiveMemoryWarning];
    }
}

//
// 用于Flurry中用作Event的名字; 默认为当前页面的title，但是如果title是可变的，则最好重现实现 flurryTitle
//
- (NSString* ) flurryTitle {
    if (_flurryTitle) {
        return  _flurryTitle;
    }
    //    else if (self.title) {
    //        return self.title;
    //    }
    else {
        return [[self class] description];
    }
}

/**
 *  autoresizesForKeyboard的set方法（赋值）
 *
 *  @param autoresizesForKeyboard
 */
- (void)setAutoresizesForKeyboard:(BOOL)autoresizesForKeyboard
{
    if (autoresizesForKeyboard != _autoresizesForKeyboard) {
        _autoresizesForKeyboard = autoresizesForKeyboard;
        if (_autoresizesForKeyboard) {
            /**
             *  添加键盘相关的Event
             */
            WEAK_VAR(self);
            //ReactiveCocoa
            [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
                [self keyboardWillShow:x];
            }];
            
            [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
                
                [_self keyboardDidShow:x];
            }];
            
            [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
                
                [_self keyboardWillHide:x];
            }];
            
            [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
                
                [_self keyboardDidHide:x];
            }];

        }else{
            
        }
    }
}

/**
 *  处理ViewController自己没有NavigationBar的情况
 *
 *  @return navigationController
 */
- (UINavigationController *) navigationController
{
    UINavigationController *navigationController = [super navigationController];
    if (!_needParentNavigationController || navigationController) {
        return navigationController;
    }
    UIViewController *viewController = [self parentViewController];
    while (viewController) {
        navigationController = viewController.navigationController;
        if (navigationController) {
            return navigationController;
        }else{
            viewController = viewController.parentViewController;
        }
    }
    return nil;
}

- (void)jhPopViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark 模态跳转
//
// modalViewController不是UINavigationController,
// 和[self presentModalViewController: animated:]相比，多了一步将 modalViewController包装的过程
//
- (void) jhPresentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated {
    if (![modalViewController isKindOfClass:[UINavigationController class]]) {
        modalViewController = [[JHNavigationController alloc] initWithRootViewController: modalViewController];
    }
    
    [self presentViewController: modalViewController
                       animated: YES
                     completion: NULL];
}

//
// 简写
//
- (void) jhPresentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController: viewController animated: animated];
}

#pragma mark - UIKeyboardNotifications
/**
 *  keyboard通知的顺序:willShow didShow willHide didHide
 *  键盘的动画是从willShow开始执行,所以绑定键盘的动画也从willShow开始
 *  具体实现中 绑定键盘的动画通过
 *  keyboardWillAppear:animated withBounds:bounds
 *  keyboardWillDisAppear:animated withBounds:bounds
 *  实现,其中bounds代表弹出键盘的bounds.
 *
 *  keyboardDidAppear:animated withBounds:bounds
 *  keyboardDidAppear:animated withBounds:bounds
 *  负责处理键盘弹出和消失后的一些动作,比如，记录下某个view的位置等
 *  ios7 只有一个键盘，一个地方的键盘操作也会影响其他viewcontroller中的键盘
 */

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillShow:(NSNotification*)notification {
    
    if (self.isViewAppeared) {
        [self resizeForKeyboard:notification appearing:YES];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidShow:(NSNotification*)notification {
    if (self.isViewAppeared) {
        CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyboardDidAppear:YES withBounds: endFrame];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardWillHide:(NSNotification*)notification {
    
    if (self.isViewAppeared) {
        [self resizeForKeyboard:notification appearing:NO];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)keyboardDidHide:(NSNotification*)notification {
    if (self.isViewAppeared) {
        CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyboardDidDisappear: YES withBounds:endFrame];
    }
}
/**
 *  键盘出现与消失的notification的发送时机包括
 *  1）键盘的弹入、弹出
 *  2）viewController消失与出现带动keyboard的消失与出现
 *
 */
- (void)resizeForKeyboard:(NSNotification*)notification appearing:(BOOL)appearing
{
    
    CGRect keyboardEnds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView beginAnimations: nil context: NULL];
    [UIView setAnimationCurve: [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationDuration: [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    if (appearing) {
        [self keyboardWillAppear:YES withBounds:keyboardEnds];
        
    } else {
        [self keyboardWillDisappear:YES withBounds:keyboardEnds];
    }
    
    [UIView commitAnimations];
    
}
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds
{
    // Empty default implementation.
}

- (void)keyboardDidAppear:(BOOL)animated withBounds:(CGRect)bounds
{
    // Empty default implementation.
}

-(void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds
{
    // Empty default implementation.
}

- (void)keyboardDidDisappear:(BOOL)animated withBounds:(CGRect)bounds
{
    // Empty default implementation.
}

#pragma mark  通过颜色来生成一个纯色的背景图片
- (UIImage *) getImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#pragma mark loading

-(void)showLoading:(BOOL)show
{
    [self showLoading:show withText:nil];
}

- (void)showLoading:(BOOL)show withText:(NSString *)text
{
    if (show) {
        [self showLoadingWithText:text];
    }else{
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
    self.view.userInteractionEnabled = !show;
}

- (void)showLoadingWithText:(NSString *)text
{
    if (self.loadingView) {
        self.loadingView = [[JHLoadingView alloc] init];
        [self.view addSubview:self.loadingView];
    }
    JHLoadingView *loadingView = (JHLoadingView *)self.loadingView;
    [loadingView updateWithText:text];
    CGRect rect = [self pageFrame];
    self.loadingView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
}

- (void)showError:(BOOL)show
{
    [self showError:show withText:nil];
}

- (void)showError:(BOOL)show withText:(NSString *)text
{
    if (show) {
        if (self.errorView == nil) {
            self.errorView = [[ErrorView alloc] init];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadOnError)];
            self.errorView.userInteractionEnabled = YES;
            [self.errorView addGestureRecognizer:tap];
            
            [self.view addSubview:self.errorView];
        }
        ErrorView *errorView = (ErrorView *)self.errorView;
        [errorView updateWithText:text];
        CGRect rect = [self pageFrame];
        self.loadingView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    }else {
        [self.errorView removeFromSuperview];
        self.errorView = nil;
    }
}

- (void)showEmpty:(BOOL)show
{
    [self showEmpty:show withText:nil];
}

-(void)showEmpty:(BOOL)show withText:(NSString *)text
{
    if (show) {
        if (self.emptyView == nil) {
            self.emptyView = [JHEmptyView new];
            [self.view addSubview:self.emptyView];
        }
        JHEmptyView *emptyView = (JHEmptyView *)self.emptyView;
        [emptyView updateWithText:text];
        
        CGRect rect = [self pageFrame];
        self.emptyView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    }
    else {
        [self.emptyView removeFromSuperview];
        self.emptyView = nil;
    }
}

- (CGRect)pageFrame
{
    CGRect rect = JHNavigationFrame();
    rect.size.height -= 44;
    return rect;
}

- (void)reloadOnError
{
    
}

@end















