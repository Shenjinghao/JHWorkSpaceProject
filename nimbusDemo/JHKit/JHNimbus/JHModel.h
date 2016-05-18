//
//  JHModel.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

typedef NS_ENUM(NSInteger,JHURLRequestCachePolicy) {
    JHURLRequestCachePolicyNone    = 0,
    JHURLRequestCachePolicyMemory  = 1,
    JHURLRequestCachePolicyDisk    = 2,
    JHURLRequestCachePolicyNetwork = 4,
    JHURLRequestCachePolicyNoCache = 8,
    
    JHURLRequestCachePolicyEtag    = 16 | JHURLRequestCachePolicyDisk,
    
    // Local: 内存 + Disk
    JHURLRequestCachePolicyLocal   = (JHURLRequestCachePolicyMemory | JHURLRequestCachePolicyDisk),
    // 默认: 内存 + Disk + 网络
    JHURLRequestCachePolicyDefault = (JHURLRequestCachePolicyMemory | JHURLRequestCachePolicyDisk |JHURLRequestCachePolicyNetwork),
};



#import <Foundation/Foundation.h>

@protocol JHModel <NSObject>
/**
 *  各种实现
 *
 *  @return
 */
- (NSMutableArray *) delegates;
/**
 *  数据是否加载，默认为YES
 *
 *  @return yes
 */
- (BOOL) isLoaded;
/**
 *  是否正在加载中: 默认为NO
 *
 *  @return no
 */
- (BOOL) isLoading;
/**
 *  是否在加载更多: 默认为NO
 *
 *  @return no
 */
- (BOOL) isLoadingMore;
/**
 *  数据是否过期，默认为NO
 *
 *  @return no
 */
- (BOOL) isOutDated;
/**
 *  取消当前的网络请求
 */
- (void) cancel;
/**
 *  重置model的状态
 */
- (void) reset;
// 加载数据: 默认啥都不做
- (void)load:(JHURLRequestCachePolicy)cachePolicy more:(BOOL)more;

@end



@interface JHModel : NSObject<JHModel>
{
    NSMutableArray *_delegates;
}
/**
 *  通知delegates开始下载
 */
- (void) didStartLoad;
/**
 *  通知delegates下载完成，其中object为解析出来的结果，例如: http data, json, xml等
 *
 *  @param object <#object description#>
 */
- (void) didFinishLoadWithObject:(id)object;
/**
 *  通知delegates下载失败, 其中error为失败的内容
 *
 *  @param error error
 */
- (void) didFailLoadWithError:(NSError *)error;
/**
 *  通知delegates下载取消
 */
- (void) didCancelLoad;
/**
 *  通知delegates开始updates
 */
- (void)beginUpdates;
/**
 *  通知delegates结束updates
 */
- (void)endUpdates;
// Notifies delegates that an object was updated.
- (void)didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

// Notifies delegates that an object was inserted.
- (void)didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

// Notifies delegates that an object was deleted.
- (void)didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

// Notifies delegates that the model changed in some fundamental way.
- (void)didChange;

@end
