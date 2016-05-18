//
//  JHUtility.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHUtility.h"

@implementation JHUtility

/**
 *  缓存
 *
 *  @param key key
 *
 *  @return id
 */
+ (id) userDefaultObjectForKey:(NSString *)key
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    return [info objectForKey:key];
}
/**
 *  缓存
 *
 *  @param dict dictionary
 */
+ (void) setUserDefaultObjects:(NSDictionary *)dict
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    /**
     *  kvc集合运算符
     *
     *  @param key  <#key description#>
     *  @param obj  <#obj description#>
     *  @param stop <#stop description#>
     *
     *  @return <#return value description#>
     */
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [info setObject:obj forKey:key];
    }];
    [info synchronize];
}
/**
 *  移除缓存
 *
 *  @param key key
 */
+ (void)removeObject:(NSString *)key
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    [info removeObjectForKey:key];
    [info synchronize];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL) JHIsKeyboardVisible {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    UIView* firstResponder = [window findFirstResponder];
    
    if (![firstResponder isKindOfClass: NSClassFromString(@"UIWebBrowserView")]) {
        return !!firstResponder;
    } else {
        return NO;
    }
}

+ (BOOL) JHOveriOS:(CGFloat)version
{
    return [[UIDevice currentDevice].systemVersion floatValue] >= version;
}

@end









