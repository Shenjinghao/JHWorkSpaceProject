//
//  JHUtility.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHUtility : NSObject

+ (id) userDefaultObjectForKey:(NSString *)key;

+ (void) setUserDefaultObjects:(NSDictionary *)dict;

+ (void) removeObject:(NSString *)key;


+ (BOOL) JHIsKeyboardVisible;
/**
 *  判断系统版本
 *
 *  @param version 版本号
 *
 *  @return
 */
+ (BOOL) JHOveriOS:(CGFloat)version;

@end


