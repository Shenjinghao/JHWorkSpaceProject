//
//  JHChatInputView.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/3.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

/**
 *  JHChatInputView : 对应键盘的view
 *
 *                        JHAutoFitTextView   自动适应高度的textview
 *
 *                                            JHChatInputMoreView 右侧+按钮对应展示的view
 *
 *                                            JHChatInputMoreButton  JHChatInputMoreView
 */

#import <UIKit/UIKit.h>
#import "JHAutoFitTextView.h"
#import "JHChatInputMoreView.h"
#import "JHChatInputView.h"

@class JHChatInputView;
@protocol ChatInputViewDelegate <NSObject>

@optional

- (BOOL)inputViewShouldReturn;

- (void)inputViewDidBeginRecording;

- (void)inputViewDidEndRecordingWithAudioPath:(NSString *)audioPath duration:(NSTimeInterval)duration;

- (void)inputViewDidCancelRecording;

- (void)inputViewDidChangeFrame:(JHChatInputView *)inputView;

@end

@interface JHChatInputView : UIView

@property (nonatomic, strong) JHAutoFitTextView* inputTextView;
@property (nonatomic) ChatInputViewState state;

@property (nonatomic) CGFloat inputTextViewMaxHeight;
@property (nonatomic, readonly) CGFloat textInputItemHeight;

@property (nonatomic, weak) id <ChatInputViewDelegate, ChatInputMoreViewDeleagte> delegate;


+ (JHChatInputView*)inputViewWithtype:(ChatInputViewType)type delegate:(id)delegate;

@end
