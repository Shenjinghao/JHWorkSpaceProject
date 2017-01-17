//
//  UIView+GestureBlock.m
//  测试Demo
//
//  Created by Shenjinghao on 2016/12/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "UIView+GestureBlock.h"

@implementation UIView (GestureBlock)

- (UITapGestureRecognizer *)jhAddTapGestureWithTarget:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    return tap;
}

- (UILongPressGestureRecognizer *)jhAddLongGestureWithTarget:(id)target selector:(SEL)selector
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:longPress];
    return longPress;
}

- (UITapGestureRecognizer *)jhAddTapGestureWithActionBlock:(JHGestureBlock)actionBlock
{
    NSAssert(self.jhTapGestureBlock == nil, @"已经添加手势");
    if (self.jhTapGestureBlock != nil) {
        //已经加过tap gesture，不再添加
        return nil;
    }
    return [self jhAddTapGestureWithTarget:self selector:@selector(jhTapGestureSelector:)];
}

- (UILongPressGestureRecognizer *)jhAddLongGestureWithActionBlock:(JHGestureBlock)actionBlock
{
    NSAssert(self.jhLongGestureBlock == nil, @"已经添加手势");
    if (self.jhLongGestureBlock != nil) {
        //已经加过long gesture，不再添加
        return nil;
    }
    return [self jhAddLongGestureWithTarget:self selector:@selector(jhLongGestureSelector:)];
}

- (void)setJhTapGestureBlock:(JHGestureBlock)jhTapGestureBlock
{
    objc_setAssociatedObject(self, @selector(jhTapGestureBlock), jhTapGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JHGestureBlock) jhTapGestureBlock
{
    return objc_getAssociatedObject(self, @selector(jhTapGestureSelector:));
}

- (void)setJhLongGestureBlock:(JHGestureBlock)jhLongGestureBlock
{
    objc_setAssociatedObject(self, @selector(jhLongGestureBlock), jhLongGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JHGestureBlock)jhLongGestureBlock
{
    return objc_getAssociatedObject(self, @selector(jhLongGestureSelector:));
}

- (void)jhTapGestureSelector:(UIGestureRecognizer *)gesture
{
    safe_block(self.jhTapGestureBlock,gesture);
}

- (void)jhLongGestureSelector:(UIGestureRecognizer *)gesture
{
    safe_block(self.jhLongGestureBlock,gesture);
}


@end
