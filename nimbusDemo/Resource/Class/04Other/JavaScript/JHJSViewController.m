//
//  JHJSViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/8/11.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JHJSViewController ()

@end

@implementation JHJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)backToLastController:(id)sender
{
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS = @"alert('text JS')";//准备执行的js代码
    [context evaluateScript:alertJS];//通过oc方法调用js的alert  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
