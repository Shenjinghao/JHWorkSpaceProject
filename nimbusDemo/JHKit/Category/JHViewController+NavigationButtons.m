//
//  JHViewController+NavigationButtons.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#define kLargeButtonFontSize 24
#define kCUITextFieldHeight 46
#define MAX_BACK_BUTTON_WIDTH 160.0
#define kNaviButtonFontSize 14.0
#define kNaviButtonHeight 30

#define kNavigationButtonShadowOffset    CGSizeMake(0, -0.5)
#define kNavigationButtonTextShadowColor RGBACOLOR(0x00, 0x69, 0xba, 0.75)



#import "JHViewController+NavigationButtons.h"
#import "JHActivityView.h"


@implementation JHViewController (NavigationButtons)



- (void)showCustomazieLoading:(NSString *)msg
{
    if ([msg isNotEmpty]) {
        if (self.loadingView) {
            [self.loadingView removeFromSuperview];
            self.loadingView  = nil;
        }
        JHActivityView* view = [[JHActivityView alloc] initWithStyle: JHActivityLabelStyleBlackBox];
        CGRect rect = JHNavigationFrame();
        view.text = msg;
        [view sizeToFit];
        view.origin = CGPointMake((rect.size.width - view.width) / 2, (rect.size.height - view.height) / 2);
        self.loadingView = view;
        [self.view addSubview: self.loadingView];
    }else {
        [self.loadingView removeFromSuperview];
    }
    
}

- (void)hideCustomazieLoading
{
    [self.loadingView removeFromSuperview];
}

/**
 *  自定义navigbar的标题
 *
 *  @param title title
 */
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:18.0];
        titleView.shadowColor = RGBCOLOR_HEX(0x17628e);
        titleView.textColor = [UIColor whiteColor];
        
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.navigationItem.titleView = titleView;
    }
    
    titleView.text = title;
    [titleView sizeToFit];
}

#pragma mark - Back Button Customize
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)backToLastController: (id)sender {
    // 返回上一个ViewController
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  隐藏返回按钮
 *
 *  @return
 */
- (BOOL)hidesBackButton
{
    return self.navigationItem.hidesBackButton;
}

- (void)setHidesBackButton:(BOOL)hidesBackButton
{
    self.navigationItem.hidesBackButton = hidesBackButton;
    if (hidesBackButton) {
        /**
         *  如果要隐藏，则看看backNavigationButton是不是直接充当LeftButton
         */
        if (self.navigationItem.leftBarButtonItem == self.backNavigationButton) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }else{
        if (self.navigationItem.leftBarButtonItem == nil) {
            self.navigationItem.leftBarButtonItem = self.backNavigationButton;
        }
    }
}
/**
 *  创建navigationbarItem的返回按钮
 *
 *  @param leftArrow 左箭头
 *
 *  @return
 */
- (NaviButton *)createBackButton:(BOOL)leftArrow
{
    NaviButton* button = [NaviButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 30);
    
    [button setImage: [UIImage load: @"navi_white_left_arrow.png"] forState:UIControlStateNormal];
    
    [button        addTarget: self
                      action: @selector(backToLastController:)
            forControlEvents: UIControlEventTouchUpInside];
    
    return button;
}
//no
- (NaviButton *)createBackButton:(BOOL)leftArrow title:(NSString *)title
{
    NaviButton* button = [NaviButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:kNaviButtonFontSize];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = kNavigationButtonShadowOffset;
    button.titleLabel.shadowColor = kNavigationButtonTextShadowColor;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    button.frame = CGRectMake(0, 0, 0, 30); // 宽度为0, 可以自由扩展
    
    NSString* lastControllerTitle = title;
    // 自适应地调整Title Label的Size
    NSInteger leftCap = leftArrow ? 14: 10;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, leftCap, 0, 8);
    
    [self setText:lastControllerTitle onBackButton:button leftCapWidth: leftCap];
    
    if (leftArrow) {
        [button setBackgroundImage:[UIImage loadStretch:@"back_button.png" capWidth:24 capHeight:5]
                          forState:UIControlStateNormal];
        //        [button setBackgroundImage:naviButtonBackSel() forState:UIControlStateHighlighted];
        
    } else {
        [button setBackgroundImage:[UIImage loadStretch:@"navigation_button.png" capWidth:12 capHeight:8]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage loadStretch:@"navigation_button_pressed.png" capWidth:12 capHeight:8]
                          forState:UIControlStateHighlighted];
    }
    
    [button addTarget:self action:@selector(backToLastController:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NaviButton*) createNavigateButton: (NSString*) title selector: (SEL) selector {
    NaviButton* button = [NaviButton buttonWithType:UIButtonTypeCustom];
    
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:kNaviButtonFontSize];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.shadowOffset = kNavigationButtonShadowOffset;
    button.titleLabel.shadowColor = kNavigationButtonTextShadowColor;
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    
    CGSize textSize = [title sizeWithFont:button.titleLabel.font];
    
    UIEdgeInsets inset = button.titleEdgeInsets;
    CGFloat tmpWidth = textSize.width + MAX(0, inset.left) + MAX(0, inset.right);
    
    CGFloat width = MAX(MIN(tmpWidth, MAX_BACK_BUTTON_WIDTH), 59);
    
    button.frame = CGRectMake(0, 0, width, kNaviButtonHeight);
    
    
    
    [button setTitle: title forState: UIControlStateNormal];
    
    if (selector) {
        [button addTarget:self action: selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 导航栏按钮的样式
    //    [button setBackgroundImage: [CYResource loadStretch:@"navigation_button.png" capWidth:12 capHeight:8]
    //                      forState: UIControlStateNormal];
    //    [button setBackgroundImage: [CYResource loadStretch:@"navigation_button_pressed.png" capWidth:12 capHeight:8]
    //                      forState: UIControlStateHighlighted];
    //按钮样式改成扁平化，去掉效果图片
    [button setBackgroundImage: [UIImage loadStretch:@"" capWidth:12 capHeight:8]
                      forState: UIControlStateNormal];
    [button setBackgroundImage: [UIImage loadStretch:@"" capWidth:12 capHeight:8]
                      forState: UIControlStateHighlighted];
    
    return button;
}

#pragma mark private
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIBarButtonItem*) createNavigationButtonItem: (NSString*) title selector: (SEL) selector isLeft: (BOOL) isLeft {
    NaviButton *button = [self createNavigateButton:title selector:selector];
    button.isLeftButton = isLeft;
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateDisabled];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
/**
 *  自定义左端的返回按钮
 *
 *  @param title
 *  @param selector
 */
- (void)setLeftNavigationButtonItem:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem *item = [self createNavigationButtonItem:title selector:selector isLeft:YES];
    self.navigationItem.backBarButtonItem = item;
}

