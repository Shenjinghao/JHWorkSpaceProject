//
//  UIImageView+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JHCategory)

+ (UIImageView*) imageViewWithImageName: (NSString*)imageName;
+ (UIImageView*) imageViewWithImage: (UIImage*)image;

+ (UIImageView*) imageViewWithImageName: (NSString*)imageName andFrame: (CGRect)frame;
+ (UIImageView*) imageViewWithImage: (UIImage*)image andFrame: (CGRect)frame;


@end
