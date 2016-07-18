//
//  UIView+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/11.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDeviceOrientation.h"

@interface UIView (JHCategory)

@property (nonatomic)CGFloat x;

@property (nonatomic)CGFloat y;

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;


@property (nonatomic) CGSize size;
/**
 * Return the x coordinate on the screen.
 */
//@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
//@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
//@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
//@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
//@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
//@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
//@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
//@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
//@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
//- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
//- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
//- (CGPoint)offsetFromView:(UIView*)otherView;
//

- (UIViewController*)viewController;

//- (UIView*)findFirstResponderBeneathView:(UIView*)view;

/**
 *  创建一个指定大小，指定颜色的UIView
 *
 *  @param frame           frame
 *  @param backgroundColor backgroundColor description
 *
 *  @return UIView
 */
+ (UIView *) viewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor;

//+ (UIImage *)getImageFromView:(UIView *)theView;

/**
 *  细线
 *
 *  @param frame <#frame description#>
 *  @param 除去导航栏 <#除去导航栏 description#>
 *
 *  @return <#return value description#>
 */
+ (UIView*) separateLineWithFrame:(CGRect) frame backGroundColor:(UIColor*)color;

@end
//
//  [UIScreen mainScreen].bounds                        屏幕的宽度(320 * 480， 或者320 * 568）
//  [UIScreen mainScreen].applicationFrame              除去20相似的Status Bar, 如果没有status bar呢???
//  JHNavigationFrame                                   ApplicationFrame中除去 NavigationBar的部分
//  JHToolbarNavigationFrame                            ApplicationFrame中除去上面NavigationBar, 和下面 toolbar之后的部分
//
//  JHUserVisibleViewHeight()                           除去导航栏，以及键盘之外的其他部分
/**
 *  屏幕适配
 *
 *  @return 尺寸
 */

/**
 *  屏幕的大小（相对于当前的Orientation)
 *
 *  @return
 */
CGRect JHScreenBounds();
/**
 *  相对宽度
 *
 *  @return <#return value description#>
 */
CGFloat viewWidth();
/**
 *  相对高度
 *
 *  @return <#return value description#>
 */
CGFloat viewHeight();
/**
 *  相对距离
 *
 *  @param width <#width description#>
 *
 *  @return <#return value description#>
 */
CGFloat scaleWidthWith320(CGFloat width);
/**
 *  去除NavigationBar的高度
 *
 *  @return
 */
CGRect JHNavigationFrame();

/**
 * ...
 */
CGFloat JHKeyboardHeightForOrientation(UIInterfaceOrientation orientation);


