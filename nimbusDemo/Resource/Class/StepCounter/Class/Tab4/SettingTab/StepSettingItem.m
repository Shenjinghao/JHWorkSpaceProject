//
//  StepSettingItem.m
//  测试Demo
//
//  Created by Shenjinghao on 16/10/18.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "StepSettingItem.h"

@implementation StepSettingItem

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        self.title = attributes[@"title"];
    }
    return self;
}

- (Class)cellClass
{
    return [StepSettingItemCell class];
}

@end

@implementation StepSettingItemCell
{
    UILabel* _titleLabel;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    return 43;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        _titleLabel = [UILabel labelWithFrame:CGRectMake(14, 15, 100, 16) fontSize:14 fontColor:RGBCOLOR_HEX(0x323232) text:@""];
        [_titleLabel sizeToFit];
        _titleLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (BOOL)shouldUpdateCellWithObject:(id)object
{
    StepSettingItem *item = object;
    if ([super shouldUpdateCellWithObject:object]) {
        _titleLabel.text = item.title;
        [_titleLabel sizeToFit];
    }
    return YES;
}

@end
