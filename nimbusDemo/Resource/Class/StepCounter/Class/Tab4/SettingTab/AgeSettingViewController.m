//
//  AgeSettingViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/9/30.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "AgeSettingViewController.h"
#import "ScrollChooseView.h"

@interface AgeSettingViewController ()<ScrollChooseViewDelegate>

@property(nonatomic,strong)ScrollChooseView *picker;
@property(nonatomic,strong)UILabel *ageLabel;
@property(nonatomic,strong)UILabel *unitLabel;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic) NSUInteger age;
@property(nonatomic) BOOL isFemale;

@end
#define kViewRatio (viewWidth()/320)
@implementation AgeSettingViewController

- (instancetype)initWithDefaultAge:(NSUInteger)defaultAge isFemale:(BOOL)isFemale
{
    self = [super init];
    if (self) {
        self.age = defaultAge;
        self.isFemale = isFemale;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat HeightRatio = IS_iPhone4?480./568.:1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSInteger defaultAge = (self.age>=10&&self.age<=99)?self.age:25;
    _picker = [[ScrollChooseView alloc] initWithFrame: CGRectMake(0, 260*kViewRatio*HeightRatio, viewWidth(), 40)
                                                start:10
                                                  end:99
                                             interval:1
                                         defaultIndex:defaultAge-10];
    _picker.chooseDelegate = self;
    _picker.hidden = NO;
    [self.view addSubview:_picker];
    
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unitLabel.font = [UIFont systemFontOfSize:17];
    _unitLabel.textColor = RGBCOLOR_HEX(0x8f8f8f);
    _unitLabel.text = @"岁";
    [_unitLabel sizeToFit];
    _unitLabel.centerX = self.view.width/2;
    _unitLabel.bottom = _picker.top - 20;
    [self.view addSubview:_unitLabel];
    
    
    _ageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ageLabel.font = [UIFont boldSystemFontOfSize:35];
    _ageLabel.textColor = RGBCOLOR_HEX(0xf6644d);
    _ageLabel.bottom = _unitLabel.top - 2;
    
    [self.view addSubview:_ageLabel];
    if (self.age>0) {
        [self updateAgeLabel:self.age];
    }
    [self setupButtons];
    
    NSString *imageName = self.isFemale ? @"weight_setting_image_female.png": @"weight_setting_image_male.png";
    _imageView = [UIImageView imageViewWithImageName:imageName];
    _imageView.width /= 2;
    _imageView.height /= 2;
    _imageView.center = CGPointMake(self.view.width / 2, self.ageLabel.top - 90*HeightRatio*HeightRatio);
    [self.view addSubview:_imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)setupButtons{
    _cancelButton = [[UIButton alloc] init];
    _nextButton = [[UIButton alloc] init];
    
    _cancelButton.size = CGSizeMake(90, 40);
    _nextButton.size = CGSizeMake(90, 40);
    
    _cancelButton.right = viewWidth()/2 - 30;
    _nextButton.left = viewWidth()/2 + 30;
    
    _cancelButton.layer.cornerRadius = 2;
    _nextButton.layer.cornerRadius = 2;
    
    _cancelButton.bottom = self.view.height - 45;
    _nextButton.bottom = self.view.height - 45;
    
    [_cancelButton setTitle:@"上一步" forState:UIControlStateNormal];
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    _cancelButton.backgroundColor = RGBCOLOR_HEX(0xe9e9e9);
    _nextButton.backgroundColor = RGBCOLOR_HEX(0xf6644d);
    
    [_cancelButton setTitleColor:RGBCOLOR_HEX(0xb0b0b0) forState:UIControlStateNormal];
    
    [_cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton addTarget:self action:@selector(nextButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cancelButton];
    [self.view addSubview:_nextButton];
}

-(void)updateAgeLabel:(NSInteger)age{
    NSString *string = [NSString stringWithFormat:@"%zi",age];
    self.ageLabel.text = string;
    [self.ageLabel sizeToFit];
    self.ageLabel.centerX = self.view.width/2;
    self.ageLabel.bottom = self.unitLabel.top - 2;
}

- (void)cancelButtonTapped
{
    
}

- (void)nextButtonTapped
{
    
}
#pragma mark delegate
-(void)ScrollChooseView:(ScrollChooseView *)chooseView didChangedToValue:(NSInteger)value{
    if ((NSInteger)value!=_age) {
        _age = (NSInteger)value;
        [self updateAgeLabel:_age];
    }
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
