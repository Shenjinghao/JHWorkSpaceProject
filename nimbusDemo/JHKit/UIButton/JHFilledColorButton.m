//
//  JHFilledColorButton.m
//  测试Demo
//
//  Created by Shenjinghao on 16/1/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHFilledColorButton.h"


#define kSepatateLineColor RGBCOLOR_HEX(0xe2e2e2)
#define kSeparateLineDarkColor RGBCOLOR_HEX(0xf8fafc)
#define kMainColorGreen RGBCOLOR_HEX(0x39d167)
#define kEnalbeNoStateColor RGBCOLOR_HEX(0xc6c7c9)

static const CGFloat kBtnTitleFontSize = 17;

@implementation JHFilledColorButton

- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle)type title:(NSString *)title
            fontSize:(NSInteger) size isBold:(BOOL) isbold {
    _fontSize = size;
    _isBold = isbold;
    self = [self initWithFrame: frame type:type title:title ];
    if (self) {
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame type:(FilledColorTyle) type title:(NSString*) title {
    // 字体大小 和 自己加粗设定缺省
    if (_fontSize == 0) {
        _isBold = YES;
        _fontSize = kBtnTitleFontSize;
    }
    
    [self setBtnStyleWithType: type];
    
    self = [self initWithFrame: frame
                         color: _backGroundColor
              highlightedColor: _highlightedColor
                     textColor: _textColor
                         title: title
                      fontSize: _fontSize
                        isBold: _isBold];
    if (self) {
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor textColor:(UIColor *)textColor title:(NSString *)title fontSize:(NSInteger)size isBold:(BOOL)isbold {
    self = [self initWithFrame: frame
                         color: color
              highlightedColor: highlightedColor
                  enabledColor: _enabledColor
                     textColor: textColor
              enabledTextColor: _enabledTextColor
                         title: title
                      fontSize: size
                        isBold: isbold];
    return self;
}



- (id) initWithFrame:(CGRect)frame color:(UIColor*)color highlightedColor:(UIColor*)highlightedColor enabledColor:(UIColor *)enabledColor textColor:(UIColor*)textColor enabledTextColor:(UIColor*)enabledTextColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold {
    
    self = [super initWithFrame: frame];
    if (self) {
        
        _backGroundColor = color;
        _highlightedColor = highlightedColor;
        
        _enabledColor = enabledColor;
        _textColor = textColor;
        _enabledTextColor = enabledTextColor;
        _fontSize = size;
        _isBold = isbold;
        
        _titleLabel = [UILabel labelWithFrame: CGRectMake(0, (CGRectGetHeight(frame) - kBtnTitleFontSize-1)/2, CGRectGetWidth(frame), kBtnTitleFontSize+1)
                                 boldFontSize: _fontSize
                                    fontColor: _textColor
                                         text: title];
        _currentTitleLabel = _titleLabel;
        if (!_isBold) {
            
            _titleLabel.font = [UIFont systemFontOfSize: _fontSize];
        }
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _titleLabel];
        
        
        self.layer.cornerRadius = 2.5;
        self.backgroundColor = _backGroundColor;
        
        if (self.backgroundColor == [UIColor whiteColor]) {
            self.layer.borderColor = kSepatateLineColor.CGColor;
            self.layer.borderWidth = 1;
        } else {
            self.layer.borderWidth = 0;
        }
    }
    return self;
}

//
// 设置一些颜色
//
- (void) setBtnStyleWithType:(FilledColorTyle) type {
    switch (type) {
        case kFilledBtnGreen: {
            _backGroundColor = RGBCOLOR_HEX(0x39d167);
            _highlightedColor = RGBCOLOR_HEX(0x27b953);
            _textColor = [UIColor whiteColor];
        }
            
            break;
        case kFilledBtnWhite: {
            
            _backGroundColor = [UIColor whiteColor];
            _highlightedColor = RGBCOLOR_HEX(0xcfcfcf);
            _textColor = [UIColor blackColor];
        }
            break;
        case kFilledBtnBlue: {
            
            _backGroundColor = RGBCOLOR_HEX(0x1B91E0);
            _highlightedColor = RGBCOLOR_HEX(0x4f91db);
            _textColor = [UIColor whiteColor];
        }
            break;
        case kFilledBtnGray: {
            _backGroundColor = RGBCOLOR_HEX(0xcacaca);
            _highlightedColor = RGBCOLOR_HEX(0xa5a5a5);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnRed: {
            _backGroundColor = RGBCOLOR_HEX(0xf93143);
            _highlightedColor = RGBCOLOR_HEX(0xdb1527);
            _textColor = [UIColor whiteColor];
            
        }
            break;
            
        case kFilledBtnOrange: {
            _backGroundColor = RGBCOLOR_HEX(0xff6000);
            _highlightedColor = RGBCOLOR_HEX(0xe65303);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnLightOrange: {
            _backGroundColor = RGBCOLOR_HEX(0xfe9537);
            _highlightedColor = RGBCOLOR_HEX(0xce792c);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnClear: {
            _backGroundColor = [UIColor clearColor];
            _highlightedColor = RGBACOLOR(0xff, 0xff, 0xff, 0.5);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnSwirl:{
            _backGroundColor = RGBCOLOR_HEX(0xd7cabe);
            _highlightedColor = RGBCOLOR_HEX(0xb7a099);
            _textColor = [UIColor whiteColor];
        }
            break;
            
            
        case kFilledBtnBrown:{
            _backGroundColor = RGBCOLOR_HEX(0xd5c7bb);
            _highlightedColor = RGBCOLOR_HEX(0x9d9288);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnDarkBlue: {
            _backGroundColor = RGBCOLOR_HEX(0x1b91e0);
            _highlightedColor = RGBCOLOR_HEX(0x1169a3);
            _textColor = [UIColor whiteColor];
        }
            break;
            
        case kFilledBtnNone: {
            break;
        }
            
        default:
            break;
    }
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    
    self.backgroundColor = highlighted ? _highlightedColor : _backGroundColor;
}


- (void) setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.layer setBorderWidth:1.f];
    //    [self.layer setBorderColor:RGBCOLOR_HEX(0x2693dd).CGColor];
    self.layer.borderColor = selected?RGBCOLOR_HEX(0x2693dd).CGColor:kSepatateLineColor.CGColor;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (!_enabledTextColor) {
        _enabledTextColor = [UIColor whiteColor];
    }
    if (!_enabledColor) {
        _enabledColor = kSeparateLineDarkColor;
    }
    
    _titleLabel.textColor = enabled ? _textColor : _enabledTextColor;
    self.backgroundColor = enabled ? _backGroundColor : _enabledColor;
    
}

- (void) bindType:(FilledColorTyle) type title:(NSString*) title {
    [self setBtnStyleWithType: type];
    [self updateDisplay];
    [self setTitle: title];
    
}

- (void) bindColor:(UIColor*)color highlightedColor:(UIColor*)highlightedColor textColor:(UIColor*)textColor title:(NSString *)title fontSize:(NSInteger) size isBold:(BOOL) isbold {
    
    _backGroundColor = color;
    _highlightedColor = highlightedColor;
    _textColor = textColor;
    _fontSize = size;
    _isBold = isbold;
    
    [self updateDisplay];
    [self setTitle: title];
    
    if (self.backgroundColor == [UIColor whiteColor]) {
        self.layer.borderColor = kSepatateLineColor.CGColor;
        self.layer.borderWidth = 1;
    } else {
        self.layer.borderWidth = 0;
    }
}

//
// 重绘颜色
//
- (void) updateDisplay {
    
    _titleLabel.textColor = _textColor;
    _titleLabel.font = _isBold ? [UIFont boldSystemFontOfSize: _fontSize] : [UIFont systemFontOfSize: _fontSize];
    _titleLabel.textColor = _textColor;
    
    
    self.backgroundColor = _backGroundColor;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _titleLabel.frame = CGRectMake(0, (CGRectGetHeight(frame) - kBtnTitleFontSize-1)/2, CGRectGetWidth(frame), kBtnTitleFontSize+1);
}

@end

