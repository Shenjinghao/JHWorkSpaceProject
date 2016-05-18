//
//  NSArray+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "NSArray+JHCategory.h"

@implementation NSArray (JHCategory)

- (void)perform:(SEL)selector
{
    /**
     遍历数组每个索引处的对象，你可以编写一个0到[array count]的循环，而NSEnumerator用来描述这种集合迭代运算的方式。
     通过objectEnumerator向数组请求枚举器，如果想从后向前浏览集合，可使用reverseObjectEnumerator方法。在获得枚举器后，可以开始一个while循环，每次循环都向这个枚举器请求它的下一个对象:nextObject。nextObject返回XX值时，循环结束。
     */
    NSArray *copyArray = [[NSArray alloc] initWithArray:self];
    NSEnumerator *enumrator = [copyArray objectEnumerator];
    for (id delegate; delegate = [enumrator nextObject]; ) {
        if ([delegate respondsToSelector:selector]) {
            /**
             *  防止出现“performSelector may cause a leak because its selector is unknown”警告
             */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector];
#pragma clang diagnostic pop
        }
    }
}

- (void) perform:(SEL)selector withObject:(id)obj1
{
    NSArray *copyArray = [[NSArray alloc] initWithArray:self];
    NSEnumerator *enumrator = [copyArray objectEnumerator];
    for (id delegate; delegate = [enumrator nextObject]; ) {
        if ([delegate respondsToSelector:selector]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:obj1];
#pragma clang diagnostic pop
        }
    }
}

- (void) perform:(SEL)selector withObject:(id)obj1 withObject:(id)obj2
{
    NSArray *copyArray = [[NSArray alloc] initWithArray:self];
    NSEnumerator *enumrator = [copyArray objectEnumerator];
    for (id delegate; delegate = [enumrator nextObject]; ) {
        if ([delegate respondsToSelector:selector]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:obj1 withObject:obj2];
#pragma clang diagnostic pop
        }
    }
}

- (void) perform:(SEL)selector withObject:(id)obj1 withObject:(id)obj2 withObject:(id)obj3
{
    NSArray *copyArray = [[NSArray alloc] initWithArray:self];
    NSEnumerator *enumrator = [copyArray objectEnumerator];
    for (id delegate; delegate = [enumrator nextObject]; ) {
        if ([delegate respondsToSelector:selector]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:selector withObject:obj2 withObject:obj2 withObject:obj3];
#pragma clang diagnostic pop
        }
    }
}



@end
