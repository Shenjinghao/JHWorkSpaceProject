//
//  JHFontManager.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/8.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const JHFontDidChangeNotification;
extern NSString *const JHFontSizeCategoryNewValueKey;
extern NSString *const JHDynamicFontUserDefaultKey;

@interface JHFontManager : NSObject

@property (nonatomic, copy, readonly) NSString* contentSizeStr;
@property (nonatomic) BOOL recieveSystemNotification;       //default is NO

+ (JHFontManager*)sharedInstance;
- (void)postFontNotificaiton:(NSString*)contentSizeStr;
- (void)saveDynamicFontSizeToUserDefault:(NSString*)dynamicFontSizeStr;
- (NSString*)getUserDefaultDynamicFontSizeStr;

@end
