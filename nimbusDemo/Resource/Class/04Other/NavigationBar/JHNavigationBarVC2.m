//
//  JHNavigationBarVC2.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHNavigationBarVC2.h"
#import "UINavigationBar+JHDynamicChangeNavigationBar.h"


@implementation JHNavigationBarVC2

#pragma mark scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY > 0) {
        if (offSetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        }else{
            [self setNavigationBarTransformProgress:(offSetY / 44)];
        }
    }else{
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
        [self.navigationController.navigationBar jh_setTranslationY:(-64 * progress)];
    [self.navigationController.navigationBar jh_setElementsAlpha:(1 - progress)];
}

@end
