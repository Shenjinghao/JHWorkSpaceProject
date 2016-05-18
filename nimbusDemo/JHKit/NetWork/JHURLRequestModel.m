//
//  JHURLRequestModel.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//





#import "JHURLRequestModel.h"
#import "NITableViewModel+Private.h"
//
// JHURLRequestModel
//     isPaged: 如果为YES, 则采用分页算法
//              分页的参数默认为: start_num, count, 默认的start_num为0, count为10,
//     heepMethod:请求model的方式,可以有POST和GET等
//
//     如果实际参数定义有差别，请在创建model（并且在请求发送前), 直接通过 model.paramNameStartNum, model.paramNameStepCount来修改
//
//  TODO: 有可能需要支持直接指定pageNum, 而不去管start_num, count等更加细节的东西
//


@implementation JHURLRequestModel

- (id)initWithBaseURL:(NSString *)path andHttpRequest:(JHNetWorkManager *)request isPaged:(BOOL)isPaged andHttpParse:(JH_HTTP_PARSE_BLOCK)parseBlock itemFactory:(JH_TABLE_ITEM_FACTORY)itemFactory
{
    self = [super init];
    if (self) {
        _path = path;
        
        _httpRequest = request;
        
        _startNum = 0;
        _stepCount = 20;
        _page = 1;
        _startPage = 1;
        _isPaged = isPaged;
        
        //  httpMethod默认为GET,初始化后用户可以自己设置httpMethod
        _httpMethod = @"GET";
        _isTimeSensitive = NO;
        
        
        if (!_isPaged) {
            _stepCount = 10000;
        }
        
        _section = [NITableViewModelSection section];
        _section.rows = [NSMutableArray array];
        
        _multilineSections = [NSMutableArray array];
        
        _paramNameStartNum = @"start_num";
        _paramNameStepCount = @"count";
        _paramNamePage = @"page";
        
        _customHttpObjectParser = parseBlock;
        _tableItemFactory = itemFactory;
        
        
        _timestamp = (int)[[NSDate date] timeIntervalSince1970];
        _hasMoreByNonZero = NO;
        
        _loadFromFile = NO;     // 默认不从文件加载内容
        _requestCount = 0;
        _retryCountOnFail = 3;
        
        _loadFromFileOnly = NO;
    }
    
    return self;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [_httpRequestOperation cancel];
    _httpRequestOperation = nil;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(JHURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!_path) {
        return;
    }
    if (_loadFromFile && !more) {
        [self loadContentFromCache:more];
    }
    
    // 只加载本地cache
    if (self.loadFromFileOnly) {
        // 默认fail，为了隐藏上拉加载更多
        [self request:nil didFailLoadWithError:nil];
        return;
    }
    
    // 通过时间戳来控制是否强制刷新
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if (_isTimeSensitive) {
        parameters[@"_t"] = @(_timestamp);
    }
    
    // 增加用户的额外参数
    if (_parameters) {
        [parameters addEntriesFromDictionary: _parameters];
    }
    
    // 如果Model被修改了，则强制从第一页开始加载
    if (self.modelChanged) {
        more = NO;
        self.modelChanged = NO;
    }
    
    _isLoadingMore = NO;
    if (_isPaged) {
        if (!more) {
            _startNum = 0;
            _page = _startPage;
        } else {
            _isLoadingMore = YES;
        }
        parameters[_paramNameStartNum] = @(_startNum);
        parameters[_paramNameStepCount] = @(_stepCount);
        parameters[_paramNamePage] = @(_page);
    }
    _isLoading = YES;
    
    [[JHNetWorkManager sharedInstance] cancelAllRequests];
    
    //此处区分GET或者POST
    [self loadDataFromUrl:parameters withMore:more];
}

/**
 *  从网络获取数据
 */
