//
//  JHWebViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHWebViewController.h"

@implementation JHWebViewController

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title
{
    self = [super initWithQuery:nil];
    if (self) {
        self.title = title;
        self.url = url;
    }
    return self;
}

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:nil];
    if (self) {
        self.flurryTitle = @"JHWebViewController";
        self.title = query[@"title"];
//        _confirmQuit = NO;
        self.type = [query[@"type"] integerValue];
        self.url = query[@"url"];
        
    }
    return self;
}

- (void)dealloc
{
    _webView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:JHNavigationFrame()];
    /**
     *  UIDataDetectorTypeLink检测网址和邮箱
     */
    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    _webView.opaque = YES;
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: _webView];
    
    //对url进行了封装操作。
//    [self loadUrl: [_url urlPathWithCommonStat]];
    [self loadUrl:_url];
    
    
}

- (void) loadUrl:(NSString*) url {
    NIDPRINT(@"loading url is %@", url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
}

#pragma - mark UIWebViewDelegate
- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    [self showLoading: YES];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self showLoading: NO];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self showLoading: NO];
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
  navigationType:(UIWebViewNavigationType)navigationType {
    NIDPRINT(@"loading url is %@", request.URL.absoluteString);
    
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)backToLastController: (id)sender {
    // 如果可以后退，则后退，否则关闭页面
    if (_webView.canGoBack) {
        [_webView goBack];
        
    } else {
        [super backToLastController: sender];
    }
    
}

@end
