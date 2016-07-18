//
//  JHNavigationBarVC1.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/14.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHNavigationBarVC1.h"
#import "UINavigationBar+JHDynamicChangeNavigationBar.h"

#define NAVBAR_CHANGE_POINT 50

@interface JHNavigationBarVC1 ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JHNavigationBarVC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"动态修改UINavigationBar的背景色";
    self.view.backgroundColor = [UIColor clearColor];
    
    //将tableview顶到状态栏下面，（掩盖掉导航栏）
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, viewWidth(), self.view.height + 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    UIImageView *view = [UIImageView imageViewWithImageName:@"navi_bar.jpg" andFrame:CGRectMake(0, 0, viewWidth(), 220)];
    self.tableView.tableHeaderView = [UIView viewWithFrame:CGRectMake(0, 0, viewWidth(), 220) andBackgroundColor:[UIColor clearColor]];
    [self.tableView.tableHeaderView addSubview:view];
    
    
    [self.navigationController.navigationBar jh_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar jh_reset];
}

#pragma mark scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar jh_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar jh_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }

}


#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


@end
