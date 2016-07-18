//
//  PersonDoctorSevicePriceView.m
//  ChunyuClinic
//
//  Created by Shenjinghao on 16/3/22.
//  Copyright © 2016年 lvjianxiong. All rights reserved.
//

#import "PersonDoctorSeviceListPriceView.h"
#import "JHFilledColorButton.h"

@implementation PersonDoctorSeviceListPriceView
{
    UIScrollView* _scrollView;
    PersonDoctorPriceInputTextField* _weekField;
    PersonDoctorPriceInputTextField* _monthField;
    PersonDoctorPriceInputTextField* _quarterField;
    PersonDoctorPriceInputTextField* _month6Field;
    PersonDoctorPriceInputTextField* _yearField;
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        // title
        UILabel* titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) fontSize:16 fontColor:COLOR_A3 text:@"自定义价格"];
        titleLabel.text = @"自定义价格";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = COLOR_A8;
        [self addSubview:titleLabel];
        
        // 在scrollview上加载5个输入框
        [self setUp];
        
        // 分割线
        UIView* dividingLine = [UIView separateLineWithFrame:CGRectMake(0, _scrollView.bottom + 10, self.width, 1) backGroundColor:COLOR_A9];
        [self addSubview:dividingLine];
        
        JHFilledColorButton* cancleBtn = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(0, dividingLine.top + 1, self.width / 2, 40) color:RGBCOLOR_HEX(0xfefefe) highlightedColor:COLOR_A8 textColor:COLOR_A4 title:@"取消" fontSize:16 isBold:NO];
        [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancleBtn];
        
        JHFilledColorButton* sureBtn = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(self.width / 2, cancleBtn.top, self.width / 2, 40) color:RGBCOLOR_HEX(0xfefefe) highlightedColor:COLOR_A8 textColor:COLOR_A1 title:@"确认" fontSize:16 isBold:NO];
        [sureBtn addTarget:self action:@selector(onSureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
//         小竖线分割
        UIView* verticalLine = [UIView separateLineWithFrame:CGRectMake(self.width / 2, dividingLine.top, 1, 40) backGroundColor:COLOR_A9];
        [self addSubview:verticalLine];
        
        self.height = sureBtn.bottom;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        self.tapBackgroundToDismiss = NO;

//        self.yOffsetWhenPresented = 150;
    }
    return self;
}

- (void) setUp{
    // 这里_scrollview的高度可以手动改变. 其他控件代码不用改变 会自己layout
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width - 20, 125)];
    [self addSubview:_scrollView];
    
    _weekField = [[PersonDoctorPriceInputTextField alloc] initWithFrame:CGRectMake(10, 0, _scrollView.frame.size.width - 20, 40)];
    [_weekField bindUnit:@"元/周"];
    [_scrollView addSubview:_weekField];
    
    _monthField = [[PersonDoctorPriceInputTextField alloc] initWithFrame:CGRectMake(10, _weekField.frame.origin.y + _weekField.frame.size.height + 10, _scrollView.frame.size.width - 20, 40)];
    [_monthField bindUnit:@"元/月"];
    [_scrollView addSubview:_monthField];
    
    _quarterField = [[PersonDoctorPriceInputTextField alloc] initWithFrame:CGRectMake(10, _monthField.frame.origin.y + _monthField.frame.size.height + 10, _scrollView.frame.size.width - 20, 40)];
    [_quarterField bindUnit:@"元/季"];
    [_scrollView addSubview:_quarterField];
    
    _month6Field = [[PersonDoctorPriceInputTextField alloc] initWithFrame:CGRectMake(10, _quarterField.frame.origin.y + _quarterField.frame.size.height + 10, _scrollView.frame.size.width - 20, 40)];
    [_month6Field bindUnit:@"元/半年"];
    [_scrollView addSubview:_month6Field];
    
    _yearField = [[PersonDoctorPriceInputTextField alloc] initWithFrame:CGRectMake(10, _month6Field.frame.origin.y + _month6Field.frame.size.height + 10, _scrollView.frame.size.width - 20, 40)];
    [_yearField bindUnit:@"元/年"];
    [_scrollView addSubview:_yearField];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _yearField.frame.origin.y + _yearField.frame.size.height + 10);
}

