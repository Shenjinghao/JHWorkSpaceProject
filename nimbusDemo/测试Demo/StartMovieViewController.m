//
//  StartMovieViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 2016/11/22.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "StartMovieViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "ViewController.h"


@interface StartMovieViewController ()

@property(nonatomic,strong) NSURL *movieURL;
@property(nonatomic,strong) MPMoviePlayerController *player;

@end

@implementation StartMovieViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"qidong" ofType:@"mp4"]];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    //一直重复
    self.player.repeatMode = MPMovieRepeatModeOne;
    [self.view addSubview:self.player.view];
    [UIView animateWithDuration:3 animations:^{
        [self.player prepareToPlay];
    }];
    [self setupLoginView];
}

- (void)setupLoginView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0;
    [self.player.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [UIView animateWithDuration:3.0 animations:^{
        enterMainButton.alpha = 1.0;
    }];
}


- (void)enterMainAction:(UIButton *)btn {
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
    
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
