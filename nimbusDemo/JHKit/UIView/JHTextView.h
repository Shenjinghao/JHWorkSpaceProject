//
//  JHTextView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/6.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTextView : UITextView

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;

@end
