//
//  PersonDoctorSevicePriceView.h
//  ChunyuClinic
//
//  Created by Shenjinghao on 16/3/22.
//  Copyright © 2016年 lvjianxiong. All rights reserved.
//


/**
 *  私人医生的周期及价格控件
 */
#import "JHPopWindowView.h"

@interface PersonDoctorSeviceListPriceView : JHPopWindowView

@end

@interface PersonDoctorPriceInputTextField: UIView <UITextFieldDelegate>
@property (nonatomic, strong) UITextField* priceField;
- (void) bindUnit:(NSString *)unit;
@end
