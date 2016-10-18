//
//  ScrollChooseView.m
//  测试Demo
//
//  Created by Shenjinghao on 16/9/30.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "ScrollChooseView.h"

#define kViewRatio (viewWidth()/320)

@interface ScrollChooseView ()<UIScrollViewDelegate>

@end

@implementation ScrollChooseView
{
    NSMutableArray* _labels;
    
    NSInteger _lastLabelIndex;
    
    UILabel* _currentLabel;
}

- (id)initWithFrame:(CGRect)frame start:(NSInteger)start end:(NSInteger)end interval:(NSInteger)interval defaultIndex:(NSInteger)index
{
    self = [super initWithFrame:CGRectMake(130 * kViewRatio, CGRectGetMaxY(frame), 60 * kViewRatio, 80)];
    if (self) {
        self.pagingEnabled = YES;
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        // 创建所有的label
        _labels = [NSMutableArray array];
        CGFloat leftOffset = 0;
        for (NSInteger i = start; i < end; i += interval) {
            UILabel* label = [UILabel labelWithFrame:CGRectMake(leftOffset, 0, 60 * kViewRatio, 30) fontSize:16 text:[NSString stringWithFormat:@"%zi", i]];
            leftOffset += 60 * kViewRatio;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGBCOLOR_HEX(0xbbbbbb);
            [_labels addObject:label];
            [self addSubview:label];
        }
        //设置右边界
        UILabel* label = [_labels lastObject];
        self.contentSize = CGSizeMake(label.right, 30);
        
        self.delegate = self;
        
        [self setOffsetIndex:index];
    }
    return self;
}

- (void)setOffsetIndex:(NSInteger)index
{
    self.contentOffset = CGPointMake(index * 60 * kViewRatio, 0);
    
    if (_currentLabel) {
        [self recoverLabel:_currentLabel];
    }
    
    if (index < _labels.count && index >= 0) {
        [self setCurrentLabel:_labels[index]];
        _lastLabelIndex = index;
    }
}

- (void) setCurrentLabel:(UILabel*)label {
    
    _currentLabel = label;
    _currentLabel.textColor = [UIColor blackColor];
    _currentLabel.font = [UIFont systemFontOfSize:31];
    self.selectedNo = [_currentLabel.text integerValue];
    [_labels removeObject:_currentLabel];
    
}

- (void) recoverLabel:(UILabel*) label {
    
    //  划出区域的字体复原
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = RGBCOLOR_HEX(0xbbbbbb);
    
    [_labels insertObject:label atIndex:_lastLabelIndex];
}


#pragma UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //  当前选中的label, 注意阈值
    
    // 之所以用labels.count而不是count-1是因为labels中已经remove了当前选中的label，所以在后面又insert当前的label后总数会+1
    NSInteger index = MIN(_labels.count, MAX(0,(scrollView.contentOffset.x + 30 * kViewRatio)/(60 * kViewRatio)));
    
    if (_lastLabelIndex != index) {
        if (_currentLabel) {
            [self recoverLabel: _currentLabel];
        }
        
        
        //  设置新的区域内字体大小
        
        if (index < _labels.count && index >= 0) {
            
            // 设置选中区域内的颜色
            _currentLabel = _labels[index];
            _currentLabel.textColor = [UIColor blackColor];
            self.selectedNo = [_currentLabel.text integerValue];
            
            _lastLabelIndex = index;
        }
        
        
        
        [_labels removeObject: _currentLabel];
    }
    
    CGFloat labelOffset =fmodf(scrollView.contentOffset.x, 60 * kViewRatio);
    
    _currentLabel.font = [UIFont systemFontOfSize:(16 + fabs(30 * kViewRatio - labelOffset)/2.2)] ;
}

-(void)setSelectedNo:(NSInteger)selectedNo{
    if (_selectedNo != selectedNo) {
        _selectedNo = selectedNo;
        if ([self.chooseDelegate respondsToSelector:@selector(ScrollChooseView:didChangedToValue:)]) {
            [self.chooseDelegate ScrollChooseView:self didChangedToValue:_selectedNo];
        }
    }
    
}




@end
