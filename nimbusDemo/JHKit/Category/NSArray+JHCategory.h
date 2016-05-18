//
//  NSArray+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JHCategory)

/**
 *  根据AppleObjective-C Runtime Reference官方文档这个传递消息的函数就是 id objc_msgSend(id theReceiver, SEL theSelector, …)
 
 theReceiver是接受消息的对象类型是id，theSelector是消息名称类型是SEL。下边代码我们来看看如何来生成一个SEL，如果传递消息。
 *  如果使用了ARC会产生“performSelector may cause a leak because its selector is unknown”警告
 *  @param selector selector description
 */

- (void)perform:(SEL)selector;
- (void)perform:(SEL)selector withObject:(id)obj1;
- (void)perform:(SEL)selector withObject:(id)obj1 withObject:(id)obj2;
- (void)perform:(SEL)selector withObject:(id)obj1 withObject:(id)obj2 withObject:(id)obj3;


@end
