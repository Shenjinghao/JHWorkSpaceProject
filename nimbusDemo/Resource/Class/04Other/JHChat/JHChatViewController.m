//
//  JHChatViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/2.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHChatViewController.h"
#import "UIView+JHGesturesBlock.h"
#import "JHChatInputMoreView.h"
#import "NITableViewModel+private.h"

@interface JHChatViewController ()<ChatInputViewDelegate,ChatInputMoreViewDeleagte>

@end

@implementation JHChatViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
     
        self.autoresizesForKeyboard = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"无限聊天";
    self.view.backgroundColor = RGBCOLOR_HEX(0xfefdfd);
    self.tableView.backgroundColor = COLOR_A9;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView jhAddTapGestureWithActionBlock:^(UIGestureRecognizer *tap) {
        [self.view endEditing:YES];
    }];
    
    [self showChatActionView:YES];
    
    
}

- (JHChatInputView*)chatInputView
{
    if (!_chatInputView) {
        
        _chatInputView = [JHChatInputView inputViewWithtype:(ChatInputViewTypePhoto | ChatInputViewTypeAlbum | ChatInputViewTypeProfile | ChatInputViewTypeShowAppointment | ChatInputViewTypeMoulde | ChatInputViewTypeCoupon | ChatInputViewTypeTopic | ChatInputViewTypeSpecialService | ChatInputViewTypeAssistant) delegate:self];
        _chatInputView.delegate = self;
//        _chatInputView.audioRecorder.parentView = self.view;
//        _chatInputView.delegate = self;
        _chatInputView.inputTextViewMaxHeight = 58;
    }
    return _chatInputView;
}

- (void)showChatActionView:(BOOL)show {
    if (show) {
        
        [self.view addSubview:self.chatInputView];
        self.chatInputView.bottom = self.view.height;
        self.tableView.height = self.chatInputView.top;
        [self.view addSubview:self.chatInputView];
        self.chatInputView.bottom = self.view.height;
        self.tableView.height = self.chatInputView.top ;
    }
    else {
        [_chatInputView removeFromSuperview];
        self.tableView.height = self.view.height;
    }
}

#pragma mark - keyboard

#define kcloseKeyboardButtonTag 0xF0
- (void)keyboardWillAppear:(BOOL)animated withBounds:(CGRect)bounds
{
    //真机中，键盘通知可能会调用多次
    
    self.chatInputView.bottom = self.view.height - bounds.size.height;
    
    [self autoFitTextViewDidChangeFrame:self.chatInputView];
    
    self.keyBoardHeight = bounds.size.height;
}

- (void)keyboardWillDisappear:(BOOL)animated withBounds:(CGRect)bounds
{
    [self.chatInputView.inputTextView resignFirstResponder];
    
    self.chatInputView.bottom = self.view.height;
    
    [self autoFitTextViewDidChangeFrame:self.chatInputView];
    
    self.keyBoardHeight = 0;
}

- (void)autoFitTextViewDidChangeFrame:(JHChatInputView *)autoFitTextView
{
    [self setTableViewInsetsWithBottomValue:self.view.height - self.chatInputView.top - self.chatInputView.height];
    [self scrollToBottom:NO];
}

- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = bottom;
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

#pragma mark - scroll view

- (void)scrollToBottom:(BOOL)animate
{
    JHURLRequestModel* model = (JHURLRequestModel*)self.tableViewModel.model;
    NSInteger row = model.section.rows.count;
    NSInteger rowOfTableView = [self.tableView numberOfRowsInSection:0];
    if (row > 0 && row <= rowOfTableView && self.tableView.numberOfSections > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(row - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)inputViewDidChangeFrame:(JHChatInputView *)inputView
{
    inputView.bottom = self.view.height - self.keyBoardHeight;
}

@end
