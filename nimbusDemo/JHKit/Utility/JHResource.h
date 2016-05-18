//
//  JHResource.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/29.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHResource : NSObject

// 加载图片
- (UIImage*) load: (NSString*) imagePath;
- (UIImage*) loadFliped: (NSString*) imagePath;


- (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height;

// 修改系统的主题(TODO)
- (void) changeTheme: (NSString*) thema;

// 系统内存警告时候调用，腾出内存
+ (void) removeAll;

//
// 加载图片
//
+ (UIImage*) load: (NSString*) imagePath;
+ (UIImage*) loadFliped: (NSString*) imagePath;
+ (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height;
/**
 *  背景颜色
 *
 *  @return 
 */
+ (UIColor*) viewBackgroundColor;

@end
