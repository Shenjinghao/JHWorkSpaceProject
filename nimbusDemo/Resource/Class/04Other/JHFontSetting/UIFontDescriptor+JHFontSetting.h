//
//  UIFontDescriptor+JHFontSetting.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/8.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFontDescriptor (JHFontSetting)


+ (UIFontDescriptor *)preferredJHAvenirNextWithFontDescriptorSymbolicTrait:(UIFontDescriptorSymbolicTraits)trait descriptorWithTextStyle:(NSString *)style contentSizeStr:(NSString*)contentSizeStr;

+ (UIFontDescriptor *)preferredJHAvenirNextBoldFontDescriptorWithTextStyle:(NSString *)style contentSizeStr:(NSString*)contentSizeStr;

+ (UIFontDescriptor *)preferredJHAvenirNextFontDescriptorWithTextStyle:(NSString *)style contentSizeStr:(NSString*)contentSizeStr;



@end
