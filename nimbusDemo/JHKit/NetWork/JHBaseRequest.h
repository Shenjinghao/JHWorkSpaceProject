//
//  JHBaseRequest.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HTTP请求的方法...目前仅支持Get，Post, delete
 */
typedef NS_ENUM(NSInteger, JHRequestMethod) {
    /**
     *  get
     */
    JHRequestMethodGet = 0,
    /**
     *  post
     */
    JHRequestMethodPost,
    /**
     *  delete
     */
    JHRequestMethodDelete
};
/**
 *  请求的数据类型
 */
typedef NS_ENUM(NSInteger, JHRequestSerializerType) {
    /**
     *  http
     */
    JHRequestSerializerTypeHTTP = 0,
    /**
     *  json
     */
    JHRequestSerializerTypeJSON,
    /**
     *  list
     */
    JHRequestSerializerTypePLIST
};



/**
 *  网络请求基础类
 */

@interface JHBaseRequest : NSObject


//普通请求
@property (nonatomic, strong) AFHTTPRequestOperation    *requestOperation;

//HTTP请求的方法...目前仅支持Get，Post, delete
@property (nonatomic, assign) JHRequestMethod           requestMethod;

//请求的参数
@property (nonatomic, strong) NSDictionary              *requestParam;

//请求参数，图片数组
@property (nonatomic, strong) NSArray                   *imageArray;

@property (nonatomic, strong) NSArray                   *audioArray;

//返回的数据json格式
@property (nonatomic, strong) id                        responseObject;

//返回的数据字符串格式
@property (nonatomic, strong) NSString                  *responseString;

//服务器地址BASEURL
@property (nonatomic, strong) NSString                  *baseUrl;

//请求URL
@property (nonatomic, strong) NSString                  *requestUrl;

//请求的数据类型
@property (nonatomic, assign) JHRequestSerializerType   requestSerializerType;

//失败的回调
@property (nonatomic, copy) void (^failureCompletionBlock)(JHBaseRequest * request ,NSError *error);

//成功的回调
@property (nonatomic, copy) void (^successCompletionBlock)(JHBaseRequest *);


@property (nonatomic) NSInteger tag;
//状态码校验
- (NSInteger)statusCodeValidator;

//把block置nil来打破循环引用
- (void)clearCompletionBlock;

- (void)stop;



@end
