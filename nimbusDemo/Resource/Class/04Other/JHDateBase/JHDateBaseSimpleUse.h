//
//  JHDateBaseSimpleUse.h
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface JHDateBaseSimpleUse : NSObject

@property (nonatomic, strong) FMDatabase *db;

+ (instancetype)shareInstance;

#pragma mark 创建数据库
-(void)openDB;


#pragma mark 关闭数据库
-(BOOL)closeDB;


#pragma mark 创建表格
-(void)createTable;


#pragma mark 添加数据
-(void)insertDataIntoTableWithUserTitle:(NSString *)user_title withUserData:(NSData *)modelData withMark:(NSString*)mark ;

#pragma mark 删除数据
-(void)deleteDataWithUserTitle:(NSString *)user_title;

- (NSData *)searchDataFromTableWithTitle:(NSString *)title;

#pragma mark 查询数据
-(NSMutableArray *)searchDataFromTableWithMark:(NSString*)mark;

@end
