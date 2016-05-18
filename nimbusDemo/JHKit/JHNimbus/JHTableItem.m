//
//  JHTableItem.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHTableItem.h"

@implementation JHTableItem

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithAttributes:(NSDictionary *)attributes andCellClass: (Class)cellClass {
    self = [super initWithCellClass: cellClass];
    if (self) {
        
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithAttributes:(NSDictionary *)attributes {
    return [self initWithAttributes: attributes andCellClass: nil];
}

@end

@implementation JHTableItemCell
/**
 *  默认实现，不必要重构
 */
+(CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    return 0.0f;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = nil;
        self.backgroundView = nil;
    }
    return self;
}

#pragma mark NICell
- (BOOL)shouldUpdateCellWithObject:(id)object
{
    if ([self respondsToSelector:@selector(setObject:)]) {
        [self setObject:object];
    }else{
        self.item = object;
    }
    return YES;
}

- (void) setObject:(id)object
{
    self.item = object;
}


@end




