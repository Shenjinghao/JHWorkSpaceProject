//
//  JHTabBarController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHTabBarController.h"
#import "UIViewController+JHCategory.h"

@implementation JHTabBarController
{
    NSMutableArray *_badgeViewList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // tintColor的作用在ios7的时候改变了。ios7及以后作为selectedColor，7以前作为bar的backGroundColor
    if ([JHUtility JHOveriOS:7]) {
        /**
         *  tabbar的颜色半透明度
         */
        self.tabBar.translucent = NO;
        self.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBar.tintColor = RGBCOLOR_HEX(0x4dd363);
    }else{
        /**
         *  // ios6默认的背景上面有一条黑色线，需要重新设置一个背景、
         */
        [self.tabBar setBackgroundImage:[UIImage load:@""]];
        UIView* topLine = [UIView viewWithFrame:CGRectMake(0, 0, viewWidth(), 0.5) andBackgroundColor:RGBCOLOR_HEX(0xdddddd)];
        [self.tabBar addSubview: topLine];
    }
    
    if([JHUtility JHOveriOS:6]) {
        [self.tabBar setShadowImage: [[UIImage alloc] init]];
    }
    // 去掉选中后的背景图片
    [self.tabBar setSelectionIndicatorImage: [[UIImage alloc] init]];
    
    // 自定义custombar
    //    UIImage *backgroundImage = [UIImage imageWithColor:RGBCOLOR_HEX(0xf9f9f9) andSize:self.tabBar.size];
    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor whiteColor] andSize:self.tabBar.size];
    [self.tabBar setBackgroundImage:backgroundImage];
    UIImageView* topBoardLine = [JHLineSeparator lineWithColor:RGBCOLOR_HEX(0xdddddd) width:viewWidth() height:0.5];
    [self.tabBar addSubview:topBoardLine];
    
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    for (JHViewController *VC in viewControllers) {
        UITabBarItem *tabbarItem;
        if ([JHUtility JHOveriOS:7]) {
            /**
             *  设置UIImage的渲染模式：UIImage.renderingMode,UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
             */
            UIImage *image = [UIImage load:[VC tabImageName]];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *selectedImage = [UIImage load:[VC tabImageNameSel]];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabbarItem = [[UITabBarItem alloc] initWithTitle:[VC tabTitle] image:image selectedImage:selectedImage];
            
        }else{
            tabbarItem = [[UITabBarItem alloc] initWithTitle:[VC tabTitle] image:[UIImage load:[VC tabImageName]] selectedImage:[UIImage load:[VC tabImageNameSel]]];
            [tabbarItem setFinishedSelectedImage:[UIImage load:[VC tabImageNameSel]] withFinishedUnselectedImage:[UIImage load:[VC tabImageName]]];
        }
        [tabbarItem setTitle: [VC tabTitle]];
        
        [tabbarItem setTitleTextAttributes: @{
                                              UITextAttributeTextColor : COLOR_A1,
                                              } forState: UIControlStateSelected];
        
        [tabbarItem setTitleTextAttributes: @{
                                              UITextAttributeTextColor : RGBCOLOR_HEX(0x333333),
                                              } forState: UIControlStateNormal];
        VC.tabBarItem = tabbarItem;
        
    }
    
    // 自定义badgeView
    // 系统默认的badgeView样式不合适
    _badgeViewList = [NSMutableArray array];
    for (NSInteger i = 0; i < viewControllers.count; ++i) {
        
        CGFloat itemWidth = viewWidth() / viewControllers.count;
        CGFloat midPoint = (i + 1 - 0.5) * itemWidth;
        
        CGFloat offset = midPoint - 3;
        TabBadgeView* badgeView = [[TabBadgeView alloc] initWithFrame:CGRectMake(offset, 2, 20, 20)];
        
        badgeView.hidden = YES;
        
        [self.tabBar addSubview: badgeView];
        
        [_badgeViewList addObject: badgeView];
    }
    
    [super setViewControllers:viewControllers];
    
    // 应用启动默认跳到一个没有网络请求的tab，防止后台访问接口，影响统计
    // kTabIndexWithoutNetwork是定义在docconfig中的，现在在nimbus中，减少耦合带来的问题
    NSInteger tabIndex = 0;
    [self setSelectedIndex: tabIndex];
    
}

- (void) setBadgeNumberAtIndex:(NSInteger)index value:(NSInteger) value{
    NIDPRINTMETHODNAME();
    
    if(index < _badgeViewList.count) {
        TabBadgeView* badgeView = _badgeViewList[index];
        
        [badgeView setTitle: [NSString stringWithFormat: @"%zi", value]
                   forState: UIControlStateNormal];
        [badgeView.titleLabel setTextAlignment:NSTextAlignmentCenter];
        badgeView.hidden = value <= 0;
        
        [badgeView.superview bringSubviewToFront:badgeView];
        
    } else {
        
        // 超过tab的count
        NIDASSERT(NO);
    }
}

@end

@implementation TabBadgeView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: CGRectMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame), 20, 20)];
    if (self) {
        [self setBackgroundImage:[UIImage load:@"home_tabbar_badge"] forState:UIControlStateNormal];
        self.layer.cornerRadius = 9.0f;
        [self setTitleColor: [UIColor whiteColor]
                   forState: UIControlStateNormal];
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}

- (void) setIsLarge:(BOOL)isLarge {
    if (isLarge!=_isLarge) {
        _isLarge = isLarge;
        self.width = _isLarge ? 25 : 20;
    }
}


@end






