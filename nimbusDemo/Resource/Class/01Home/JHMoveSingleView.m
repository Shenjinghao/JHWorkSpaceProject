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
    }
    
    return self;
}

- (void) creatLabel
{
    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50) fontSize:15 fontColor:COLOR_A1 text:_title];
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentCenter;
    _label = label;
    [self addSubview:_label];
        
}

@end