- (void)loadDataFromUrl:(NSDictionary *)parameters withMore:(BOOL)more{
    
    if ([_httpMethod isEqualToString:@"GET"]) {
        [[JHNetWorkManager sharedInstance] getUrl:_path
                                   withParam:parameters
              withCompletionBlockWithSuccess:^(JHBaseRequest *success) {
                  [self parseSuccessData:success withMore:more];
              }
                                 withFailure:^(JHBaseRequest *failure, NSError *error) {
                                     NIDPRINT(@"error network: %@", error.localizedDescription);
                                     [self parseErrorData:failure withMore:more];
                                 }];
    }else{
        [[JHNetWorkManager sharedInstance] postUrl:_path
                                    withParam:parameters
               withCompletionBlockWithSuccess:^(JHBaseRequest *success) {
                   [self parseSuccessData:success withMore:more];
               }
                                  withFailure:^(JHBaseRequest *failure, NSError *error) {
                                      
                                  }];
    }
    
}

- (void)parseSuccessData:(JHBaseRequest *)request withMore:(BOOL)more{
    // 解析结果:破
    // 放在什么地方来解析呢?
    // 有自定义的代码可以解析
    // 支持基于block的解析
    if (!more) {
        // 清空现有的数据:
        [(NSMutableArray*)_section.rows removeAllObjects];
    }
    
    id result = nil;
    
    // 解析数据
    if (_customHttpObjectParser) {
        if ([request.requestUrl rangeOfString:@"crypt=1"].length>0) {
            NIDPRINT(@"Decrypt Json Data");
            NSString *result = [request.responseString stringByReplacingOccurrencesOfString: @"\n" withString: @"."];
            
            result = [[result URLDecodedString] URLDecodedString];
            
            result = [result objectFromJSONString];
            _customHttpObjectParser(request.requestOperation, result, self);
        }else {
            _customHttpObjectParser(request.requestOperation, request.responseObject, self);
        }
        
        // 医生端问题详情进行了加密
        
        NSString* filteredString = request.requestOperation.responseString;
        
        BOOL needDecypt = ([request.requestOperation.request.URL.absoluteString rangeOfString: @"chunyu"].length > 0) && ([request.requestOperation.request.URL.absoluteString rangeOfString:@"crypt=1"].length > 0);
        
        
        if (needDecypt) {
            NIDPRINT(@"Decrypt Json Data");
            
            filteredString = [filteredString stringByReplacingOccurrencesOfString: @"\n" withString: @"."];
            
            filteredString = [[filteredString URLDecodedString] URLDecodedString];
            
            result = [filteredString objectFromJSONString];
        }else {
            result = request.responseObject;
        }
        
        
    } else if (_tableItemFactory) {
        // 默认的解析:
        // 假定我们的数据都是JSON
        result = request.responseObject;
        
        NSMutableArray* items = [NSMutableArray array];
        NSArray* jsonArray = request.responseObject;
        for (NSInteger i = 0; i < jsonArray.count; i++) {
            JHTableItem* item = _tableItemFactory(jsonArray[i]);
            
            [items addObject: item];
            
        }
        [(NSMutableArray*)_section.rows addObjectsFromArray: items];
        
        _startNum += _stepCount;
        _page ++;
        
        if (_isPaged) {
            if (_hasMoreByNonZero) {
                _hasMore = items.count > 0;
            } else {
                _hasMore = items.count >= _stepCount;
            }
        }
    }
    
    
    [self requestDidFinishLoad: request.requestOperation withObject: result];
    
    // 展示完数据再保存，防止保存错误的数据
    [self saveCacheData:request withMore:more];
}

- (void)parseErrorData:(JHBaseRequest *)request withMore:(BOOL)more{
    NIDPRINT(@"URL Request Error");
    JH_DEFINE_SELF_BAR(self);
    NSError *error = nil;
    if (_loadFromFile && !more) {
        [_self request: request.requestOperation didFailLoadWithError: error];
        
        if (_requestCount < self.retryCountOnFail) {
            // 如果增量更新切失败次数《3
            [_self load: JHURLRequestCachePolicyNoCache more: more];
        } else {
            [_self request: request.requestOperation didFailLoadWithError: error];
        }
        
        _requestCount ++;
    } else {
        
        [_self request: request.requestOperation didFailLoadWithError: error];
        
    }
    
    NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
    NSString* requestUrl = [info objectForKey: kLastLogInHost];
    
    // 如果是请求，并且碰到302请求
    if ([requestUrl rangeOfString:TEST_HOST].length > 0 && [error.userInfo[@"status_code"] intValue] == 302) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"kChunyuLoginExpired" object: nil];
    }
}

