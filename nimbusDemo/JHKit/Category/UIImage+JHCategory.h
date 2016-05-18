//
//  UIImage+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/11.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JHCategory)
/**
 *  截图,将当前页面转化成image
 *
 *  @param theView 需要转化的view
 *
 *  @return image
 */
- (UIImage *) getImageFromView:(UIView *)theView;

// 加载图片
- (UIImage*) load: (NSString*) imagePath;

//
// 加载图片
//
+ (UIImage*) load: (NSString*) imagePath;

/**
 *  填充色彩
 *
 *  @param tintColor 颜色
 *
 *  @return image
 */
- (UIImage*) imageWithTintColor:(UIColor*) tintColor;
// 创建图片可以拉升(Stretchable)的UIImageView
+ (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height;

+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size;

+ (UIImage*) imageHorizonalFliped: (UIImage*) image;

@end
