//
//  JHEmptyView.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHEmptyView : UIView

- (void)updateWithText:(NSString *)text;
- (NSString *)imageName;


@end

@interface ErrorView : JHEmptyView

@property (nonatomic, retain) UIImage*  image;
@property (nonatomic, copy)   NSString* title;
@property (nonatomic, copy)   NSString* subtitle;

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;


@end

@interface LoadingView : UIView

@property (nonatomic) BOOL isLoading;

@end

@interface JHLoadingView : UIView

- (void)updateWithText:(NSString *)text;

@end