- (void)saveCacheData:(JHBaseRequest *)request withMore:(BOOL)more{
    JH_DEFINE_SELF_BAR(self);
    if (!more) {
        // 首先替换NSNull
        if (_loadFromFile) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
                NSString *filePath = [self cacheFilePath];
                id writeToFileData = [_self getFilteredData: request.responseObject];
                if ([writeToFileData isKindOfClass: [NSDictionary class]] && [filePath isNotEmpty]) {
                    NSDictionary* dict = writeToFileData;
                    [dict writeToFile: filePath atomically: YES];
                }else if ([writeToFileData isKindOfClass: [NSArray class]] && [filePath isNotEmpty]) {
                    NSArray* array = writeToFileData;
                    [array writeToFile: filePath atomically: YES];
                }
            });
        }
    }
}

/**
 *  从缓存加载内容
 */
- (void)loadContentFromCache:(BOOL)more{
    NSString *filePath = [self cacheFilePath];
    NIDPRINT(@"%@", filePath);
    // 需要从文件预加载的内容，直接先从文件加载
    id cachedJSON = [NSDictionary dictionaryWithContentsOfFile: filePath];
    
    if (!cachedJSON) {
        cachedJSON = [NSArray arrayWithContentsOfFile: filePath];
    }
    if (!!cachedJSON) {
        if (!more) {
            // 清空现有的数据:
            [(NSMutableArray*)_section.rows removeAllObjects];
        }
        // 解析数据
        if (_customHttpObjectParser) {
            _customHttpObjectParser(nil, cachedJSON, self);
        } else if (_tableItemFactory) {
            // 默认的解析:
            // 假定我们的数据都是JSON
            NSMutableArray* items = [NSMutableArray array];
            NSArray* jsonArray = cachedJSON;
            for (NSInteger i = 0; i < jsonArray.count; i++) {
                JHTableItem* item = _tableItemFactory(jsonArray[i]);
                // 此时进行数据虑重，已经出现的数据不再添加进来
                if ([_filterKey isNotEmpty  ]) {
                    if (!_filterSet) {
                        _filterSet = [NSMutableSet set];
                    }
                    id filterValue = jsonArray[i][_filterKey];
                    if (filterValue && ![_filterSet containsObject: filterValue]) {
                        // 列表中已经包含数据了，不再添加
                        continue;
                    } else {
                        
                        [_filterSet addObject: filterValue];
                    }
                }
                [items addObject: item];
            }
            [(NSMutableArray*)_section.rows addObjectsFromArray: items];
            // cache读取的数据默认无法加载更多，只能通过更新数据后才能家在更多
            _multilineSections = [@[] mutableCopy];
            _hasMore = NO;
        }
    }
    
    [self requestDidFinishLoad: nil withObject: cachedJSON];
}

- (NSString *)cacheFilePath {
//    NSString* fileName = [NSString md5: [NSString stringWithFormat:@"%@%@%@", _path, [_parameters JSONRepresentation], [User sharedInstance].uid]];

    NSString* fileName = [NSString md5: [NSString stringWithFormat:@"%@%@", _path, [_parameters JSONRepresentation]]];
    
    NSString* dirName = [NSString getFilePath: @"cached_json_file/"];
    NSString *filePath = [NSString getFilePath: [NSString stringWithFormat: @"cached_json_file/%@.cache", fileName]];//
    NIDPRINT(@"%@", filePath);
    
    // 需要从文件预加载的内容，直接先从文件加载
    
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath: dirName
                                              isDirectory: &(isDir)]) {
        
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath: dirName
                                  withIntermediateDirectories: NO
                                                   attributes: nil
                                                        error: &error];
    }
    
    return filePath;
}

- (id) getFilteredData:(id)JSON {
    if([JSON isKindOfClass: [NSArray class]]) {
        
        return [self filterNSNullInJSON: JSON];
    } else if ([JSON isKindOfClass: [NSDictionary class]]) {
        
        NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: JSON];
        return [self filterNSNullInJSON: mutableDict];
    }
    return nil;
}

