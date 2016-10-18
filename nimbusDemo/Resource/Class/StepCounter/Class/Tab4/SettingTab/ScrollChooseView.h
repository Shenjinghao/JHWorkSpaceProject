//
//  ScrollChooseView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/9/30.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollChooseView;

@protocol ScrollChooseViewDelegate <NSObject>

-(void)ScrollChooseView:(ScrollChooseView*)chooseView didChangedToValue:(NSInteger)value;

@end

/**
 *  滑动选择身高体重 界面
 *  size: 320*30
 */

@interface ScrollChooseView : UIScrollView

@property (nonatomic,weak) id<ScrollChooseViewDelegate> chooseDelegate;

@property (nonatomic) NSInteger selectedNo;

- (id) initWithFrame:(CGRect)frame start:(NSInteger)start end:(NSInteger)end interval:(NSInteger) interval defaultIndex:(NSInteger)index;

- (void) setOffsetIndex:(NSInteger) index;

@end
