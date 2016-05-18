//
//  UIView+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/11.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIView+JHCategory.h"

@implementation UIView (JHCategory)

//object-c 为了让java的开发者习惯 使用.的操作，所以可以将接口类中的变量 使用@property来声明属性。但是在.h中声明的属性，必须在.m中使用@synthesize或者@dynamic来实现（传言，在最近出的ios6中这不已经省了），否则属性不可用。
//
//熟悉object－c语法的都知道@synthesize实际的意义就是 自动生成属性的setter和getter方法。
//
//@dynamic 就是要告诉编译器，代码中用@dynamic修饰的属性，其getter和setter方法会在程序运行的时候或者用其他方式动态绑定，以便让编译器通过编译。其主要的作用就是用在NSManagerObject对象的属性声明上，由于此类对象的属性一般是从Core Data的属性中生成的，core data 框架会在程序运行的时候为此类属性生成getter和setter方法。

@dynamic width;
@dynamic height;
@dynamic x;
@dynamic y;
@dynamic right;
@dynamic bottom;

#pragma mark 宽
- (void) setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

#pragma mark 高
- (void) setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (CGFloat) height
{
    return self.frame.size.height;
}

#pragma mark 顶
- (void) setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

#pragma mark 底
- (void) setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
#pragma mark 左边界
- (void) setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark 中心X
- (void) setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat) centerX
{
    return self.center.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark 中心Y
- (void) setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat) centerY
{
    return self.center.y;
}
#pragma mark X
- (void) setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat) x
{
    return self.frame.origin.x;
}
#pragma mark Y
- (void) setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat) y
{
    return self.frame.origin.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

#pragma mark 移除所有视图
- (void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView *childView = self.subviews.lastObject;
        [childView removeFromSuperview];
    }
}
#pragma mark 事件响应链
- (UIViewController *)viewController
{
    for (UIView *nextView = [self superview]; nextView; nextView = nextView.superview) {
        UIResponder *nextResponder = [nextView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
#pragma mark 创建一个指定大小，指定颜色的UIView
+ (UIView *) viewWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;
}


@end

// 屏幕的大小（相对于当前的Orientation)
CGRect JHScreenBounds()
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (UIInterfaceOrientationIsLandscape(NIInterfaceOrientation())) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}

CGFloat viewWidth()
{
    static CGFloat viewWidth = 0;
    if (viewWidth == 0) {
        viewWidth = JHScreenBounds().size.width;
    }
    return viewWidth;
}

CGFloat viewHeight()
{
    static CGFloat viewHeight = 0;
    if (viewHeight == 0) {
        viewHeight = JHScreenBounds().size.height;
    }
    return viewHeight;
}

CGFloat scaleWidthWith320(CGFloat width)
{
    return (width / 320) * viewWidth();
}

CGRect JHNavigationFrame()
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGFloat toolBarHeight = NIToolbarHeightForOrientation(NIInterfaceOrientation());
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height - toolBarHeight);
    return rect;
}

//const CGFloat ttkDefaultPortraitKeyboardHeight      = 216;
//const CGFloat ttkDefaultLandscapeKeyboardHeight     = 160;
//const CGFloat ttkDefaultPadPortraitKeyboardHeight   = 264;
//const CGFloat ttkDefaultPadLandscapeKeyboardHeight  = 352;
///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat JHKeyboardHeightForOrientation(UIInterfaceOrientation orientation) {
    return UIInterfaceOrientationIsPortrait(orientation) ? 216: 160;
}





