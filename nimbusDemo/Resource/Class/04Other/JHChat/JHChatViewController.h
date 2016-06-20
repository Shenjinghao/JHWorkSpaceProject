//
//  JHChatViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/2.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTableViewController.h"
#import "JHChatInputView.h"

@interface JHChatViewController : JHTableViewController

@property (nonatomic, strong) JHChatInputView* chatInputView;

@property (nonatomic) CGFloat keyBoardHeight;       //键盘弹出高度


@end
