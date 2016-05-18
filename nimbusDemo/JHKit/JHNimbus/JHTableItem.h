//
//  JHTableItem.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "NICellFactory.h"

@interface JHTableItem : NICellObject

/**
 *  推荐init函数的接口(主要用于List)
 *
 *  @param attributes 属性
 *
 *  @return
 */
- (id)initWithAttributes:(NSDictionary *)attributes;
- (id)initWithAttributes:(NSDictionary *)attributes andCellClass: (Class)cellClass;
/**
 *
 也可以自定义其他类型的接口
 例如:  -(id) initWithTitle: (NSString*) title andImage: (NSString*) url
 但是注意调用: self = [super initWithAttributes: nil andCellClass: [xxx class]]
 

 */


@end

@interface JHTableItemCell : UITableViewCell<NICell>

@property (nonatomic, strong) JHTableItem *item;

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;



@end




