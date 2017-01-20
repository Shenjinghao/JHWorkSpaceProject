//
//  JHMoveDetailViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 2017/1/18.
//  Copyright © 2017年 Shenjinghao. All rights reserved.
//

#import "JHMoveDetailViewController.h"

@interface JHMoveDetailViewController ()

@end

@implementation JHMoveDetailViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        self.title = query[@"title"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
