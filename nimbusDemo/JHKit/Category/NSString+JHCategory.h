//
//  NSString+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/15.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JHCategory)

- (BOOL) isNotEmpty;

- (NSString*)URLDecodedString;

/**
 *  md5加密
 *
 *  @param password 密码
 *
 *  @return
 */
+ (NSString *)md5:(NSString *)password;

/**
 *  JSON形式的字符串
 *
 *  @return string
 */
//- (NSString *)JSONRepresentation;
/**
 *  获取路径并写入沙盒
 *
 *  @return
 */
+ (NSString *)getDocumentPath;
+ (NSString *)getFilePath:(NSString *)fileName;

@end

/**
 * @return A localized description for NSURLErrorDomain errors.
 *
 * Error codes handled:
 * - NSURLErrorTimedOut
 * - NSURLErrorNotConnectedToInternet
 * - All other NSURLErrorDomain errors fall through to "Connection Error".
 */
NSString* JHDescriptionForError(NSError* error);


/**
 * @return A localized string from the Three20 bundle.
 */
NSString* JHLocalizedString(NSString* key, NSString* comment);

/**
 *  确保str非空； 如果为空，则返回@""
 *
 *  @param str str description
 *
 *  @return return value description
 */
static inline NSString *ENSURE_NOT_NULL(id str)
{
    if (str == nil || [str isEqual:[NSNull null]]) {
        return @"";
    }else{
        return str;
    }
}
/**
 *  确保返回的是字符串
 *
 *  @param obj obj description
 *
 *  @return return value description
 */
static inline NSString *EnsureStr(id obj) {
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else {
        return @"";
    }
}












