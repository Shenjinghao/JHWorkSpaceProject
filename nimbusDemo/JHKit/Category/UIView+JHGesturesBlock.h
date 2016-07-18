//
//  UIView+JHGesturesBlock.h
//  测试Demo
//
//  Created by Shenjinghao on 16/5/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JHGesturesActionBlock)(UIGestureRecognizer *gesture);

@interface UIView (JHGesturesBlock)

@property (nonatomic, copy) JHGesturesActionBlock tapActionBlock;

@property (nonatomic, copy) JHGesturesActionBlock longPressActionBlock;

//tap block
- (UIGestureRecognizer *) jhAddTapGestureWithActionBlock:(JHGesturesActionBlock)actionBlock;

// tap & selector
- (UITapGestureRecognizer *)jhAddTapGestureWithTarget:(id)target selector:(SEL)selector;

// long press & selector
- (UILongPressGestureRecognizer *)jhAddLongPressGestureWithTarget:(id)target selector:(SEL)selector;

//long press block
- (UIGestureRecognizer *) jhAddLongPressGestureWithActionBlock:(JHGesturesActionBlock)actionBlock;

@end
