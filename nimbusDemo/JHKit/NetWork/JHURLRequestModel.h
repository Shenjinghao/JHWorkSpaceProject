//
//  JHURLRequestModel.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHModel.h"
#import "JHTableItem.h"

@class JHURLRequestModel;
@class NITableViewModelSection;

/**
 *
 1. 需要了解什么是 block?
 2. 如何创建block?
 ^void(AFHTTPRequestOperation *operation, id httpObject, JHURLRequestModel* model) {
 // Print your code here
 }
 如果被解析的数据不是简单的列表，则可以实现自己的解析模块
 数据解析完毕之后，需要设置model中的数据，hasMore等数据
 */

typedef void (^JH_HTTP_PARSE_BLOCK)(AFHTTPRequestOperation *operation, id httpObject, JHURLRequestModel *model);
/**
 *
 Item Facotry: 可以指定JHTableItem派生类的构造函数
 常见格式如下:
 ^JHTableItem*(NSDictionary* json) {
 return [[MediaNewsItem alloc] initWithAttributes: json];
 }

 */
typedef JHTableItem* (^JH_TABLE_ITEM_FACTORY)(NSDictionary* json);

// 定义一个和给定v 类型相同的Weak Ref.变量
#define JH_DEFINE_SELF_BAR(v)      \
    __weak typeof(v) _self = v

// 定义一个和给定v类型相同的arc weak变量，防止在self.block使用全局变量
#define JH_DEFINE_VARIABLE(v)   \
    __weak typeof(v) _##v = v

// 将 JH_HTTP_PARSE_BLOCK 的实现转移到 _self的selector的实现，避免block引用过多的成员变量
#define JH_HTTP_PARSER_WITH_SELF_BAR()                                          \
    ^(AFHTTPRequestOperation *operation, id JSON, JHURLRequestModel *model) {   \
    [_self parseHttpResponse: JSON withModel: model];                           \
}

//
// 封装网络请求， 对上透明
// 调用模式:
//    self.httpRequestOperation = xxxx;
//    然后网络请求就开始了吗?
//

//
// 使用场景:
// 1. 获取一般的Http请求, 和TableViewModel没有关系
//    isPaged: NO, itemFactory为NO, 直接在httpParser中处理数据，或者在modelDidLoad:withObject中解析
//
// 2. 和TableViewModel绑定在一起，将数据自动解析到sections(两者的sections兼容)
//    如果table items为单一的数据结构，则直接传递 itemFactory, 给定一个NSDictionary, 返回一个对象
//    建议默认的初始化函数为: initWithAttributes, 但是也可以定义多个不同的版本，杂不同的场合使用不同的版本呢
//
// 3. 和TableViewModel绑定在一起，将数据解析到sections(两者的sections兼容), 运行增加个性化的信息
//    通用的信息被保存在sections中，个性化的信息被保存在ViewControllers等地方
//    如果包含不同的Cell, 则xxxxx
//

// 如何使用JHURLRequestModel呢?
// JHURLRequestModel* tableViewModel = [[JHURLRequestModel alloc] initWithBaseURL: @"/api/news?type=HYH"
//                                                                  andHttpRequest: (JHNetWorkManager *) request
//                                                                        isPaged: YES   // 是否需要分页
//                                                                   andHttpParse: nil
//                                                                    itemFactory: ^JHTableItem(NSDictionary* json) {
//                                                                          return [[MediaNewsItem alloc] initWithAttributes: json];
//                                                                    }
//

@interface JHURLRequestModel : JHModel

{
@protected
    BOOL _isLoadingMore;
    AFHTTPRequestOperation* _httpRequestOperation;
    __weak JHNetWorkManager* _httpRequest;
    
    BOOL _isPaged;
    
    NSInteger _timestamp;
    NSInteger _requestCount;      // 增量跟新时候request失败则最多请求三次
    
    NSMutableSet* _filterSet;
}


@property (nonatomic, copy) JH_HTTP_PARSE_BLOCK customHttpObjectParser;
@property (nonatomic, copy) JH_TABLE_ITEM_FACTORY tableItemFactory;

- (id) initWithBaseURL: (NSString*) path
         andHttpRequest: (JHNetWorkManager *) request
               isPaged: (BOOL) isPaged
          andHttpParse: (JH_HTTP_PARSE_BLOCK) parseBlock
           itemFactory: (JH_TABLE_ITEM_FACTORY) itemFactory;

// modelChanged 默认为 NO, 如果为 YES, 在下一次加载时，无论是Load More, 还是Refresh都是从第一页加载起
@property (nonatomic) BOOL modelChanged;

@property (nonatomic, strong) NITableViewModelSection* section;
@property (nonatomic, readonly, strong) NSMutableArray* multilineSections;

@property (nonatomic, strong) NSDate* loadedTime;

@property (nonatomic, strong) NSString* path;

//
// 是否对时间敏感，例如: 新闻等页面，刷新时需要考虑时效性; 默认为NO
//
@property (nonatomic) BOOL isTimeSensitive;

@property (nonatomic) BOOL isLoading;
// 是否有更多的计算方法
@property (nonatomic) BOOL hasMore;

// 是否需要从文件加载预保存的内容
@property (nonatomic) BOOL loadFromFile;
@property (nonatomic) int retryCountOnFail;
@property (nonatomic) BOOL loadFromFileOnly;


@property (nonatomic, strong) id userInfo;
//
// Http请求所采用的Method, 默认为 GET, 也可以采用 POST, DELETE, HEAD等
// 当为 POST时需要注意:
// 1. 需要通过POST方式传输的数据，可以通过参数 parameters 来传递
// 2. 放在URL中的参数，在传输过程中依然在URL中，而不是POST的body中
//
@property (nonatomic, strong) NSString* httpMethod;

//
// 需要加载的post参数
//
@property (nonatomic, strong) NSDictionary* parameters;


// 通过返回结果数是否为0，来判断是否有更多
//
@property (nonatomic) BOOL hasMoreByNonZero;

//
// 虑重所需要的key
//
@property (nonatomic, strong) NSString* filterKey;

@property (nonatomic) NSInteger startNum;
@property (nonatomic) NSInteger stepCount;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger startPage;

@property (nonatomic, strong) NSString* paramNameStartNum;
@property (nonatomic, strong) NSString* paramNameStepCount;
@property (nonatomic, strong) NSString* paramNamePage;

// 设置Request的状态
- (void)reset;

//
// 设置多section的数据
//
- (void) setMultilineSections: (NSArray*)multilineSections titleList:(NSArray*) titlesList;


@end