// 递归遍历 JSON 把 NSNull 过滤掉,因为有NSNull的话无法保存到文件
- (id) filterNSNullInJSON:(id)json {
    if ([json isKindOfClass: [NSArray class]]) {
        
        NSMutableArray* array = [NSMutableArray array];
        for (id subJSON in json) {
            if ([subJSON isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableDict]];
                
            } else if([subJSON isKindOfClass: [NSArray class]]) {
                
                NSMutableArray* mutableArray = [NSMutableArray arrayWithArray: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableArray]];
            } else {
                
                // 什么也不做
            }
        }
        return array;
        
    } else if([json isKindOfClass: [NSDictionary class]]){
        
        NSMutableDictionary* dict = json;
        for (NSString* key in [dict allKeys]) {
            if ([dict[key] isKindOfClass: [NSNull class]]) {
                
                dict[key] = @"";
            } else if ([dict[key] isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* subDict = [NSMutableDictionary dictionaryWithDictionary: dict[key]];
                dict[key] = [self filterNSNullInJSON: subDict];
                
            } else if ([dict[key] isKindOfClass: [NSArray class]]) {
                
                dict[key] = [self filterNSNullInJSON: dict[key]];
            }
        }
        return dict;
    }
    
    NIDASSERT(NO);
    return [NSNull null];
}

- (BOOL) hasMore {
    if (_isPaged) {
        return _hasMore;
    } else {
        return NO;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reset {
    // 需要重新加载数据
    //    _startNum = 0;
    //    _page = _startPage;
    //    _loadedTime = nil;
    _timestamp = (int)[[NSDate date] timeIntervalSince1970];
}


- (void) operationDidStart: (NSNotification*) notification {
    AFHTTPRequestOperation* operation = notification.object;
    // Request开始
    [self requestDidStartLoad: operation];
}

- (void) operationDidCancel: (NSNotification*) notification {
    AFHTTPRequestOperation* operation = notification.object;
    if (operation.error) {
        NSError* error = operation.error;
        if ([NSURLErrorDomain isEqualToString: error.domain] &&  error.code == NSURLErrorCancelled) {
            // Request取消
            [self requestDidCancelLoad: operation];
        }
    }
}

- (void) setMultilineSections: (NSArray*)multilineSections titleList:(NSArray*) titlesList {
    
    NIDASSERT(multilineSections.count == titlesList.count);
    if (!_multilineSections) {
        _multilineSections = [NSMutableArray array];
    }
    
    // 每次进去都会完全重新加载数据，清空以前的数据，因此，需要TableViewController自己维护数据，每次重新设置
    [_multilineSections removeAllObjects];
    if (multilineSections.count > 0) {
        
        for (NSInteger i = 0; i < multilineSections.count; ++i) {
            
            NITableViewModelSection* section = [NITableViewModelSection section];
            section.rows = [NSMutableArray array];
            section.headerTitle = i < titlesList.count ? titlesList[i] : @"";
            [(NSMutableArray*)section.rows addObjectsFromArray: multilineSections[i]];
            [_multilineSections addObject: section];
        }
        
    }else {
        
        NITableViewModelSection* section = [NITableViewModelSection section];
        section.headerTitle = @"";
        [_multilineSections addObject: section];
    }
}


#pragma mark - CYModel


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return (!_path) || (!!_loadedTime);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return _isLoading;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return _isLoadingMore;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    return _path && (nil == _loadedTime);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
    [_httpRequestOperation cancel];
    _httpRequestOperation = nil;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
    // DO NOTHING, right now
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(AFHTTPRequestOperation*) operation {
    _httpRequestOperation = operation;
    
    [self didStartLoad];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(AFHTTPRequestOperation*)operation withObject: (id) object {
    
    _isLoading = NO;
    if (!self.isLoadingMore) {
        _loadedTime = [NSDate date];
        
    }
    
    _httpRequestOperation = nil;
    [self didFinishLoadWithObject: object];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(AFHTTPRequestOperation*)operation didFailLoadWithError:(NSError*)error {
    _httpRequestOperation = nil;
    _isLoading = NO;
    [self didFailLoadWithError:error];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidCancelLoad:(AFHTTPRequestOperation*)operation {
    _httpRequestOperation = nil;
    _isLoading = NO;
    [self didCancelLoad];
}







@end
