//
//  UIView+GestureBlock.h
//  测试Demo
//
//  Created by Shenjinghao on 2016/12/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JHGestureBlock)(UIGestureRecognizer *gesture);

@interface UIView (GestureBlock)

/**
 tap & selector

 @param target
 @param selector
 @return tap
 */
- (UITapGestureRecognizer *)jhAddTapGestureWithTarget:(id)target selector:(SEL)selector;

/**
 long & selector

 @param target
 @return long
 */
- (UILongPressGestureRecognizer *)jhAddLongGestureWithTarget:(id)target selector:(SEL)selector;

/**
 tap & block

 @param actionBlock
 @return tap
 */
- (UITapGestureRecognizer *)jhAddTapGestureWithActionBlock:(JHGestureBlock)actionBlock;

/**
 long & block

 @param actionBlock
 @return long
 */
- (UILongPressGestureRecognizer *)jhAddLongGestureWithActionBlock:(JHGestureBlock)actionBlock;

/**
 tap
 */
@property (nonatomic, copy) JHGestureBlock jhTapGestureBlock;

/**
 long
 */
@property (nonatomic, copy) JHGestureBlock jhLongGestureBlock;

/**
 set

 @param jhTapGestureBlock
 */
- (void)setJhTapGestureBlock:(JHGestureBlock)jhTapGestureBlock;

/**
 long

 @param jhLongGestureBlock
 */
- (void)setJhLongGestureBlock:(JHGestureBlock)jhLongGestureBlock;


@end
