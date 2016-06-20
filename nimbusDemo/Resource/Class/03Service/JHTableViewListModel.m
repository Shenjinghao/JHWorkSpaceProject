//
//  JHTableViewListModel.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/17.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTableViewListModel.h"

@interface JHTableViewListModel ()


@end

@implementation JHTableViewListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self creatData];
        
    }
    return self;
}

- (void)creatData
{
    _titleDataArray = [[NSMutableArray alloc] initWithObjects:@"姐妹",@"家人",@"朋友",@"亲爱的",@"同学",@"老乡", nil];
    _dataDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"肖利",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"段婷婷",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"毛凡",@"name",@"NO",@"state",nil];
    
    _grouparr0 = [[NSMutableArray alloc] initWithObjects:nameAndStateDic1,nameAndStateDic2,nameAndStateDic3, nil];
    
    NSMutableDictionary *nameAndStateDic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"晨晨姐",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"李涛",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"海波",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"张敏",@"name",@"NO",@"state",nil];
    
    _grouparr1 = [[NSMutableArray alloc]initWithObjects:nameAndStateDic4,nameAndStateDic5,nameAndStateDic6,nameAndStateDic7, nil];
    
    NSMutableDictionary *nameAndStateDic8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"杨浩",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"小明",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"洋洋",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic11 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"赵蒙",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic12 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"小催",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic13 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"和平",@"name",@"NO",@"state",nil];
    
    _grouparr2 = [[NSMutableArray alloc]initWithObjects:nameAndStateDic8,nameAndStateDic9,nameAndStateDic10,nameAndStateDic11,nameAndStateDic12,nameAndStateDic13,nil];
    
    NSMutableDictionary *nameAndStateDic14 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"老爸",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic15 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"老妈",@"name",@"NO",@"state",nil];
    
    _grouparr3 = [[NSMutableArray alloc] initWithObjects:nameAndStateDic14,nameAndStateDic15, nil];
    
    NSMutableDictionary *nameAndStateDic16 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"大包",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic17 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"小林子",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic18 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"石头",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic19 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"小轩轩",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic20 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"阿东",@"name",@"NO",@"state",nil];
    
    _grouparr4 = [[NSMutableArray alloc]initWithObjects:nameAndStateDic16,nameAndStateDic17,nameAndStateDic18,nameAndStateDic19,nameAndStateDic20, nil];
    
    NSMutableDictionary *nameAndStateDic21 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"郑平",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic22 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"刘凡",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic23 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"韩琴",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic24 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"刘华健",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic25 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"彭晓明",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic26 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"张欢",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic27 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"刘来楠",@"name",@"NO",@"state",nil];
    NSMutableDictionary *nameAndStateDic28 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",@"任强",@"name",@"NO",@"state",nil];
    
    _grouparr5 = [[NSMutableArray alloc]initWithObjects:nameAndStateDic21,nameAndStateDic22,nameAndStateDic23,nameAndStateDic24,nameAndStateDic25,nameAndStateDic26,nameAndStateDic27,nameAndStateDic28, nil];
    
    [_dataDict setValue:_grouparr0 forKey:@"0"];
    [_dataDict setValue:_grouparr1 forKey:@"1"];
    [_dataDict setValue:_grouparr2 forKey:@"2"];
    [_dataDict setValue:_grouparr3 forKey:@"3"];
    [_dataDict setValue:_grouparr4 forKey:@"4"];
    [_dataDict setValue:_grouparr5 forKey:@"5"];

}

@end
