//
//  JHMacros.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/15.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#ifndef JHMacros_h
#define JHMacros_h


#define RGBCOLOR_HEX(hexColor) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f         \
                                                green: (((hexColor >> 8) & 0xFF))/255.0f          \
                                                blue: ((hexColor & 0xFF))/255.0f                 \
                                                alpha: 1]


#define COLOR_A1        RGBCOLOR_HEX(0x1B91E0)
#define COLOR_A2        RGBCOLOR_HEX(0x1777B7)
#define COLOR_A3        RGBCOLOR_HEX(0x323232)
#define COLOR_A4        RGBCOLOR_HEX(0x666666)
#define COLOR_A5        RGBCOLOR_HEX(0x999999)
#define COLOR_A6        RGBCOLOR_HEX(0xc2c2c2)
#define COLOR_A7        RGBCOLOR_HEX(0xD6E1E8)
#define COLOR_A8        RGBCOLOR_HEX(0xEEEEEE)
#define COLOR_A9        RGBCOLOR_HEX(0xF1F1F1)
#define COLOR_A10       RGBCOLOR_HEX(0xFFFFFF)
#define COLOR_A11       RGBCOLOR_HEX(0xFF0000)
#define COLOR_A12       RGBCOLOR_HEX(0xFF623E)
#define COLOR_A13       RGBCOLOR_HEX(0x175B83)
#define COLOR_A14       RGBCOLOR_HEX(0xC2E6FB)
#define COLOR_A15       RGBCOLOR_HEX(0xFFA800)
#define COLOR_A16       RGBCOLOR_HEX(0x00BF3A)
#define COLOR_A17       RGBCOLOR_HEX(0x00BF3A)
#define COLOR_A18       RGBCOLOR_HEX(0xFF623E)
#define COLOR_A19       RGBCOLOR_HEX(0xF2532F)
#define COLOR_A20       RGBCOLOR_HEX(0xFFA800)

// #ifdef DEBUG
#ifdef DEBUG
#define JHPRINT(xx, ...)  NSLog(xx, ##__VA_ARGS__)
#else
#define JHPRINT(xx, ...)  ((void)0)
#endif

//__weak
#define WEAK_VAR(v) \
__weak typeof(v) _##v = v


// 将计时器 NSTimer 删除
#define JH_INVALIDATE_TIMER(t)     \
[t invalidate];             \
t = nil

// 将UIView删除(从Super中移除，并且设置为 nil)
#define JH_DELETE_VIEW(v)       \
[v removeFromSuperview];    \
v = nil


#define kHttpMethodPost @"POST"
#define kHttpMethodGet  @"GET"
#define kHttpMethodDelete  @"DELETE"



// 登录的Host
#define kLastLogInHost                      (@"kLastLogInHost")

//版本判断
#define kIOSVersion [[UIDevice currentDevice].systemVersion floatValue]
#define IOSOVER(v) (kIOSVersion >= v)

//safe_block
#ifndef safe_block
#define safe_block(block, ...) block ? block(__VA_ARGS__) : nil
//机型判定
#define IS_iPhone4 ([UIScreen mainScreen].bounds.size.height < 568)
#define _IPHONE6PLUS_ ([UIScreen mainScreen].scale == 3.0f)

#endif


#endif /* JHMacros_h */
