//
//  JHBaseRequest.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHBaseRequest.h"
#import "JHNetWorkManager.h"
@implementation JHBaseRequest

/**
 *  状态码
 *
 *  @return
 */
- (NSInteger)statusCodeValidator
{
    NSInteger statusCode = [self responseStatusCode];
    return statusCode;
}


/**
 *  根据此code可以来判断302错误
 *
 *  @return statusCode
 */
- (NSInteger) responseStatusCode
{
    return self.requestOperation.response.statusCode;
}
/**
 *  responseString
 *
 *  @return
 */
- (NSString *) responseString
{
    return self.requestOperation.responseString;
}
/**
 *  <#Description#>
 *
 *  @return 如果json有嵌套，即value里有array、object，如果再使用objectFromJSONString，程序可能会报错（测试结果表明：使用由网络或得到的php/json_encode生成的json时会报错，但使用NSString定义的json字符串时，解析成功），最好使用objectFromJSONStringWithParseOptions：
 */
- (NSDictionary *) responseObject
{
    self.requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    return self.requestOperation.responseObject ? self.requestOperation.responseObject : [self.requestOperation.responseObject objectFromJSONString];
}

- (void)clearCompletionBlock
{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)stop
{
    [[JHNetWorkManager sharedInstance] cancelRequest:self.tag];
}



@end
