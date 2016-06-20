//
//  JHChatInputMoreView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/6.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatInputViewType)
{
    ChatInputViewTypePhoto  = 0x1,
    ChatInputViewTypeAlbum  = 0x1<<1,
    ChatInputViewTypeMoulde = 0x1<<2,       //模板
    ChatInputViewTypeCoupon = 0x1<<3,       //优惠券
    ChatInputViewTypeProfile    =   0x1 <<4,//多档案
    ChatInputViewTypeTopic  = 0x1<<5,       //发话题
    ChatInputViewTypeAgain  = 0x1<<6,           //复诊
    ChatInputViewTypeShowAppointment = 0x1<<7,    //显示发门诊预约
    ChatInputViewTypeAudio  = 0x1<<8,        //音频按钮
    ChatInputViewTypeSpecialService = 0x1<<9,  //特色服务
    ChatInputViewTypeAssistant  = 0x1<<10   //转给助手
};

typedef NS_ENUM(NSInteger, ChatInputViewState)
{
    ChatInputViewStateClose,        //关闭
    ChatInputViewStateRecord,       //录音
    ChatInputViewStateMore,         //更多
    ChatInputViewStateKeyboard      //显示键盘
};

@protocol ChatInputMoreViewDeleagte<NSObject>;
@optional

- (void)moreItemButtonClicked:(ChatInputViewType)type;

@end

@interface JHChatInputMoreView : UIView

@property (nonatomic, weak) id <ChatInputMoreViewDeleagte> delegate;
@property (nonatomic, readonly) ChatInputViewType type;
- (instancetype)initWithFrame:(CGRect)frame type:(ChatInputViewType)type delegate:(id)delegate;
- (void)refreshWithType:(ChatInputViewType)type;

@end

@interface JHChatInputMoreButton : UIButton

@property (nonatomic, strong) JHChatInputMoreView* moreInputView;
@property (nonatomic) ChatInputViewType type;
@property (nonatomic, weak) id <ChatInputMoreViewDeleagte> delegate;
- (void)refreshMoreView;

@end






