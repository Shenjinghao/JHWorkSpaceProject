//
//  JHAutoFitTextView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/6.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHAutoFitTextView.h"

@import ObjectiveC;

@interface JHAutoFitTextView ()<UITextViewDelegate>

@property(nonatomic, readonly) NSMutableArray *validators;
//@property(nonatomic, weak) id<UITextViewDelegate> delegate;
@property(nonatomic, readonly) id<AutoFitTextViewDelegate> autoFitDelegate;

@end

@implementation JHAutoFitTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        
        self.scrollable = YES;
        
        self.minHeight = self.height;
        
        self.bottomPadding = 15;
        
        [self setContainerInsets:UIEdgeInsetsZero];
        
        _validators = [NSMutableArray new];
    }
    return self;
}

- (void)setContainerInsetTop:(CGFloat)top bottom:(CGFloat)bottom {
    if (IOSOVER(7)) {
        UIEdgeInsets insets = self.textContainerInset;
        insets.top = top;
        insets.bottom = bottom;
        [self setContainerInsets:insets];
    }
}

- (void)setContainerInsets:(UIEdgeInsets)insets {
    if (IOSOVER(7)) {
        self.textContainerInset = insets;
    }
}

- (void)reset {
    self.text = @"";
    [self updateFrame];
}

- (void)updateFrame {
    if (self.text.length > 0) {
        CGFloat height = [self jhContentSize].height + self.bottomPadding;
        
        height = MAX(height, self.minHeight);
        if (self.maxHeight > 0) {
            height = MIN(height, self.maxHeight);
        }
        
        if (height != self.height) {
            self.height = height;
            [self didChangeFrame];
        }
    } else {
        CGFloat height = self.minHeight;
        if (height == 0) {
            height = self.placeholderLabel.bottom + self.placeholderLabel.top;
        }
        self.height = height;
        [self didChangeFrame];
    }
}

- (CGSize)jhContentSize {
    // fix for ios7 & ios8
    if (IOSOVER(7) && !IOSOVER(9)) {
        return [self sizeThatFits:CGSizeMake(self.width, FLT_MAX)];
    }
    else {
        return self.contentSize;
    }
}

- (void)didChangeFrame {
    if ([self.autoFitDelegate
         respondsToSelector:@selector(autoFitTextViewDidChangeFrame:)]) {
        [self.autoFitDelegate autoFitTextViewDidChangeFrame:self];
    }
}
#pragma delegate
- (id<AutoFitTextViewDelegate>)autoFitDelegate {
    return (id<AutoFitTextViewDelegate>)self.delegate;
}

#pragma mark - textview delegate
- (void)textViewDidChange:(UITextView *)textView {
    [self updateFrame];
    
    if ([self.delegate
         respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:textView];
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.delegate
         respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.delegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.delegate
         respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.delegate
         respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.delegate
         respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [self didChangeFocus];
    
    if ([self.delegate
         respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.delegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"] &&
        [self.autoFitDelegate respondsToSelector:@selector(shouldReturn)]) {
        if ([self.autoFitDelegate shouldReturn]) {
            return NO;
        }
    }
    
    if ([self.delegate
         respondsToSelector:@selector(textView:
                                      shouldChangeTextInRange:
                                      replacementText:)]) {
             return [self.delegate textView:textView
                            shouldChangeTextInRange:range
                                    replacementText:text];
         }
    return YES;
}

#pragma mark - scroll

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.text isNotEmpty]) {
        self.contentOffset =
        CGPointZero; // 粘贴大段文字，虽然更新了UITextView的frame，但是内容还是会往上滚，并且没法再恢复了
        
        [self didChangeFocus];
    }
    
    if ([self.delegate
         respondsToSelector:@selector(
                                      scrollViewDidEndScrollingAnimation:)]) {
             [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
         }
}

- (void)didChangeFocus {
    [self updateFrame];
    
    if ([self.autoFitDelegate
         respondsToSelector:@selector(
                                      autoFitTextViewDidChangeFocusLocation:)]) {
             [self.autoFitDelegate autoFitTextViewDidChangeFocusLocation:self];
         }
    
    if (self.scrollable && self.selectedRange.location != NSNotFound) {
        UITextView *textView = self;
        // make caret visible
        CGRect line =
        [textView caretRectForPosition:textView.selectedTextRange.start];
        CGFloat overflow =
        line.origin.y + line.size.height -
        (textView.contentOffset.y + textView.bounds.size.height -
         textView.contentInset.bottom - textView.contentInset.top);
        if (overflow > 0) {
            // We are at the bottom of the visible text and introduced a line
            // feed, scroll down (iOS 7 does not do it)
            // Scroll caret to visible area
            CGPoint offset = textView.contentOffset;
            offset.y += overflow + 7; // leave 7 pixels margin
            // Cannot animate with setContentOffset:animated: or caret will not
            // appear
            [UIView animateWithDuration:.2
                             animations:^{
                                 [textView setContentOffset:offset];
                             }];
        }
    }
}

@end
