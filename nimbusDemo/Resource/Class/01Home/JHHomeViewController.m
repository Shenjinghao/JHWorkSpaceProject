//
//  JHHomeViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHTabBarController.h"
#import "JHMoveSingleView.h"
#import "JHMoveModel.h"
#import "JHMoveDetailViewController.h"
//weakself
#import "RACEXTScope.h"

@interface JHHomeViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *singleTag;

@property (nonatomic, strong) NSMutableArray *singleArray;

@property (nonatomic)BOOL isMove;
@property (nonatomic)CGPoint rects;

@property (nonatomic, strong) JHMoveSingleView *singleView;

@property (nonatomic) CGFloat marginWidth;

@end

@implementation JHHomeViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
        self.hidesBackButton = YES;
        _titleArray = [NSArray array];
        _singleTag = [NSArray array];
        _singleArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    JHTabBarController *VC = (JHTabBarController *)self.tabBarController;
    [VC setBadgeNumberAtIndex:0 value:33];
    
    //moveview正方形
    self.marginWidth = [UIScreen mainScreen].bounds.size.width / 5;
    
    [self createViews];
}

- (void)createViews
{
    JHMoveModel *model = [[JHMoveModel alloc] init];
    self.titleArray = model.titleArray;
    self.singleTag = model.singleTag;
    
    CGFloat width, height;
    width = 0;
    height = 5;
    
    for (NSInteger i = 0; i < self.titleArray.count; i ++) {
        NSString *title = self.titleArray[i][@"title"];
        JHMoveSingleView *singleView = [[JHMoveSingleView alloc] initWithFrame:CGRectMake(width, height, self.marginWidth - 1, self.marginWidth - 1) title:title];
        [self.view addSubview:singleView];
        
        width += self.marginWidth;
        if (width == self.view.width) {
            width = 0;
            height += self.marginWidth;
        }
        singleView.tagid = self.singleTag[i];
        singleView.viewPoint = singleView.center;
        [self.singleArray addObject:singleView];
        [self handleTheMoveAndClickActionWithTheSingleView:singleView];
    }
}

- (void)handleTheMoveAndClickActionWithTheSingleView:(JHMoveSingleView *)singleView
{
    @weakify(self);
    //点击
    singleView.clickOneViewTeturnTitleBlock = ^(NSString *title){
        @strongify(self);
        JHMoveDetailViewController *controller = [[JHMoveDetailViewController alloc] initWithQuery:@{@"title":ENSURE_NOT_NULL(title)}];
        [self.navigationController pushViewController:controller animated:YES];
    };
    //移动前
    singleView.beginMoveActionBlock = ^(NSString *tag){
        @strongify(self);
        for (NSInteger i = 0; i < self.titleArray.count; i ++) {
            self.singleView = self.singleArray[i];
            if (self.singleView.tagid == tag) {
                break;
            }
        }
        [self.view bringSubviewToFront:self.singleView];
        self.rects = self.singleView.viewPoint;
        //(缩放:设置缩放比例）仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
        self.singleView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    };
    //移动中
    singleView.moveViewActionBlock = ^(NSString *tag, UIGestureRecognizer *gesture){
        @strongify(self);
        //移动前的tag
        NSInteger fromTag = [self.singleView.tagid integerValue];
        //移动后的新坐标
        CGPoint newPoint = [gesture locationInView:self.view];
        //移动后的X坐标
        CGFloat moveX = newPoint.x - self.singleView.frame.origin.x;
        //移动后的Y坐标
        CGFloat moveY = newPoint.y - self.singleView.frame.origin.y;
        //跟随手势移动
        self.singleView.center = CGPointMake(self.singleView.origin.x + moveX - self.marginWidth / 2, self.singleView.origin.y + moveY - self.marginWidth / 2);
        //移动后的目标tag - 100
        NSInteger toIndex = [self indexOfPoint:self.singleView.center withUiview:self.singleView singleArray:self.singleArray];
        //往前移动
        if (toIndex < fromTag - 100 && toIndex > 0) {
            _isMove = YES;
            NSInteger fromIndex = fromTag - 100;
            JHMoveSingleView *toView = self.singleArray[toIndex];
            self.singleView.center = toView.viewPoint;
            self.rects = toView.viewPoint;
            for (NSInteger j = fromIndex; j > toIndex; j --) {
                JHMoveSingleView *view1 = self.singleArray[j];
                JHMoveSingleView *view2 = self.singleArray[j - 1];
                [UIView animateWithDuration:0.5 animations:^{
                    view2.center = view1.viewPoint;
                }];
            }
            [_singleArray removeObject:_singleView];
            [_singleArray insertObject:_singleView atIndex:toIndex];
            [self manageTagAndCenter];
        }
        //往后移动
        if (toIndex > fromTag - 100 && toIndex < _singleArray.count) {
            _isMove = YES;
            NSInteger fromIndex = fromTag - 100;
            JHMoveSingleView *toView = self.singleArray[toIndex];
            self.singleView.center = toView.viewPoint;
            self.rects = toView.viewPoint;
            for (NSInteger j = fromIndex; j < toIndex; j ++) {
                JHMoveSingleView *view1 = self.singleArray[j];
                JHMoveSingleView *view2 = self.singleArray[j + 1];
                [UIView animateWithDuration:0.5 animations:^{
                    view2.center = view1.viewPoint;
                }];
            }
            [_singleArray removeObject:_singleView];
            [_singleArray insertObject:_singleView atIndex:toIndex];
            [self manageTagAndCenter];
        }
        
        
    };
    //移动后
    singleView.endMoveViewActionBlock = ^(NSString *tag){
        @strongify(self);
        self.singleView.center = self.rects;
        //还原
        self.singleView.transform = CGAffineTransformIdentity;
    };
}

#pragma mark 获取目标tag
- (NSInteger)indexOfPoint:(CGPoint)point
               withUiview:(UIView *)view singleArray:(NSMutableArray *)singleArray
{
    
    for (NSInteger i = 0; i < self.singleArray.count; i ++) {
        UIView *moveView = self.singleArray[i];
        if (view != moveView) {
            if (CGRectContainsPoint(moveView.frame, point)) {
                return i;
            }
        }
    }
    return -100;
}
#pragma mark 处理tag center
- (void) manageTagAndCenter
{
    for (NSInteger i = 0; i < _singleArray.count; i ++) {
        
        JHMoveSingleView *view = _singleArray[i];
        view.viewPoint = view.center;
        view.tagid = _singleTag[i];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBackButton = YES;
}

- (NSString *)tabTitle {
    return @"首页";
}

- (NSString *)tabImageName {
    return @"tabbar_home_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_home";
}


@end
