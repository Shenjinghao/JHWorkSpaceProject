//
//  JHTabBarController.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTabBarController : UITabBarController
/**
 *  自定义badge
 *
 *  @param index
 *  @param value 
 */
- (void) setBadgeNumberAtIndex:(NSInteger) index value:(NSInteger) value;

@end


@interface TabBadgeView : UIButton

@property (nonatomic) BOOL isLarge;         // 判断是不是长条形，当显示的badge为两位数时候，isLarge=YES,否则isLarge=NO

@end

