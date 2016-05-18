//
//  NSString+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/15.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "NSString+JHCategory.h"
#import "CommonCrypto/CommonDigest.h"


@implementation NSString (JHCategory)



static NSMutableCharacterSet *emptyStringSet = nil;

- (BOOL) isNotEmpty
{
    if (emptyStringSet == nil) {
        emptyStringSet = [[NSMutableCharacterSet alloc] init];
        [emptyStringSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [emptyStringSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    }
    if (self.length == 0) {
        return NO;
    }
    /**
     *  去掉首尾的空格。
     */
    NSString *str = [self stringByTrimmingCharactersInSet:emptyStringSet];
    return [str length] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)URLDecodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)md5:(NSString *)password {
    const char *cStr = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1],
             result[2], result[3],
             result[4], result[5],
             result[6], result[7],
             result[8], result[9],
             result[10], result[11],
             result[12 ], result[13],
             result[14 ], result[15]] lowercaseString];
}

/**
 *  返回jsonstr
 *
 *  @return <#return value description#>
 */
- (NSString *)JSONRepresentation
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
#pragma mark 获取路径并写入沙盒
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)getDocumentPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)getFilePath:(NSString *)fileName {
    NSString * documentPath = [self getDocumentPath];
    return [documentPath stringByAppendingPathComponent:fileName];
}


@end

//
// 参考: AFHTTPRequestIOperation.m
//
NSString* JHDescriptionForError(NSError* error) {
    NIDINFO(@"ERROR %@", error);
    // TODO: 优化错误的处理方式:
    // 1. 服务器错误
    // 2. 网络错误
    
    // 如果服务器返回了错误，那么就直接显示服务器返回的错误，如果服务器没有返回错误，就使用之前默认的错误文案
    if ([error.userInfo[@"error_msg"] isNotEmpty]) {
        return error.userInfo[@"error_msg"];
    }
    
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        // Note: If new error codes are added here, be sure to document them in the header.
        if (error.code == NSURLErrorTimedOut) {
            return @"服务器连接超时";
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            return @"无法连线上网";
            
        } else {
            return @"连线错误";
        }
    }/* else if ([error.domain isEqualToString: AFNetworkingErrorDomain]) {
      if (error.code == NSURLErrorBadURL) {
      return @"URL格式错误";
      } else if (error.code == NSURLErrorBadServerResponse) {
      int statusCode = [error.userInfo[@"status_code"] intValue];
      NIDPRINT(@"服务器错误，错误代码: %d", statusCode);
      return DefStr(@"服务器错误，错误代码: %d", statusCode);
      
      } else if (error.code == NSURLErrorCannotDecodeContentData) {
      return @"服务器返回数据格式错误";
      }
      }*/
    
    return @"网络请求失败";
}

NSString* JHLocalizedString(NSString* key, NSString* comment) {
    static NSBundle* bundle = nil;
    if (nil == bundle) {
        NSString* path = [[[NSBundle mainBundle] resourcePath]
                          stringByAppendingPathComponent:@"chunyu.bundle"];
        bundle = [NSBundle bundleWithPath:path];
    }
    
    return [bundle localizedStringForKey:key value:key table:nil];
}


