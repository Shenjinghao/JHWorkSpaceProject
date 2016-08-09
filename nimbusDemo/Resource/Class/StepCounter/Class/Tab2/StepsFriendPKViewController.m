//
//  StepsFriendPKViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "StepsFriendPKViewController.h"
#import "JHStackablePage.h"
#import "JHInvitationCard.h"

@interface StepsFriendPKViewController ()<StackedViewDelegate>

@property (nonatomic, strong) StackedView *stackedPageView;

@property (nonatomic, strong) JHInvitationCard *invitationCard;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) UILabel *activityLabel;

@end

@implementation StepsFriendPKViewController

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        self.needScrollView = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.stackedPageView];
}

// 创建卡片列表界面
- (StackedView *)stackedPageView {
    if (_stackedPageView == nil) {
        _stackedPageView = [[StackedView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), [UIScreen mainScreen].bounds.size.height - 64)];
        _stackedPageView.topMargin = 12;
        _stackedPageView.backgroundColor = [UIColor blueColor];
        _stackedPageView.delegate = self;
        _stackedPageView.disableScrollWhenSelected = YES;
        _stackedPageView.showScrollIndicator = YES;
        
        // 选中的卡片，与其他卡片间的距离
        if (IS_iPhone4) {
            _stackedPageView.spaceBetweenExpanedPageAndPackedPages = 23;
        }
        else {
            _stackedPageView.spaceBetweenExpanedPageAndPackedPages = 45;
        }
    }
    return _stackedPageView;
}

#pragma mark - StackedViewDelegate
// 创建一个卡片
- (UIView *)stackView:(StackedView *)stackView pageForIndex:(NSInteger)index {

    return [self preContestPageForIndex:index];
    
}

- (UIView *)contestPageForIndex:(NSInteger)index {
    NIDASSERT(index >= 0);
    if (index == 0) {
        return self.invitationCard;
    }
    else if (index == 1) {
        return self.invitationCard;
    }
    else {
        index -= 2;
        JHInvitationCard *page = (JHInvitationCard *)[self.stackedPageView dequeueReusablePage];
        if (page == nil) {
            CGFloat height = [self expandedHeightForPageAtIndex:index];
            page = [[JHInvitationCard alloc] initWithFrame:CGRectMake(25, 0, viewWidth() - 50, height)];
        }
        
        return page;
    }
}

- (UIView *)preContestPageForIndex:(NSInteger)index {
    if (index == 0) {
        return self.invitationCard;
    }
    else if (index == 1) {
        return self.invitationCard;
    }
    else {
        NIDASSERT(NO);
        return nil;
    }
}

- (JHInvitationCard *)invitationCard {
    if (_invitationCard == nil) {
        CGFloat height = [self expandedHeightForPageAtIndex:0];
        _invitationCard = [[JHInvitationCard alloc] initWithFrame:CGRectMake(25, 0, viewWidth() - 50, height)];
        WEAK_VAR(self);
        [_invitationCard setActionBlock:^(CardActionType actionType) {

            
            
        }];
    }
    return _invitationCard;
}

// 卡片数
- (NSInteger)numberOfPagesForStackView:(StackedView *)stackView {
    return 3;
}

// 收缩时的高度
- (CGFloat)stackedHeightForPageAtIndex:(NSInteger)index {
    return 50 * kPageHeightRatio;
}

// 展开时的高度
- (CGFloat)expandedHeightForPageAtIndex:(NSInteger)index {
    return kStepsPKPageHeight;
}

// header
- (UIView *)headerViewForStackedView:(StackedView *)stackedView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    
    UILabel *label = [UILabel labelWithFontSize:14 fontColor:[UIColor grayColor] text:@""];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = headerView.bounds;
    [headerView addSubview:label];
    
    self.activityLabel = label;
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityView.centerY = headerView.height / 2;
    activityView.right = 120;
    
    [headerView addSubview:activityView];
    
    self.activityIndicatorView = activityView;
    
    return headerView;
}


@end
