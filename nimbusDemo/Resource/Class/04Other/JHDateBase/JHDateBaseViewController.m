//
//  JHDateBaseViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHDateBaseViewController.h"
#import "JHSimpleDBModel.h"
#import "JHDateBaseSimpleUse.h"


@interface JHDateBaseViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong)UIView *rootView;

@end

@implementation JHDateBaseViewController


-(void)loadView
{
    self.rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 150, 150);
    [button setTitle:@"收藏" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTintColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rootView addSubview:button];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, button.bottom + 20, scaleWidthWith320(290), 120)];
    [_rootView addSubview:textView];
    _textViewBlock = ^(){
        
        textView.text = NSHomeDirectory();
        [textView sizeToFit];
        return textView.text;
    };
    
}


#pragma mark button点击事件（点击button实现收藏功能）
-(void)buttonDidClicked:(UIButton *)sender
{
    
    //创建model对象，给model里面的属性赋值
    JHSimpleDBModel *model = [[JHSimpleDBModel alloc] init];
    model.title = @"学生";
    model.name = @"逗逼";
    model.age = @"23";
    
    
    //打开数据库 ，创建表格
    [[JHDateBaseSimpleUse shareInstance] openDB];
    
    //根据title查询数据
    NSData *searchData = [[JHDateBaseSimpleUse shareInstance] searchDataFromTableWithTitle:model.title];
    
    //判断此数据是否存在
    if (searchData) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此活动已收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else {
        
        //对model实现归档(序列化，四种数据形式可以序列化)
        
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *achiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [achiver encodeObject:model forKey:@"model"];
        [achiver finishEncoding];
        
        //把model插入数据库
        [[JHDateBaseSimpleUse shareInstance] insertDataIntoTableWithUserTitle:model.title withUserData:data withMark:@"Read"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (_textViewBlock) {
            _textViewBlock();
            
        }
        
    }
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
