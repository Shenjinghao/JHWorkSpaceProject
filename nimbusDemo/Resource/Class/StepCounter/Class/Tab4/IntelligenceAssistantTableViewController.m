//
//  IntelligenceAssistantTableViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "IntelligenceAssistantTableViewController.h"
#import "StepSettingItem.h"
#import "AgeSettingViewController.h"

@implementation IntelligenceAssistantTableViewController
{
    StepSettingItem *_settingItem;
}

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithQuery:nil];
    });
    return instance;
}

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
//    [self createModel];
    [self creatViews];
}

- (void) creatViews
{
    CGFloat offSet = 0;
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, viewWidth(), 43) fontSize:16 text:[NSString stringWithFormat:@"测试%ld",i]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, offSet, viewWidth(), 43)];
        [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
        [button addSubview:label];
        offSet += 43;
    }
}

- (void) buttonDidClicked:(UIButton *)button
{
    if (button.tag == 0) {
        AgeSettingViewController *VC = [[AgeSettingViewController alloc] initWithDefaultAge:66 isFemale:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1) {
        
    }else if (button.tag == 2) {
        
    }
}

- (void)createModel
{
    [self creatTableItems];
    NSArray *array = @[_settingItem, _settingItem, _settingItem, _settingItem];
    self.tableViewModel = [[JHTableViewModel alloc] initWithListArray:array delegate:self.cellFactory];
}

- (void) creatTableItems
{
    _settingItem = [[StepSettingItem alloc] initWithAttributes:@{@"title":@"测试"}];
}


@end
