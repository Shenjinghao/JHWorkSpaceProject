//
//  JHRACKittenViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 16/1/12.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHViewController.h"

//block
typedef void (^KittenBlock)(BOOL success);


@interface JHRACKittenViewController : JHViewController

- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(KittenBlock)completeBlock;

@end
