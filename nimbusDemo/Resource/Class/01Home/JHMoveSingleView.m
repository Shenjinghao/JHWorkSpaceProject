//
//  JHMoveSingleView.m
//  测试Demo
//
//  Created by Shenjinghao on 2016/12/21.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHMoveSingleView.h"

@implementation JHMoveSingleView

- (instancetype) initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self creatLabel];
    }
    
    return self;
}

- (void) creatLabel
{
    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50) fontSize:15 fontColor:COLOR_A1 text:_title];
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.backgroundColor = [UIColor whiteColor];
    _label = label;
    //轻点
    WEAK_VAR(self);
    [self jhAddTapGestureWithActionBlock:^(UIGestureRecognizer *gesture) {
        
        safe_block(_self.clickOneViewTeturnTitleBlock,self.title);
        
        
    }];
//    [self jhAddTapGestureWithTarget:self selector:@selector(haha)];
    //长按
    [self jhAddLongPressGestureWithActionBlock:^(UIGestureRecognizer *gesture) {
        
        switch (gesture.state) {
                //移动前
            case UIGestureRecognizerStateBegan:
                safe_block(_self.beginMoveActionBlock,self.tagid);
                _label.textColor = [UIColor redColor];
                break;
                //移动中
            case UIGestureRecognizerStateChanged:
                safe_block(_self.moveViewActionBlock, self.tagid, gesture);
                break;
                //移动后
            case UIGestureRecognizerStateEnded:
                safe_block(_self.endMoveViewActionBlock,self.tagid);
                _label.textColor = COLOR_A1;
                break;
            default:
                break;
        }
        
    }];
        
}

@end
