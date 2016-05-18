//
//  JHActivityView.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

typedef enum {
    JHActivityLabelStyleWhite,
    JHActivityLabelStyleGray,
    JHActivityLabelStyleBlackBox,
    JHActivityLabelStyleWhiteBox
} JHActivityViewStyle;


#import <UIKit/UIKit.h>

@interface JHActivityView : UIView
{
    UIView*                   _bezelView;
    UIProgressView*           _progressView;
    UIActivityIndicatorView*  _activityIndicator;
    UILabel*                  _label;
    
    NSTimer*                  _smoothTimer;
}

@property (nonatomic, readonly) JHActivityViewStyle style;

@property (nonatomic, copy)     NSString* text;
@property (nonatomic, strong)   UIFont*   font;

@property (nonatomic)           float     progress;
@property (nonatomic)           BOOL      isAnimating;
@property (nonatomic)           BOOL      smoothesProgress;

- (id)initWithFrame:(CGRect)frame style:(JHActivityViewStyle)style;
- (id)initWithFrame:(CGRect)frame style:(JHActivityViewStyle)style text:(NSString*)text;
- (id)initWithStyle:(JHActivityViewStyle)style;

@end
