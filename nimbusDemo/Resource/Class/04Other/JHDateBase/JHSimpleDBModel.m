//
//  JHSimpleDBModel.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/24.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHSimpleDBModel.h"

@implementation JHSimpleDBModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
    
    
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
    }
    
    return  self;
    
}

@end
