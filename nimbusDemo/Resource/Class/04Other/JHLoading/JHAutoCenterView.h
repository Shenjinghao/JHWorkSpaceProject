//
//  JHAutoCenterView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/5.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHAutoCenterView : UIView

/**
 *  将当前view置于NavigationFrame()除去键盘后的区域的中心，
 *  键盘弹出和收起会自动调用updatePosition
 */
- (void)updatePosition;


@end
