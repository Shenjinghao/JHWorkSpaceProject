//
//  JHChatInputView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/3.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHChatInputView.h"
#import "JHChatInputMoreView.h"
#import <ReactiveCocoa.h>

@interface JHChatInputView ()<AutoFitTextViewDelegate>

@property (nonatomic, strong) UIView* textViewBack;
@property (nonatomic, strong) UIView* seperatorBottom;
@property (nonatomic, strong) UIView* seperatorTop;

//@property (nonatomic, strong) CYAudioRecorderButton* recordButton;
@property (nonatomic, strong) UIButton* recordButton;
@property (nonatomic, strong) JHChatInputMoreButton* moreButton;

@property (nonatomic) ChatInputViewType type;

@end

@implementation JHChatInputView

+ (JHChatInputView*)inputViewWithtype:(ChatInputViewType)type delegate:(id)delegate
{
    JHChatInputView* chatInputView = [[JHChatInputView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 50) type:type delegate:delegate];
    
    return chatInputView;
}

- (instancetype)initWithFrame:(CGRect)frame type:(ChatInputViewType)type delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        _state = ChatInputViewStateClose;
        _delegate = delegate;
        [self createView];
    }
    return self;
}

- (void)createView
{
    
    _textViewBack = [UIView viewWithFrame:CGRectMake(0, 0, viewWidth(), 50) andBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_textViewBack];
    
    //录音
//    _recordButton = self.audioRecorder.voiceBtn;
    _recordButton = [[UIButton alloc] init];
    [_recordButton setFrame:CGRectMake(5, 5, 40, 40)];
    [_recordButton setImage:[UIImage imageNamed:@"chatinput_record"] forState:UIControlStateNormal];
    [_textViewBack addSubview:_recordButton];
    
    _inputTextView = ({
        
        CGRect textFrame = (_type & ChatInputViewTypeAudio) ? CGRectMake(10, 10, viewWidth() - 20, 30) : CGRectMake(_recordButton.right + 3, 10, viewWidth() - _recordButton.width - self.moreButton.width - 10 - 6, 30);
        
        JHAutoFitTextView* textView = [[JHAutoFitTextView alloc] initWithFrame:textFrame];
        
        textView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
        
        [textView setContainerInsetTop:5 bottom:5];
        
        textView.layer.cornerRadius = 4;
        textView.layer.borderColor = RGBCOLOR_HEX(0xe0e0e0).CGColor;
        textView.layer.borderWidth = 0.5;
        
        textView.returnKeyType = UIReturnKeySend;
        textView.font = [UIFont systemFontOfSize:15];
        
        textView.bottomPadding = 0;
        textView.minHeight = 30;
        textView.maxHeight = IS_iPhone4 ? 100: 160;
        
        textView.placeholder = @"输入文字描述病情...";
        textView.delegate = self;
        
        [_textViewBack addSubview:textView];
        
        textView;
    });
    
    
    _seperatorTop = [UIView separateLineWithFrame:CGRectMake(0, 0, viewWidth(), 0.5) backGroundColor:COLOR_A7];
    [_textViewBack addSubview:_seperatorTop];
    
    _seperatorBottom = [UIView separateLineWithFrame:CGRectMake(0, 0, viewWidth(), 0.5) backGroundColor:COLOR_A7];
    _seperatorBottom.bottom = _textViewBack.bottom;
    [_textViewBack addSubview:_seperatorBottom];
    
    [_textViewBack addSubview:self.moreButton];
}

- (JHChatInputMoreButton*)moreButton
{
    if (!_moreButton) {
        
        //更多
        _moreButton = [JHChatInputMoreButton buttonWithType:UIButtonTypeCustom];
        _moreButton.delegate = _delegate;
        _moreButton.type = _type;
        [_moreButton setFrame:CGRectMake(viewWidth() - 45, 5, 40, 40)];
        [_moreButton setImage:[UIImage imageNamed:@"chatinput_more"] forState:UIControlStateNormal];
        [[[_moreButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:_moreButton.rac_willDeallocSignal] subscribeNext:^(UIButton* button) {
            
            button.selected = !button.selected;
            [_inputTextView resignFirstResponder];
            [_recordButton resignFirstResponder];
            [_recordButton setSelected:NO];
            
            if (button.selected) {
                _state = ChatInputViewStateMore;
            }else {
                _state = ChatInputViewStateClose;
            }
            //此处调用
            [_moreButton becomeFirstResponder];
        }];
    }
    
    return _moreButton;
}

- (void)setInputTextViewMaxHeight:(CGFloat)inputTextViewMaxHeight {
    _inputTextView.maxHeight = inputTextViewMaxHeight;
}

- (CGFloat)inputTextViewMaxHeight {
    return _inputTextView.maxHeight;
}

#pragma mark - AutoFitTextView delegate
- (void)autoFitTextViewDidChangeFrame:(JHAutoFitTextView *)autoFitTextView
{
    _textViewBack.height = _inputTextView.height + 20;
    _seperatorBottom.bottom = _textViewBack.height;
    self.height = _textViewBack.height;
    _recordButton.bottom = _textViewBack.height - 5;
    _moreButton.bottom = _textViewBack.height - 5;
    if (_delegate && [_delegate respondsToSelector:@selector(inputViewDidChangeFrame:)]) {
        [_delegate inputViewDidChangeFrame:self];
    }
}

- (BOOL)shouldReturn
{
    if (_delegate && [_delegate respondsToSelector:@selector(inputViewShouldReturn)]) {
        return [_delegate inputViewShouldReturn];
    }else {
        return YES;
    }
}

@end
