//
//  UIFont+JHCategory.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (JHCategory)

/**
 * Gets the height of a line of text with this font.
 *
 * Why this isn't part of UIFont is beyond me. This is the height you would expect to get
 * by calling sizeWithFont.
 *
 * App Store-safe method declaration.
 * Hurrah for broken static code analysis.
 */
- (CGFloat)ttLineHeight;

@end
