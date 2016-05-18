//
//  JHNetWorkManager.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "JHBaseRequest.h"

@interface JHNetWorkManager : AFHTTPRequestOperationManager


/*!
 单例网络请求
 */
+ (JHNetWorkManager *) sharedInstance;
/**
 *  网络请求
 *
 *  @param request 请求队列
 */
- (void)addRequest:(JHBaseRequest *)request;

/*!
 post请求，默认的使用json格式请求
 @param url请求相对URL
 @param param请求参数
 @param success成功回调块
 @param failure失败回调块
 */
- (void)postUrl          :(NSString *)url
                withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
              withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure;

/*!
 post请求，默认的使用json格式请求
 @param url请求相对URL
 @param baseUrl 即apiHost
 @param param请求参数
 @param success成功回调块
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */
- (void)postUrl          :(NSString *)url
              withBaseUrl:(NSString *)baseUrl
                withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
              withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
                  withTag:(NSInteger)tag;

/*!
 get请求，默认的使用json格式请求
 @param url请求相对URL
 @param param请求参数
 @param success成功回调块
 @param failure失败回调块
 */
- (void)getUrl:(NSString *)url
     withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
   withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure;

/*!
 get请求，默认的使用json格式请求
 @param url请求相对URL
 @param baseUrl 即：apiHost
 @param param请求参数
 @param success成功回调块
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */
- (void)getUrl           :(NSString *)url
              withBaseUrl:(NSString *)baseUrl
                withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
              withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
                  withTag:(NSInteger)tag;

/*!
 post请求，可指定requestSerializer格式
 @param url请求相对URL
 @param url请求相对URL
 @param param请求参数
 @param requestSerializerType   可以为：http,json,plist三种
 @param success成功回调块
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */

- (void)postUrl          :(NSString *)url
              withBaseUrl:(NSString *)baseUrl
                withParam:(NSDictionary *)param
withRequestSerializerType:(JHRequestSerializerType)requestSerializerType
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
              withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
                  withTag:(NSInteger)tag;

/*!
 get请求，默认的使用http格式请求
 @param url请求相对URL
 @param url请求相对URL
 @param param请求参数
 @param success成功回调块
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */
- (void)getUrl           :(NSString *)url
              withBaseUrl:(NSString *)baseUrl
                withParam:(NSDictionary *)param
withRequestSerializerType:(JHRequestSerializerType)requestSerializerType
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
              withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
                  withTag:(NSInteger)tag;


/*!
 post请求,上传图片
 @param url请求相对URL
 @param param请求参数
 @param imageArray图片数组(里面存放UIImage)
 @param failure失败回调块
 */
//- (void)postMultipartFile       : (NSString *)url
//                       withParam:(NSDictionary *)param
//                  withImageArray:(NSArray *)imageArray
//  withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
//                     withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure;


/*!
 post请求,上传图片
 @param url请求相对URL
 @param baseUrl请求基本URL
 @param param请求参数
 @param imageArray图片数组(里面存放UIImage)
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */
//- (void)postMultipartFile       : (NSString *)url
//                     withBaseUrl:(NSString *)baseUrl
//                       withParam:(NSDictionary *)param
//                  withImageArray:(NSArray *)imageArray
//  withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
//                     withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
//                         withTag:(NSInteger)tag;
//
//
//- (void)postMultipartFile       : (NSString *)url
//                       withParam:(NSDictionary *)param
//                       withArray:(NSArray *)array
//  withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))requestSuccess
//                     withFailure:(void (^)(JHBaseRequest * failure, NSError *error))requestFailure
//                            type:(NSString*)type;

/*!
 delete请求
 @param url请求相对URL
 @param baseUrl请求基本URL
 @param param请求参数
 @param failure失败回调块
 @param tag requet的标志位，使用该tag可以取消响应的请求
 */
- (void)deleteUrl          :(NSString *)url
                  withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
                withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure;


- (void)deleteUrl         :(NSString *)url
               withBaseUrl:(NSString *)baseUrl
                 withParam:(NSDictionary *)param
withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
               withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
                   withTag:(NSInteger)tag;


/*!
 下载图片
 @param url 图片对应的url
 @param baseUrl 请求基本URL
 @param success 成功回调
 @param failure 失败回调
 @param tag  requet的标志位，使用该tag可以取消响应的请求
 */
//- (void)downloadFile            :(NSString *)url
//                     withBaseUrl:(NSString *)baseUrl
//  withCompletionBlockWithSuccess:(void (^)(JHBaseRequest * success))success
//                     withFailure:(void (^)(JHBaseRequest * failure, NSError *error))failure
//                         withTag:(NSInteger)tag;

/*!
 根据tag取消请求队列
 */
- (void)cancelRequest:(NSInteger)tag;

/*!
 取消所有队列请求
 */
- (void)cancelAllRequests;


@end
