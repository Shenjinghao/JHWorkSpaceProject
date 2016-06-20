//
//  JHAutoFitTextView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/6.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTextView.h"

@class JHAutoFitTextView;
@protocol AutoFitTextViewDelegate <NSObject, UITextViewDelegate>

@optional
- (void)autoFitTextViewDidChangeFrame:(JHAutoFitTextView *)autoFitTextView;

- (void)autoFitTextViewDidChangeFocusLocation:
(JHAutoFitTextView *)autoFitTextView;

- (BOOL)shouldReturn;

@end


typedef BOOL (^TextViewShouldChangeBlock)(UITextView *textView,
                                          NSRange replacementRange,
                                          NSString *relacementText);

typedef void (^TextViewDidChangeBlock)(UITextView *textView);



@interface JHAutoFitTextView : JHTextView

- (void)setContainerInsetTop:(CGFloat)top bottom:(CGFloat)bottom;
- (void)setContainerInsets:(UIEdgeInsets)insets;
- (void)reset;

@property(nonatomic) CGFloat minHeight;
@property(nonatomic) CGFloat maxHeight;
@property(nonatomic) CGFloat bottomPadding;

@property(nonatomic) BOOL scrollable;

@end



