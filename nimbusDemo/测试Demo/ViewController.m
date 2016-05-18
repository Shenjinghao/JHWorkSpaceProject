//
//  ViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/8/25.
//  Copyright (c) 2015年 Shenjinghao. All rights reserved.
//

#import "ViewController.h"
#import "JHIndexViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLOR_A7;
    button.frame = CGRectMake(30, 44 + 50, viewWidth() - 60, 60);
    [button setBackgroundImage:[UIImage load:@"depression_face"] forState:UIControlStateNormal];
    [button setTitle:@"春雨诊所入口" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_A12 forState:UIControlStateNormal];

    [self.view addSubview:button];
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) jump
{
    JHIndexViewController *VC = [[JHIndexViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
