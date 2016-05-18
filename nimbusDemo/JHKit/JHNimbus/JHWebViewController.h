//
//  JHWebViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"

@interface JHWebViewController : JHViewController<UIWebViewDelegate>

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title;
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSString* url;
@property (nonatomic) NSInteger type;

@end
