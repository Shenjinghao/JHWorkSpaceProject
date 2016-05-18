//
//  UIFont+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIFont+JHCategory.h"

@implementation UIFont (JHCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttLineHeight {
    return (self.ascender - self.descender) + 1;
}


@end
