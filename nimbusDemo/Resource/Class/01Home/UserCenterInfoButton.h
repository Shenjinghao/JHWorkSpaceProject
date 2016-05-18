//
//  UserCenterInfoButton.h
//  ChunyuClinic
//
//  Created by Shenjinghao on 15/8/28.
//  Copyright (c) 2015年 lvjianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *单独为医生的指数创建button
 */
@interface UserCenterInfoButton : UIButton

- (void) setTitle:(NSString*)title count:(NSString*)count;
- (void) settitleText:(NSString*)title;
- (void) setCount:(NSString*)count;

- (void) showBadge:(BOOL) show;

@end
