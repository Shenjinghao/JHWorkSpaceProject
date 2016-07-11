//
//  JHFontSettingViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/8.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHFontSettingViewController.h"
#import "JHFontSettingArrowView.h"
#import "JHFontManager.h"

@interface JHFontSettingViewController ()

@property (nonatomic, strong) UIButton* smallbutton;
@property (nonatomic, strong) UIButton* largeButton;

@end

@implementation JHFontSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"字体";
    
    [self createView];
}

- (void)createView
{
    self.tableView.top = 30;
    self.tableView.scrollEnabled = NO;
    
    UIView* settingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 120)];
    [settingView setBackgroundColor:[UIColor whiteColor]];
    settingView.bottom = self.view.height;
    [self.view addSubview:settingView];
    
    JHFontSettingArrowView* arrowView = [[JHFontSettingArrowView alloc] initWithFrame:CGRectMake(0, 0, 62, 33)];
    [arrowView setBackgroundColor:[UIColor whiteColor]];
    arrowView.left = (viewWidth() - arrowView.width) / 2;
    arrowView.top = 40;
    [settingView addSubview:arrowView];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;//行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString* smallHStr = [[NSMutableAttributedString alloc] initWithString:@"A\n正常字体"];
    [smallHStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:RGBCOLOR_HEX(0x1C91E0), NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, 1)];
    [smallHStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:RGBCOLOR_HEX(0x1C91E0)} range:NSMakeRange(1, smallHStr.string.length - 1)];
    
    NSMutableAttributedString* smallNStr = [[NSMutableAttributedString alloc] initWithString:@"A\n正常字体"];
    [smallNStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:COLOR_A5, NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, 1)];
    [smallNStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:COLOR_A5} range:NSMakeRange(1, smallNStr.string.length - 1)];
    
    _smallbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_smallbutton setAttributedTitle:smallHStr forState:UIControlStateSelected];
    [_smallbutton setAttributedTitle:smallNStr forState:UIControlStateNormal];
    [_smallbutton setFrame:CGRectMake(0, 30, 100, 100)];
    [_smallbutton.titleLabel setNumberOfLines:0];
    [_smallbutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_smallbutton addTarget:self action:@selector(fontButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_smallbutton sizeToFit];
    _smallbutton.right = arrowView.left - 15;
    [settingView addSubview:_smallbutton];
    
    NSMutableParagraphStyle *largeParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    largeParagraphStyle.lineSpacing = 10;//行间距
    largeParagraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString* largeHStr = [[NSMutableAttributedString alloc] initWithString:@"A\n大字体"];
    [largeHStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0], NSForegroundColorAttributeName:RGBCOLOR_HEX(0x1C91E0), NSParagraphStyleAttributeName:largeParagraphStyle} range:NSMakeRange(0, 1)];
    [largeHStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:RGBCOLOR_HEX(0x1C91E0)} range:NSMakeRange(1, largeHStr.string.length - 1)];
    
    NSMutableAttributedString* largeNStr = [[NSMutableAttributedString alloc] initWithString:@"A\n大字体"];
    [largeNStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0], NSForegroundColorAttributeName:COLOR_A5, NSParagraphStyleAttributeName:largeParagraphStyle} range:NSMakeRange(0, 1)];
    [largeNStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:COLOR_A5} range:NSMakeRange(1, largeNStr.string.length - 1)];
    
    _largeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_largeButton setAttributedTitle:largeHStr forState:UIControlStateSelected];
    [_largeButton setAttributedTitle:largeNStr forState:UIControlStateNormal];
    [_largeButton setFrame:CGRectMake(100, 30, 100, 100)];
    [_largeButton.titleLabel setNumberOfLines:0];
    [_largeButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_largeButton addTarget:self action:@selector(fontButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_largeButton sizeToFit];
    _largeButton.left = arrowView.right + 15;
    _largeButton.bottom = _smallbutton.bottom;
    [settingView addSubview:_largeButton];
    
    if ([[JHFontManager sharedInstance].contentSizeStr isEqualToString:UIContentSizeCategoryExtraLarge]) {
        
        _smallbutton.selected = YES;
    }else {
        
        _largeButton.selected = YES;
    }
}

- (void)fontButtonClicked:(id)sender
{
    UIButton* button = sender;
    
    if (button == _smallbutton) {
        
        _smallbutton.selected = YES;
        _largeButton.selected = NO;
        [[JHFontManager sharedInstance] saveDynamicFontSizeToUserDefault:UIContentSizeCategoryExtraLarge];
    }else if (button == _largeButton){
        
        _smallbutton.selected = NO;
        _largeButton.selected = YES;
        [[JHFontManager sharedInstance] saveDynamicFontSizeToUserDefault:UIContentSizeCategoryAccessibilityExtraExtraLarge];
    }
    
    [self.tableView reloadData];
}

@end
