//
//  JHUrlTableViewModel.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//


//
// 在Nimbus中
// Model主要实现了: UITableViewDataSource的功能功能:
// 1. 管理基本的datasource功能: sections的管理
// 2. load more的管理
// 3. 和 JHUrlRequestModel继承，实现数据的请求，缓存管理等功能
//


#import "JHMutableTableViewModel.h"
#import <NICellFactory.h>

@class JHTableViewController;

@interface JHUrlTableViewModel : JHMutableTableViewModel<JHModelDelegate>
{
@protected
    
    
    // 一般一个TableViewController会包含一到多个 JHUrlTableViewModel
    __weak JHTableViewController  * _tableViewController;
}

// 为了简化设计，直接将内部属性给暴露
// Array of NITableViewModelSection
@property (nonatomic, strong) NSMutableArray* sections;
@property (nonatomic, strong) NSMutableArray* sectionIndexTitles;
@property (nonatomic, strong) NSMutableDictionary* sectionPrefixToSectionIndex;

//@property (nonatomic) BOOL hasMore;


//
// Http请求所采用的Method, 默认为 GET, 也可以采用 POST, DELETE, HEAD等
// 当为 POST时需要注意:
// 1. 需要通过POST方式传输的数据，可以通过参数 parameters 来传递
// 2. 放在URL中的参数，在传输过程中依然在URL中，而不是POST的body中
//
// 注意: 在构造 JHUrlTableViewModel 后需要立即设置HttpMethod,和parameters
//      其实只有httpMethod为"POST", 则需要parameters, 其他情况下: parameters直接被忽略
//
@property (nonatomic, strong) NSString* httpMethod;
@property (nonatomic, strong) NSDictionary* parameters;
// 是否有多个section，Default=NO，如果为YES，必须自己parse，设置model.multilineSections
@property (nonatomic) BOOL hasSectins;
@property (nonatomic) BOOL loadFromFile;
@property (nonatomic, strong) NSString* filterKey;

- (void) setHttpMethod:(NSString *)httpMethod andParams: (NSDictionary*) params;



// 已经记载过有效的数据
// 在Load More失败，如果: hasLoadValidData为True, 则只是简单给一个提示; 如果为NO, 则需要显示错误，给用户重现加载的机会
@property (nonatomic) BOOL hasLoadValidData;

/**
 *  使用默认的网络请求来加载数据
 *
 *  @param basePath            url
 *  @param delegate            delegate
 *  @param tableviewController tableviewController description
 *  @param parseBlock          parseBlock description
 *  @param itemFactory         itemFactory description
 *  @param isPaged             isPaged description
 *
 *  @return 
 */
- (id) initWithBaseURL: (NSString*)basePath                          // 请求的URL, 可以使用完整的URL, 或者相对于当前TEST_HOST的相对URL
              delegate: (NICellFactory*)delegate                     // 默认传递 JHTableViewController的 self.cellFactory
   tableViewController: (JHTableViewController*) tableviewController // 当前相关联的JHTableViewController
          andHttpParse: (JH_HTTP_PARSE_BLOCK) parseBlock        // 采用自定义的parser来解析返回的数据
           itemFactory: (JH_TABLE_ITEM_FACTORY) itemFactory     // 如果是标准的列表，直接通过ItemFactory来解析和创建对象即可
               isPaged: (BOOL) isPaged;                         // 是否分页, 会有“加载更多"的按钮

/**
 *  可以指定网络请求来加载数据
 *
 *  @param basePath            url
 *  @param delegate            delegate description
 *  @param tableviewController tableviewController description
 *  @param parseBlock          parseBlock description
 *  @param itemFactory         itemFactory description
 *  @param isPaged             isPaged description
 *  @param request             request description
 *
 *  @return 
 */
- (id) initWithBaseURL: (NSString*)basePath
              delegate: (NICellFactory*)delegate
   tableViewController: (JHTableViewController*) tableviewController
          andHttpParse: (JH_HTTP_PARSE_BLOCK) parseBlock
           itemFactory: (JH_TABLE_ITEM_FACTORY) itemFactory
               isPaged: (BOOL) isPaged
         andHttpRequest: (JHNetWorkManager*) request;





@end
