//
//  JHFilledColorButton.h
//  测试Demo
//
//  Created by Shenjinghao on 16/1/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    kFilledBtnGreen = 0xFFFF,
    kFilledBtnWhite,
    kFilledBtnBlue,
    kFilledBtnGray,
    kFilledBtnRed,
    kFilledBtnOrange,
    kFilledBtnLightOrange,
    kFilledBtnSwirl,
    kFilledBtnClear,            // 透明的
    kFilledBtnBrown,
    kFilledBtnDarkBlue,
    kFilledBtnNone,
} FilledColorTyle;

@interface JHFilledColorButton : UIButton {
    UIColor* _backGroundColor;
    UIColor* _highlightedColor;
    
    UIColor* _enabledColor;
    UIColor* _textColor;
    UIColor* _enabledTextColor;
    //UILabel* _currentTitleLabel;
    UILabel* _titleLabel;
    
    NSInteger _fontSize;
    BOOL _isBold;
}

@property (nonatomic, strong) UILabel* currentTitleLabel;


- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle) type title:(NSString*) title;
- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle)type title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;
- (id) initWithFrame:(CGRect)frame color:(UIColor*)color highlightedColor:(UIColor*)highlightedColor textColor:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;
- (id) initWithFrame:(CGRect)frame color:(UIColor*)color highlightedColor:(UIColor*)highlightedColor enabledColor:(UIColor *)enabledColor textColor:(UIColor*)textColor enabledTextColor:(UIColor*)enabledTextColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;



// 初始化之后还能做修改
- (void) setTitle:(NSString *)title;
- (void) bindType:(FilledColorTyle) type title:(NSString*) title;
- (void) bindColor:(UIColor*)color highlightedColor:(UIColor*)highlightedColor textColor:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold;

@end
