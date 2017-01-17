//
//  JHMoveSingleView.h
//  测试Demo
//
//  Created by Shenjinghao on 2016/12/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHMoveSingleView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGPoint viewPoint;
@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) UILabel *label;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;


@end
