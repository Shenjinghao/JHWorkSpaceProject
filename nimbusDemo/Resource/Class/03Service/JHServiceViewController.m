//
//  JHServiceViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHServiceViewController.h"
#import "JHTableViewListModel.h"
#import "JHTableViewListCell.h"
#import "JHAnotherListCell.h"

@interface JHServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_selectedArr;//二级列表是否展开状态
}

@property (nonatomic, strong) UITableView *ownTableView;

@property (nonatomic, strong) JHTableViewListModel *model;

@end

@implementation JHServiceViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
        
        _selectedArr = [NSMutableArray array];
        _model = [[JHTableViewListModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"服务";
    self.view.backgroundColor = COLOR_A9;
    
    self.hidesBackButton = YES;
    
    _ownTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), self.view.height) style:UITableViewStylePlain];
    _ownTableView.delegate = self;
    _ownTableView.dataSource = self;
    _ownTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_ownTableView];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.titleDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    if ([_selectedArr containsObject:key]) {
        NSArray *array = _model.dataDict[key];
        return array.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 50)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = section;
    
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    NSArray *dataArray = _model.dataDict[key];
    
    UILabel *titleLabel = [UILabel labelWithFontSize:15 fontColor:COLOR_A3 text:_model.titleDataArray[section]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.frame = CGRectMake(40, 0, viewWidth()-85, 49.5);
    [view addSubview:titleLabel];
    
    UILabel *countLabel = [UILabel labelWithFontSize:12 fontColor:COLOR_A5 text:[NSString stringWithFormat:@"%ld",(long)dataArray.count]];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.frame = CGRectMake(titleLabel.right, 0, 30, 49.5);
    [view addSubview:countLabel];
    
    UIImageView *line = [JHLineSeparator lineWithColor:COLOR_A7 width:0.5];
    line.frame = CGRectMake(0, countLabel.bottom, viewWidth(), 0.5);
    [view addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, viewWidth(), 50);
    button.tag = section;
    [button addTarget:self action:@selector(cellButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    NSString *string = [NSString stringWithFormat:@"%ld",button.tag];
    if ([_selectedArr containsObject:string]) {
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 9, 7)];
        arrowImageView.image = [UIImage load:@"arrow_left1"];
        [button addSubview:arrowImageView];
    }else{
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 6.5, 9)];
        arrowImageView.image = [UIImage load:@"arrow_right1"];
        arrowImageView.tag = 1;
        [button addSubview:arrowImageView];
    }
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    if ([_model.dataDict[indexStr][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        
        static NSString *CellIdentifier = @"MainCell";
        
        JHTableViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[JHTableViewListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if ([_selectedArr containsObject:indexStr]) {
            NSString *imageName = [NSString stringWithFormat:@"clinic_%02zi_icon.png",indexPath.row];
            cell.avatarImageView.image = [UIImage imageNamed:imageName];
            cell.nicknameLabel.text = _model.dataDict[indexStr][indexPath.row][@"name"];
        }
        return cell;
    }else if ([_model.dataDict[indexStr][indexPath.row][@"cell"] isEqualToString:@"AnotherCell"]){
        static NSString *CellIdentifier = @"AnotherCell";
        
        JHAnotherListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[JHAnotherListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    
    NSIndexPath *path = nil;
    
    if ([_model.dataDict[indexStr][indexPath.row][@"cell"] isEqualToString:@"MainCell"]) {
        
        path = [NSIndexPath indexPathForItem:(indexPath.row + 1) inSection:indexPath.section];
    }
    else
    {
        path = indexPath;
    }
    
    
    if ([_model.dataDict[indexStr][indexPath.row][@"state"]boolValue]) {
        //可以合并
        NSString *name = _model.dataDict[indexStr][indexPath.row][@"name"];
        
        NSMutableDictionary *nameAndStateDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",name,@"name",@"NO",@"state",nil];
        
        switch (indexPath.section) {
            case 0:
            {
                _model.grouparr0[(path.row-1)] = nameAndStateDic;
                [_model.grouparr0 removeObjectAtIndex:path.row];
            }
                break;
            case 1:
            {
                _model.grouparr1[(path.row-1)] = nameAndStateDic;
                [_model.grouparr1 removeObjectAtIndex:path.row];
            }
                break;
            case 2:
            {
                _model.grouparr2[(path.row-1)] = nameAndStateDic;
                [_model.grouparr2 removeObjectAtIndex:path.row];
            }
                break;
            case 3:
            {
                _model.grouparr3[(path.row-1)] = nameAndStateDic;
                [_model.grouparr3 removeObjectAtIndex:path.row];
            }
                break;
            case 4:
            {
                _model.grouparr4[(path.row-1)] = nameAndStateDic;
                [_model.grouparr4 removeObjectAtIndex:path.row];
            }
                break;
            case 5:
            {
                _model.grouparr5[(path.row-1)] = nameAndStateDic;
                [_model.grouparr5 removeObjectAtIndex:path.row];
            }
                break;
                
            default:
                break;
        }

        
    }else{
        NSString *name = _model.dataDict[indexStr][indexPath.row][@"name"];
        
        NSMutableDictionary *nameAndStateDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"MainCell",@"cell",name,@"name",@"NO",@"state",nil];
        switch (indexPath.section) {
            case 0:
            {
                _model.grouparr0[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr0 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
            case 1:
            {
                _model.grouparr1[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr1 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
            case 2:
            {
                _model.grouparr2[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr2 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
            case 3:
            {
                _model.grouparr3[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr3 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
            case 4:
            {
                _model.grouparr4[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr4 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
            case 5:
            {
                _model.grouparr5[(path.row-1)] = nameAndStateDic;
                NSMutableDictionary *nameAndStateDic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"AnotherCell",@"cell",@"YES",@"state",nil];
                [_model.grouparr5 insertObject:nameAndStateDic1 atIndex:path.row];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    
}

- (void)cellButtonDidClicked:(UIButton *)sender
{
//    sender.tag = section
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([_selectedArr containsObject:string])
    {
        [_selectedArr removeObject:string];
    }
    else
    {
        [_selectedArr addObject:string];
    }

    [_ownTableView reloadData];
    
}

- (NSString *)tabTitle {
    return @"服务";
}

- (NSString *)tabImageName {
    return @"tabbar_service_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_service";
}

@end
