//
//  JHNetWorkManager.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHNetWorkManager.h"
#import "JHBaseRequest.h"

@implementation JHNetWorkManager
{
    AFHTTPRequestOperationManager *_manager;
    /**
     *  队列哈希值
     */
    NSMutableDictionary *_requestsRecordDict;
}

/**
 *  单例网络请求
 *
 *  @return 单例
 */
+ (JHNetWorkManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static JHNetWorkManager *sharedInstance = nil;
    if (sharedInstance) {
        dispatch_once(&onceToken, ^{
            sharedInstance = [[JHNetWorkManager alloc] init];
        });
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/**
 *  网络请求
 *
 *  @param request 将请求放入队列
 */
- (void)addRequest:(JHBaseRequest *)request
{
    if (request.requestSerializerType == JHRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == JHRequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if (request.requestSerializerType == JHRequestSerializerTypePLIST){
        _manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    
    JHRequestMethod method = request.requestMethod;
    /**
     *  将请求的url进行拼接
     */
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",request.baseUrl,request.requestUrl];
    /**
     *  需要上传的参数
     */
    NSDictionary *params = request.requestParam;
    
    if (method == JHRequestMethodGet){
        
        request.requestOperation = [_manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation withError:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation withError:error];
        }];
    }else if (method == JHRequestMethodPost){
        
        request.requestOperation = [_manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation withError:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation withError:error];
        }];
    }else if (method == JHRequestMethodDelete){
        
        request.requestOperation = [_manager DELETE:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation withError:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation withError:error];
        }];
    }
    
    [self addOperation:request];
    
}

/*!
 解析结果
 */
- (void)handleRequestResult:(AFHTTPRequestOperation *)operation withError:(NSError *)error
{
    NSString *key = [self requestHashKey:operation];
    JHBaseRequest *request = _requestsRecordDict[key];
    if (request) {
        /**
         *  此处需要判断success，此方法不应该返回BOOL，应该返回状态码，这样可以判断是否，如：302需要重新自动登录
         */
        NSInteger statusCode = [request statusCodeValidator];
        if (statusCode >= 200 && statusCode <= 300) {
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
        }else if (statusCode == 302){

            //此处进行登录操作
        }else{
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request,error);
            }
        }
    }
    [self removeOperation:operation];
    [request clearCompletionBlock];
}

/*!
 将请求队列放dictonary中，key为request的hash值，保证唯一
 */
- (void)addOperation:(JHBaseRequest *)request
{
    if (request.requestOperation != nil) {
        NSString *key = [self requestHashKey:request.requestOperation];
        _requestsRecordDict[key] = request;
    }
}
/*!
 通过队列hash获取唯一key
 */
- (NSString *)requestHashKey:(AFHTTPRequestOperation *)operation
{
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}

/*!
 移除队列key
 */
- (void)removeOperation:(AFHTTPRequestOperation *)operation {
    NSString * key = [self requestHashKey:operation];
    [_requestsRecordDict removeObjectForKey:key];
}
/**
 *  根据tag取消请求队列
 *
 *  @param tag tag
 */
- (void)cancelRequest:(NSInteger)tag
{
    NSDictionary *copyRecord = [_requestsRecordDict copy];
    for (NSString *key in copyRecord) {
        JHBaseRequest *request = copyRecord[key];
        if (request.tag == tag) {
            [request.requestOperation cancel];
            [self removeOperation:request.requestOperation];
            [request clearCompletionBlock];
        }
    }
}

- (void)cancelAllRequests {
    NSDictionary *copyRecord = [_requestsRecordDict copy];
    for (NSString *key in copyRecord) {
        JHBaseRequest *request = copyRecord[key];
        [request stop];
    }
}

- (void)getUrl:(NSString *)url withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure
{
    [self getUrl:url withBaseUrl:[JHAPIHost sharedInstance].apiHost withParam:param withCompletionBlockWithSuccess:success withFailure:failure withTag:0];
}

