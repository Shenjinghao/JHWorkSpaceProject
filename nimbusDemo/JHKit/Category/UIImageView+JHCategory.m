//
//  UIImageView+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIImageView+JHCategory.h"

@implementation UIImageView (JHCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIImageView*) imageViewWithImageName: (NSString*)imageName {
    UIImage* image = [UIImage imageNamed:imageName];
    return [[UIImageView alloc] initWithImage:image];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIImageView*) imageViewWithImage: (UIImage*)image {
    return [[UIImageView alloc] initWithImage:image];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIImageView*) imageViewWithImageName: (NSString*)imageName andFrame: (CGRect)frame {
    UIImage* image = [UIImage imageNamed:imageName];
    UIImageView* view = [[UIImageView alloc] initWithImage:image];
    view.frame = frame;
    
    return view;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIImageView*) imageViewWithImage: (UIImage*)image andFrame: (CGRect)frame {
    UIImageView* view = [[UIImageView alloc] initWithImage:image];
    view.frame = frame;
    
    return view;
}


@end
