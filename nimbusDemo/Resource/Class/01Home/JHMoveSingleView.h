//
//  JHMoveSingleView.h
//  测试Demo
//
//  Created by Shenjinghao on 2016/12/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
//点击view
typedef void(^clickOneViewTeturnTitleBlock)(NSString *title);
//移动前
typedef void(^beginMoveActionBlock)(NSString *tag);
//移动中
typedef void(^moveViewActionBlock)(NSString *tag, UIGestureRecognizer *gesture);
//移动后
typedef void(^endMoveViewActionBlock)(NSString *tag);


@interface JHMoveSingleView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGPoint viewPoint;
@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) clickOneViewTeturnTitleBlock clickOneViewTeturnTitleBlock;
@property (nonatomic, copy) beginMoveActionBlock beginMoveActionBlock;
@property (nonatomic, copy) moveViewActionBlock moveViewActionBlock;
@property (nonatomic, copy) endMoveViewActionBlock endMoveViewActionBlock;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;


@end
