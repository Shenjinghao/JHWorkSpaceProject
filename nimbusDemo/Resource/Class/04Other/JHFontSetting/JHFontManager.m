//
//  JHFontManager.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/8.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHFontManager.h"


@implementation JHFontManager

NSString *const JHFontDidChangeNotification = @"JHFontDidChangeNotification";
NSString *const JHFontSizeCategoryNewValueKey = @"JHFontSizeCategoryNewValueKey";
NSString *const JHDynamicFontUserDefaultKey = @"JHDynamicFontUserDefaultKey";

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance registerFontNotification];
    });
    return instance;
}

- (void)registerFontNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferrChangeFontSize:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferrChangeFontSize:(NSNotification*)note
{
    if (_recieveSystemNotification) {
        NSDictionary* dict = note.userInfo;
        [self postFontNotificaiton:dict[UIContentSizeCategoryNewValueKey]];
    }
}

- (void)postFontNotificaiton:(NSString*)contentSizeStr
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JHFontDidChangeNotification object:nil userInfo:@{JHFontSizeCategoryNewValueKey:contentSizeStr}];
}

#pragma mark 存储字体设置
- (void)saveDynamicFontSizeToUserDefault:(NSString*)dynamicFontSizeStr
{
    if (![dynamicFontSizeStr isKindOfClass:[NSString class]] || dynamicFontSizeStr == nil) {
        
        return;
    }
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    [info setObject:dynamicFontSizeStr forKey:JHDynamicFontUserDefaultKey];
    [info synchronize];
}

- (NSString*)getUserDefaultDynamicFontSizeStr
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    return [info objectForKey:JHDynamicFontUserDefaultKey];
}

@end
