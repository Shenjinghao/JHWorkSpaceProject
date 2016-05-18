//
//  JHNetworkImageView.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "NINetworkImageView.h"

@interface JHNetworkImageView : NINetworkImageView
/**
 *  网络需要加载的图片
 */
@property (nonatomic, strong) NSString* urlPath;
/**
 *  系统默认图片
 */
@property (nonatomic, strong) UIImage* defaultImage;
/**
 *  圆形图像
 *
 *  @param frame frame
 *
 *  @return
 */
+ (JHNetworkImageView *)roundViewWithFrame:(CGRect)frame;

@end
