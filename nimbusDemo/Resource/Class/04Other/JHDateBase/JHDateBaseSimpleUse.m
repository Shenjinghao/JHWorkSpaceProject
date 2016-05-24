//
//  JHDateBaseSimpleUse.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHDateBaseSimpleUse.h"

@implementation JHDateBaseSimpleUse

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance createTable];
    });
    return instance;
}

#pragma mark 创建数据库
-(void)openDB
{
    
    if ([self.db open]) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
}

#pragma mark 关闭数据库
-(BOOL)closeDB
{
    
    return [self.db close];
}


#pragma mark 创建表格
-(void)createTable
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *path1 = [path stringByAppendingString:@"/data.sqlite"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    self.db = [FMDatabase databaseWithPath:path1];
    
    if ([self.db open]) {
        
        //设置一个主键，避免重复插入
        NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE user (user_title text PRIMARY KEY NOT NULL,user_data blob,user_mark text)"];
        
        BOOL res = [self.db executeUpdate:sqlCreateTable];
        
        
        if (!res) {
            NSLog(@"创建表格失败");
        }else{
            NSLog(@"创建表格成功");
        }
        
        
    }
}

#pragma mark 添加数据
-(void)insertDataIntoTableWithUserTitle:(NSString *)user_title withUserData:(NSData *)modelData withMark:(NSString*)mark
{
    // NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO '%@' (user_title,user_data) VALUES (?,?)",table,user_title,modelData];
    if ([self.db open]) {
        
        
        
        BOOL res =  [self.db executeUpdate:@"INSERT INTO user (user_title,user_data,user_mark) VALUES (?,?,?)",user_title,modelData,mark];
        
        if (res) {
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
        }
    }
    
}




#pragma mark 删除数据
-(void)deleteDataWithUserTitle:(NSString *)user_title
{
    if ([self.db open]) {
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM user WHERE user_title = '%@'",user_title];
        
        BOOL res = [self.db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"删除失败");
        }else{
            NSLog(@"删除成功");
            
        }
    }
    
    
}


#pragma mark 根据title查询数据
- (NSData *)searchDataFromTableWithTitle:(NSString *)title {
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT  * FROM user WHERE user_title = '%@'",title];
        
        FMResultSet *rs = [self.db executeQuery:sql];
        NSData *modelData;
        
        while ([rs next]) {
            modelData = [rs dataForColumn:@"user_data"];
            
        }
        return modelData;
    }
    return nil;
}

#pragma mark 根据mark查询数据
-(NSMutableArray *)searchDataFromTableWithMark:(NSString*)mark
{
    
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT  * FROM user WHERE user_mark = '%@'",mark];
        
        FMResultSet *rs = [self.db executeQuery:sql];
        NSMutableArray *array = [NSMutableArray array];
        
        while ([rs next]) {
            
            
            NSData *modelData = [rs dataForColumn:@"user_data"];
            
            
            [array addObject:modelData];
            
            
            
        }
        return array;
        
    }
    
    return nil;
    
}

@end
