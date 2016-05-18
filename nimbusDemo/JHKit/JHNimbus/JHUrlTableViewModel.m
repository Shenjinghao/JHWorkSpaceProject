//
//  JHUrlTableViewModel.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHUrlTableViewModel.h"
#import "JHTableViewController.h"
#import <NITableViewModel+Private.h>

@implementation JHUrlTableViewModel
// 支持: DragRefresh & 使用默认的网络请求
- (id)initWithBaseURL:(NSString *)basePath delegate:(NICellFactory *)delegate tableViewController:(JHTableViewController *)tableviewController andHttpParse:(JH_HTTP_PARSE_BLOCK)parseBlock itemFactory:(JH_TABLE_ITEM_FACTORY)itemFactory isPaged:(BOOL)isPaged
{
    return [self initWithBaseURL:basePath delegate:delegate tableViewController:tableviewController andHttpParse:parseBlock itemFactory:itemFactory isPaged:isPaged andHttpRequest:[JHNetWorkManager sharedInstance]];
    
}

- (id)initWithBaseURL:(NSString *)basePath delegate:(NICellFactory *)delegate tableViewController:(JHTableViewController *)tableviewController andHttpParse:(JH_HTTP_PARSE_BLOCK)parseBlock itemFactory:(JH_TABLE_ITEM_FACTORY)itemFactory isPaged:(BOOL)isPaged andHttpRequest:(JHNetWorkManager *)request
{
    self = [super initWithDelegate:delegate];
    if (self) {
        _tableViewController = tableviewController;
        /**
         *  解耦和
         */
        self.model = [[JHURLRequestModel alloc] initWithBaseURL:basePath andHttpRequest:request isPaged:isPaged andHttpParse:parseBlock itemFactory:itemFactory];
        JHURLRequestModel *model = (JHURLRequestModel *)self.model;
        [model.delegates addObject:self];
        /**
         *  有分页需求，才会显示 "加载更多"
         */
        if (isPaged) {
            
        }
    }
    return self;
}

//
// Http请求所采用的Method, 默认为 GET, 也可以采用 POST, DELETE, HEAD等
// 当为 POST时需要注意:
// 1. 需要通过POST方式传输的数据，可以通过参数 parameters 来传递
// 2. 放在URL中的参数，在传输过程中依然在URL中，而不是POST的body中
//
// 注意: 在构造 JHUrlTableViewModel 后需要立即设置HttpMethod,和parameters
//      其实只有httpMethod为"POST", 则需要parameters, 其他情况下: parameters直接被忽略
//
- (void)setHttpMethod:(NSString *)httpMethod andParams:(NSDictionary *)params
{
    _httpMethod = httpMethod;
    _parameters = params;
    ((JHURLRequestModel *)self.model).httpMethod = httpMethod;
    ((JHURLRequestModel *)self.model).parameters = params;
    
}

- (void) setHttpMethod:(NSString *)httpMethod {
    _httpMethod = httpMethod;
    ((JHURLRequestModel*)self.model).httpMethod = httpMethod;
}

- (void) setParameters:(NSDictionary *)parameters {
    _parameters = parameters;
    ((JHURLRequestModel*)self.model).parameters = parameters;
}

- (void) setLoadFromFile:(BOOL)loadFromFile {
    _loadFromFile = loadFromFile;
    ((JHURLRequestModel*)self.model).loadFromFile = _loadFromFile;
}

- (void) setFilterKey:(NSString *)filterKey {
    _filterKey = filterKey;
    ((JHURLRequestModel*)self.model).filterKey = _filterKey;
}

- (void) dealloc {
    JHURLRequestModel* model = self.model;
    [model.delegates removeObject: self];
}

- (void)tableViewDidLoadModel:(UITableView *)tableView
{
    JHURLRequestModel *model = (JHURLRequestModel *)self.model;
    if (_hasSectins) {
        self.sections = model.multilineSections;
    }else{
        self.sections = [[NSMutableArray alloc] initWithObjects:model.section, nil];
    }
    /**
     *  在加载UI前根据hasMore判断是否添有上拉加载
     */
    self.hasMore = model.hasMore;
    if (_tableViewController) {
        /**
         *  MJRefresh封装在JHTableViewController里面
         */
        [_tableViewController updateLoadMoreView:self.hasMore];
    }
}
/**
 *  在点击加载更多时失败
 *
 *  @param model
 *  @param error
 */
- (void)model:(id<JHModel>)model didFailLoadWithError:(NSError *)error
{
    NSInteger rows = [self tableView:_tableViewController.tableView numberOfRowsInSection:0];
    // 参考: https://app.crittercism.com/developers/crash-details/64422f5241c885604a28d16c6aff09152f9cd297110d4de0c7608bc2
    NSIndexPath* path = [NSIndexPath indexPathForRow: rows - 1 inSection: 0];
    // [NSIndexPath indexPathForItem:index - 1 inSection:0];
    
    
    [_tableViewController.tableView reloadRowsAtIndexPaths: @[path] withRowAnimation: UITableViewRowAnimationNone];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return NO;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(JHURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    NIDPRINTMETHODNAME();
}


- (BOOL) hasLoadValidData {
    if (self.sections.count > 0) {
        NITableViewModelSection* section = self.sections[0];
        if (section.rows.count > 0) {
            return YES;
        }
    }
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_hasSectins) {
        return ((JHURLRequestModel*)(self.model)).multilineSections.count;
    } else {
        return 1;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_hasSectins) {
        return [super tableView: tableView titleForHeaderInSection: section];
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // 网络请求相关的TableView没有 section index
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return -1;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger result = 0;
    if (_hasSectins) {
        result = [super tableView: tableView numberOfRowsInSection: section];
    } else {
        if (section == 0) {
            //        result = [super tableView: tableView numberOfRowsInSection: section] + (self.hasMore ? 1 : 0);
            result = [super tableView: tableView numberOfRowsInSection: section];
        }
    }
    
    return result;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (_hasSectins) {
        
        return [super tableView: tableView cellForRowAtIndexPath: indexPath];
        
    } else {
        if (indexPath.section > 0) {
            return nil;
            
        }
        else {
            return [super tableView: tableView cellForRowAtIndexPath: indexPath];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    
    // NIDPRINT(@"Row: %d, Number of RowsInSection: %d", indexPath.row, [self tableView: nil numberOfRowsInSection: 0]);
    
    if (_hasSectins) {
        return [super objectAtIndexPath: indexPath];
    } else {
        NSInteger totalRowCount =[self tableView: nil numberOfRowsInSection: 0];
        
        /**
         *  4.5去掉加载更多按钮，加载更多通过上拉实现
         *
         */
        //    if (self.hasMore && indexPath.row == totalRowCount - 1) {
        //        return _loadMoreButton;
        //    } else
        if (indexPath.row >= totalRowCount) {
            return nil;
        } else {
            return [super objectAtIndexPath: indexPath];
        }
    }
}

@end