- (void)getUrl:(NSString *)url withBaseUrl:(NSString *)baseUrl withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure withTag:(NSInteger)tag
{
    JHBaseRequest *requset = [[JHBaseRequest alloc] init];
    requset.requestUrl = url;
    requset.baseUrl = baseUrl;
    requset.requestParam = param;
    requset.requestMethod = JHRequestMethodGet;
    requset.requestSerializerType = JHRequestSerializerTypeHTTP;
    requset.successCompletionBlock = success;
    requset.failureCompletionBlock = failure;
    requset.tag = tag;
    [self addOperation:requset];
}

- (void)getUrl:(NSString *)url withBaseUrl:(NSString *)baseUrl withParam:(NSDictionary *)param withRequestSerializerType:(JHRequestSerializerType)requestSerializerType withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure withTag:(NSInteger)tag
{
    JHBaseRequest *requset = [[JHBaseRequest alloc] init];
    requset.requestUrl = url;
    requset.baseUrl = baseUrl;
    requset.requestParam = param;
    requset.requestMethod = JHRequestMethodGet;
    requset.requestSerializerType = requestSerializerType;
    requset.successCompletionBlock = success;
    requset.failureCompletionBlock = failure;
    requset.tag = tag;
    [self addOperation:requset];
}

- (void)postUrl:(NSString *)url withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure
{
    [self postUrl:url withBaseUrl:[JHAPIHost sharedInstance].apiHost withParam:param withCompletionBlockWithSuccess:success withFailure:failure withTag:0];
}

- (void)postUrl:(NSString *)url withBaseUrl:(NSString *)baseUrl withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure withTag:(NSInteger)tag
{
    JHBaseRequest *requset = [[JHBaseRequest alloc] init];
    requset.requestUrl = url;
    requset.baseUrl = baseUrl;
    requset.requestParam = param;
    requset.requestMethod = JHRequestMethodPost;
    requset.requestSerializerType = JHRequestSerializerTypeHTTP;
    requset.successCompletionBlock = success;
    requset.failureCompletionBlock = failure;
    requset.tag = tag;
    [self addOperation:requset];
}

- (void)postUrl:(NSString *)url withBaseUrl:(NSString *)baseUrl withParam:(NSDictionary *)param withRequestSerializerType:(JHRequestSerializerType)requestSerializerType withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure withTag:(NSInteger)tag
{
    JHBaseRequest *requset = [[JHBaseRequest alloc] init];
    requset.requestUrl = url;
    requset.baseUrl = baseUrl;
    requset.requestParam = param;
    requset.requestMethod = JHRequestMethodPost;
    requset.requestSerializerType = requestSerializerType;
    requset.successCompletionBlock = success;
    requset.failureCompletionBlock = failure;
    requset.tag = tag;
    [self addOperation:requset];
}

- (void)deleteUrl:(NSString *)url withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure
{
    [self deleteUrl:url withBaseUrl:[JHAPIHost sharedInstance].apiHost withParam:param withCompletionBlockWithSuccess:success withFailure:failure withTag:0];
}

- (void)deleteUrl:(NSString *)url withBaseUrl:(NSString *)baseUrl withParam:(NSDictionary *)param withCompletionBlockWithSuccess:(void (^)(JHBaseRequest *))success withFailure:(void (^)(JHBaseRequest *, NSError *))failure withTag:(NSInteger)tag
{
    JHBaseRequest *requset = [[JHBaseRequest alloc] init];
    requset.requestUrl = url;
    requset.baseUrl = baseUrl;
    requset.requestParam = param;
    requset.requestMethod = JHRequestMethodDelete;
    requset.successCompletionBlock = success;
    requset.failureCompletionBlock = failure;
    requset.requestSerializerType = JHRequestSerializerTypeHTTP;
    requset.tag = tag;
    [self addOperation:requset];
}



@end
