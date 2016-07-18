//
//  JHPopWindowViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHPopWindowViewController.h"
#import "JHPopWindowView.h"
#import "PersonDoctorSeviceListPriceView.h"

@implementation JHPopWindowViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 80, 180, 45);
    [button1 addTarget:self action:@selector(button1DidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 180, 180, 45);
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 addTarget:self action:@selector(button2DidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) button1DidClicked:(UIButton *)sender
{
    JHPopWindowView *view = [[JHPopWindowView alloc] initWithFrame:CGRectZero];
    view.popWindowBackgroundColor = COLOR_A1;
    UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 45)];
    a.text = @"pop window";
    a.backgroundColor = COLOR_A3;
    [view addSubview:a];
    [view show:kPopWindowViewFromCenter isInWindow:YES];
    view.tapBackgroundToDismiss = YES;
    view.dismissBlock = ^(JHPopWindowView *popView, NSDictionary *result){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: @"pop window"
                                                            message: @""
                                                           delegate: self
                                                  cancelButtonTitle: @"我知道了"
                                                  otherButtonTitles: nil];
        [alertView show];
    };
}

- (void) button2DidClicked:(UIButton *)sender
{
    PersonDoctorSeviceListPriceView* view = [[PersonDoctorSeviceListPriceView alloc] initWithFrame:CGRectMake(0, 0, 250, 0)];
    [view show:kPopWindowViewFromBottom isInWindow:NO];
    view.tapBackgroundToDismiss = YES;
    view.dismissBlock = ^(JHPopWindowView *popView, NSDictionary *result){
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: @"pop window"
                                                            message: @""
                                                           delegate: self
                                                  cancelButtonTitle: @"我知道了"
                                                  otherButtonTitles: nil];
        [alertView show];
    };
}

@end

