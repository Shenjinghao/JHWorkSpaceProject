//
//  JHCollectionViewFlowLayout.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自己设计布局
 */

@interface JHCollectionViewFlowLayout : UICollectionViewFlowLayout
/**
 *  初始化的高度
 */
@property (nonatomic) CGFloat headerHeight;

- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight;

@end
