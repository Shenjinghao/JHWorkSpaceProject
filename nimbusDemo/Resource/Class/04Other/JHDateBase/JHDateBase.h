//
//  JHDateBase.h
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHDateBase : NSObject

+ (instancetype)shareInstance;
/**
 *  创建表格
 *
 *  @param infoId 通过infoId创建
 */
- (void)creatTableByInfoId:(NSString *)infoId;

@end