/**
 *  点击确认
 */
- (void) onSureBtnClicked{
    //至少填写一项
    if (!([_weekField.priceField.text isNotEmpty] || [_monthField.priceField.text isNotEmpty] || [_quarterField.priceField.text isNotEmpty] || [_month6Field.priceField.text isNotEmpty] || [_yearField.priceField.text isNotEmpty])){
        [SVProgressHUD showErrorWithStatus:@"请填写价格设置(周/月/季度/半年/年)"];
        return;
    }
    NSArray *array = @[_weekField.priceField.text,_monthField.priceField.text,_quarterField.priceField.text,_month6Field.priceField.text,_yearField.priceField.text];
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i < array.count; i ++) {
        if (![array[i] isNotEmpty]) {
            [mutableArray removeObject:array[i]];
        }
    }
    NSMutableArray *lastArray = [mutableArray copy];
    for (NSInteger i = 0; i < lastArray.count; i ++) {
        for (NSInteger j = 0; j < lastArray.count - i - 1; j ++) {
            if (lastArray[j] >= lastArray[j + 1]) {
                [SVProgressHUD showErrorWithStatus:@"不能低于更短周期的价格"];
                return;
            }
        }
    }
    NSDictionary* dict = @{ @"week" : @([_weekField.priceField.text integerValue]),
                            @"month" : @([_monthField.priceField.text integerValue]),
                            @"quarter" : @([_quarterField.priceField.text integerValue]),
                            @"month6" : @([_month6Field.priceField.text integerValue]),
                            @"year" : @([_yearField.priceField.text integerValue]),
                            };
    [self dismissWithResult:dict];
}
@end


/**
 *  一个带边框 和 输入框 单位的 控件
 */
@implementation PersonDoctorPriceInputTextField{
    UILabel* _unitLabel;			// 单位label
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = COLOR_A9.CGColor;
        
        _unitLabel = [UILabel labelWithFontSize:16 fontColor:COLOR_A5 text:@""];
        [self addSubview:_unitLabel];
        
        _priceField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, self.height)];
        _priceField.keyboardType = UIKeyboardTypeNumberPad;
        _priceField.delegate = self;
        [self addSubview:_priceField];
    }
    return self;
}

- (void) bindUnit:(NSString *)unit{
    _unitLabel.text = unit;
    [_unitLabel sizeToFit];
    _unitLabel.centerY = self.height / 2;
    _unitLabel.right = self.width - 15;
}

#pragma - mark UITextFieldDelegate
// 设置价格不能低于1元，大于9999元
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //颜色的高亮改变
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _unitLabel.textColor = [result isNotEmpty] ? COLOR_A3 : COLOR_A5;
    
//    if (string.length>0 && textField.text.length >= 4) {
//        
//        if (![textField.text isEqualToString: @"9999"]) {
//            [SVProgressHUD showErrorWithStatus: @"价格不能超过9999元"];
//        }
//        
//        textField.text = @"9999";
//        return NO;
//    }
//    if ([string isEqualToString:@"0"] && [textField.text isEqualToString:@""]) {
//        [SVProgressHUD showErrorWithStatus: @"价格不能低于1元"];
//        
//        textField.text = @"1";
//        return NO;
//    }
    //只允许输入数字
    NSCharacterSet *numSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filterStr = [[string componentsSeparatedByCharactersInSet:numSet] componentsJoinedByString:@""];
    if (![string isEqualToString:filterStr]) {
        [SVProgressHUD showErrorWithStatus:@"请输入数字"];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![textField.text isNotEmpty]) {
        _unitLabel.textColor = COLOR_A5;
    }
}

@end
