//
//  JHAPIHost.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/21.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

/**
 *  APIHost
 *
 *  @param nonatomic <#nonatomic description#>
 *  @param readonly  <#readonly description#>
 *
 *  @return <#return value description#>
 */
#define kDefaultApiHostKey @"kDefaultApiHostKey"

#define kDefaultApiHost @"https://api.chunyuyisheng.com"

#define TEST_HOST [JHAPIHost sharedInstance].apiHost


#import <Foundation/Foundation.h>

@interface JHAPIHost : NSObject


@property (nonatomic, readonly) NSString *apiHost;
/**
 *  单例
 *
 *  @return sharedInstance
 */
+ (instancetype) sharedInstance;

@end
