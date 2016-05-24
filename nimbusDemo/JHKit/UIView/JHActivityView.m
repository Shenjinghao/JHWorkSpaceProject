//
//  JHActivityView.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/25.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//


#define kMargin 10
#define kPadding 15
#define kBannerPadding 8
#define kSpacing 6
#define kProgressMargin 6

#import "JHActivityView.h"
#import "UIFont+JHCategory.h"

@implementation JHActivityView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame style:(JHActivityViewStyle)style text:(NSString*)text {
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        _progress = 0;
        _smoothesProgress = NO;
        _smoothTimer =nil;
        _progressView = nil;
        
        _bezelView = [[UIView alloc] init];
        _bezelView.layer.cornerRadius = 2;
        
        if (_style == JHActivityLabelStyleWhiteBox) {
            _bezelView.backgroundColor = [UIColor clearColor];
            self.backgroundColor = [UIColor whiteColor];
            
        } else if (_style == JHActivityLabelStyleBlackBox) {
            _bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
            // [UIColor clearColor];
            // [UIColor colorWithWhite:0 alpha:0.8];
            self.backgroundColor = [UIColor clearColor];
            // self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
            
        } else {
            _bezelView.backgroundColor = [UIColor clearColor];
            self.backgroundColor = [UIColor clearColor];
        }
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _label = [[UILabel alloc] init];
        _label.text = text;
        _label.backgroundColor = [UIColor clearColor];
        _label.lineBreakMode = UILineBreakModeTailTruncation;
        
        if (_style == JHActivityLabelStyleWhite) {
            _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleWhite];
            _label.font = [UIFont systemFontOfSize:17];
            _label.textColor = [UIColor whiteColor];
            
        } else if (_style == JHActivityLabelStyleGray
                   || _style == JHActivityLabelStyleWhiteBox) {
            _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleGray];
            _label.font = [UIFont systemFontOfSize:17];
            _label.textColor = RGBCOLOR(99, 109, 125);
            
        } else if (_style == JHActivityLabelStyleBlackBox) {
            _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                  UIActivityIndicatorViewStyleWhiteLarge];
            _activityIndicator.frame = CGRectMake(0, 0, 24, 24);
            _label.font = [UIFont systemFontOfSize:17];
            _label.textColor = [UIColor whiteColor];
            _label.shadowColor = [UIColor colorWithWhite:0 alpha:0.3];
            _label.shadowOffset = CGSizeMake(1, 1);
            
        }
        
        [self addSubview:_bezelView];
        [_bezelView addSubview:_activityIndicator];
        [_bezelView addSubview:_label];
        [_activityIndicator startAnimating];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame style:(JHActivityViewStyle)style {
    self = [self initWithFrame:frame style:style text:nil];
    if (self) {
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(JHActivityViewStyle)style {
    self = [self initWithFrame:CGRectZero style:style text:nil];
    if (self) {
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame style: JHActivityLabelStyleWhiteBox text:nil];
    if (self) {
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_smoothTimer invalidate];
    _smoothTimer = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize textSize = [_label.text sizeWithFont:_label.font];
    
    CGFloat indicatorSize = 0;
    [_activityIndicator sizeToFit];
    if (_activityIndicator.isAnimating) {
        if (_activityIndicator.height > textSize.height) {
            indicatorSize = textSize.height;
            
        } else {
            indicatorSize = _activityIndicator.height;
        }
    }
    
    CGFloat contentWidth = indicatorSize + kSpacing + textSize.width;
    CGFloat contentHeight = textSize.height > indicatorSize ? textSize.height : indicatorSize;
    
    if (_progressView) {
        [_progressView sizeToFit];
        contentHeight += _progressView.height + kSpacing;
    }
    
    CGFloat margin, padding, bezelWidth, bezelHeight;
    margin = kMargin;
    padding = kPadding;
    bezelWidth = contentWidth + kPadding*2;
    bezelHeight = contentHeight + kPadding*2;
    
    
    //    if (_style == TTActivityLabelStyleBlackBezel || _style == TTActivityLabelStyleWhiteBezel) {
    //        margin = kMargin;
    //        padding = kPadding;
    
    //
    //    } else {
    //        margin = 0;
    //        padding = kBannerPadding;
    //        bezelWidth = self.width;
    //        bezelHeight = self.height;
    //    }
    
    CGFloat maxBevelWidth = JHScreenBounds().size.width - margin*2;
    if (bezelWidth > maxBevelWidth) {
        bezelWidth = maxBevelWidth;
        contentWidth = bezelWidth - (kSpacing + indicatorSize);
    }
    
    CGFloat textMaxWidth = (bezelWidth - (indicatorSize + kSpacing)) - padding*2;
    CGFloat textWidth = textSize.width;
    if (textWidth > textMaxWidth) {
        textWidth = textMaxWidth;
    }
    
    
    
    // 居中对齐
    _bezelView.frame = CGRectMake(floor(self.width/2 - bezelWidth/2),
                                  floor(self.height/2 - bezelHeight/2),
                                  bezelWidth, bezelHeight);
    
    CGFloat y = padding + floor((bezelHeight - padding*2)/2 - contentHeight/2);
    
    if (_progressView) {
        _progressView.frame = CGRectMake(kProgressMargin, y,
                                         bezelWidth - kProgressMargin*2, _progressView.height);
        y += _progressView.height + kSpacing-1;
    }
    
    _label.frame = CGRectMake(floor((bezelWidth/2 - contentWidth/2) + indicatorSize + kSpacing), y,
                              textWidth, textSize.height);
    
    _activityIndicator.frame = CGRectMake(_label.left - (indicatorSize+kSpacing), y,
                                          indicatorSize, indicatorSize);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat padding = kBannerPadding;
    CGFloat height = _label.font.ttLineHeight + padding*2;
    if (_progressView) {
        height += _progressView.height + kSpacing;
    }
    
    return CGSizeMake(size.width, height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)smoothTimer {
    if (_progressView.progress < _progress) {
        _progressView.progress += 0.01;
        
    } else {
        [_smoothTimer invalidate];
        _smoothTimer = nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)text {
    return _label.text;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setText:(NSString*)text {
    _label.text = text;
    [self setNeedsLayout];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIFont*)font {
    return _label.font;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setFont:(UIFont*)font {
    _label.font = font;
    [self setNeedsLayout];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isAnimating {
    return _activityIndicator.isAnimating;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setIsAnimating:(BOOL)isAnimating {
    if (isAnimating) {
        [_activityIndicator startAnimating];
        
    } else {
        [_activityIndicator stopAnimating];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setProgress:(float)progress {
    _progress = progress;
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progress = 0;
        [_bezelView addSubview:_progressView];
        [self setNeedsLayout];
    }
    
    if (_smoothesProgress) {
        if (!_smoothTimer) {
            _smoothTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self
                                                          selector:@selector(smoothTimer) userInfo:nil repeats:YES];
        }
        
    } else {
        _progressView.progress = progress;
    }
}


@end