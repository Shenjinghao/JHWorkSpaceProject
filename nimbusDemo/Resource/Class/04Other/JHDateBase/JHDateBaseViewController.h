//
//  JHDateBaseViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 16/5/23.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"

typedef NSString *(^updateTheTextView)(void);

@interface JHDateBaseViewController : JHViewController
@property (nonatomic, copy) updateTheTextView textViewBlock;

@end
