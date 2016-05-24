//
//  JHDateBase.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHDateBase.h"
//注意：不要依赖FMDB/SQLCipher, 因为SQLCipher没有SQLITE_OPEN_FILEPROTECTION_NONE flag，锁屏时会写入数据库失败
#import "FMDB.h"


@implementation JHDateBase
{
    FMDatabaseQueue *_dbQueue;
}


+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self datebasePath]];
    }
    return self;
}

- (NSString *)datebasePath
{
    static NSString *datebasePath = nil;
    if (!datebasePath) {
        NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NIDPRINT(@"%@",cacheDirectory);
        datebasePath = [cacheDirectory stringByAppendingPathComponent:@"北漂小分队.db"];
    }
    return datebasePath;
}

- (void) creatPersonTable
{
    __block NSString *personTableSQL = @"creat table if not exist person(id varchar(63) unique not null,personId varchar(63),name varchar(63),age varchar(63)，image varchar(255)，gender varchar(63)，introduction varchar(1023),tel varchar(63),address varchar(255))";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"person"]) {
            [db executeUpdate:personTableSQL];
        }
    }];
}

- (void)creatTableByInfoId:(NSString *)infoId
{
    
}

@end
