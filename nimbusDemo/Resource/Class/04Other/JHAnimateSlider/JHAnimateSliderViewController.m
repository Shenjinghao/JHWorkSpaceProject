//
//  JHAnimateSliderViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/20.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHAnimateSliderViewController.h"
//滑动动画
#import "JHAnimateSlider.h"


@implementation JHAnimateSliderViewController

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"滑动动画";
    self.view.backgroundColor = COLOR_A9;
    
    JHAnimateSlider *sliderView = [[JHAnimateSlider alloc] initWithFrame:CGRectMake(30, 100, viewWidth() - 40, 56)];
    sliderView.text = @"滑动起来~~~~~~~~~~~~~~~";
    sliderView.sliderState = kSliderStateUnFinished;
    sliderView.tapBlock = ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"触发" message:@"点击" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    };
    sliderView.finishBlock = ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"触发" message:@"滑动" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    };
    [self.view addSubview:sliderView];
}

@end
