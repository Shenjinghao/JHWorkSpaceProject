//
//  UIView+JHGesturesBlock.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/27.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//


#ifndef safe_block
#define safe_block(block, ...) block ? block(__VA_ARGS__) : nil

#endif

#import "UIView+JHGesturesBlock.h"

@implementation UIView (JHGesturesBlock)

- (void)setTapActionBlock:(JHGesturesActionBlock)tapActionBlock
{
    objc_setAssociatedObject(self, @selector(tapActionBlock), tapActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JHGesturesActionBlock)tapActionBlock
{
    return objc_getAssociatedObject(self, @selector(tapActionBlock));
}

- (void)setLongPressActionBlock:(JHGesturesActionBlock)longPressActionBlock
{
    objc_setAssociatedObject(self, @selector(longPressActionBlock), longPressActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JHGesturesActionBlock)longPressActionBlock
{
    return objc_getAssociatedObject(self, @selector(longPressActionBlock));
}

//tap block
- (UIGestureRecognizer *) jhAddTapGestureWithActionBlock:(JHGesturesActionBlock)actionBlock
{
    if (self.tapActionBlock) {
        return nil;
    }
    self.tapActionBlock = actionBlock;
    return [self jhAddTapGestureWithTarget:self selector:@selector(tapGestureSelector:)];
}

- (void)tapGestureSelector:(UIGestureRecognizer *)gesture
{
    safe_block(self.tapActionBlock, gesture);
}

// tap
- (UITapGestureRecognizer *)jhAddTapGestureWithTarget:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    return tap;
}


//long press
- (UILongPressGestureRecognizer *)jhAddLongPressGestureWithTarget:(id)target selector:(SEL)selector
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:longPress];
    return longPress;
}

- (UIGestureRecognizer *)jhAddLongPressGestureWithActionBlock:(JHGesturesActionBlock)actionBlock
{
    if (self.longPressActionBlock) {
        return nil;
    }
    self.longPressActionBlock = actionBlock;
    return [self jhAddLongPressGestureWithTarget:self selector:@selector(longPressGestureSelector:)];
}

- (void)longPressGestureSelector:(UIGestureRecognizer *)gesture
{
    safe_block(self.longPressActionBlock, gesture);
}

@end
