//
//  JHTableViewListModel.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/17.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTableViewListModel : NSObject


@property (nonatomic, strong)NSMutableArray *grouparr0;
@property (nonatomic, strong)NSMutableArray *grouparr1;
@property (nonatomic, strong)NSMutableArray *grouparr2;
@property (nonatomic, strong)NSMutableArray *grouparr3;
@property (nonatomic, strong)NSMutableArray *grouparr4;
@property (nonatomic, strong)NSMutableArray *grouparr5;
@property (nonatomic, strong)NSMutableArray *titleDataArray;
@property (nonatomic, strong)NSArray *dataArray;//数据源，显示每个cell的数据
@property (nonatomic, strong)NSMutableDictionary *dataDict;//存对应的数据
@end