- (void)setLeftNavigationButton:(NaviButton *)button
{
    button.isLeftButton = YES;
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.navigationItem.leftBarButtonItem = item;
}

/**
 *  自定义右端的按钮
 *
 *  @param title
 *  @param selector
 */
- (void)setRightNavigationButtonItem:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem *item = [self createNavigationButtonItem:title selector:selector isLeft:NO];
    self.navigationItem.backBarButtonItem = item;
}

- (void)setRightNavigationButton:(NaviButton *)button
{
    button.isLeftButton = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

@end


@implementation NaviButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (UIEdgeInsets)alignmentRectInsets {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    // 只处理iOs7.0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (_isLeftButton) {
            insets = UIEdgeInsetsMake(0, 9.0f, 0, 0);
        }
        else { // IF_ITS_A_RIGHT_BUTTON
            insets = UIEdgeInsetsMake(0, 0, 0, 9.0f);
        }
    }
    return insets;
}

//
// naviBtn的点击区域过大导致用户手误，这里对点击区域做了限制
//
- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView: self];
    return CGRectContainsPoint(self.bounds, point);
}


- (void)setText:(NSString*)text onBackButton:(UIButton*)backButton leftCapWidth:(CGFloat) capWidth {
    
    CGSize textSize = [text sizeWithFont:backButton.titleLabel.font];
    
    
    UIEdgeInsets inset = backButton.titleEdgeInsets;
    CGFloat tmpWidth = textSize.width + MAX(0, inset.left) + MAX(0, inset.right);
    CGFloat width = MAX(MIN(tmpWidth, MAX_BACK_BUTTON_WIDTH), 40);
    
    // NSLog(@"BackButton Width: %.3f, Title: %@, TextSize: %.3f", width, text, textSize.width);
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        width += 10;
    }
    const CGRect rect = backButton.frame;
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    
    backButton.frame = CGRectMake(x, y, width, rect.size.height);
    [backButton setTitle:text forState:UIControlStateNormal];
}

@end



@implementation NaviView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (UIEdgeInsets)alignmentRectInsets {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    // 只处理iOs7.0
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (_isLeftButton) {
            insets = UIEdgeInsetsMake(0, 9.0f, 0, 0);
        }
        else { // IF_ITS_A_RIGHT_BUTTON
            insets = UIEdgeInsetsMake(0, 0, 0, 9.0f);
        }
    }
    return insets;
}


@end

