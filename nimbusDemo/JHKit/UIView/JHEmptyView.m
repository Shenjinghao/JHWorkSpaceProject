//
//  JHEmptyView.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/22.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHEmptyView.h"

@implementation JHEmptyView
{
    UIImageView *_imageView;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_imageView.image load:[self imageName]];
        [self addSubview:_imageView];
        
        _label = [UILabel labelWithFontSize:14 fontColor:RGBCOLOR_HEX(0x8e9bab) text:@""];
        _label.top = _imageView.bottom + 20;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

- (NSString *)imageName
{
    return @"icon-smile.png";
}

- (void)updateWithText:(NSString *)text
{
    _label.text = text;
    _label.width = viewWidth() - 20;
    [_label sizeToFit];
    self.width = MAX(_label.width, _imageView.width);
    if (text) {
        self.height = _label.bottom;
    }else{
        self.height = _imageView.bottom;
    }
    _label.centerX = self.width / 2;
    _imageView.centerX = self.width / 2;
    
}

@end

static const CGFloat kVPadding1 = 14;
static const CGFloat kVPadding2 = 10;

@implementation ErrorView


//static const CGFloat kHPadding  = 10;
{
    UIImageView*  _imageView;
    UILabel*      _titleView;
    //    UILabel*      _subtitleView;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image {
    self = [self init];
    if (self) {
        self.title = title;
        // self.subtitle = subtitle;
        self.image = image;
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
        
        _titleView = [[UILabel alloc] init];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.textAlignment = UITextAlignmentCenter;
        _titleView.textColor = RGBCOLOR_HEX(0xaaa5a1);
        _titleView.font = [UIFont systemFontOfSize: 16];
        _titleView.numberOfLines = 0;
        [self addSubview:_titleView];
        
    }
    
    return self;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    //    _subtitleView.size = [_subtitleView sizeThatFits:CGSizeMake(self.width - kHPadding*2, 0)];
    _titleView.size = CGSizeMake(300, 0);
    [_titleView sizeToFit];
    [_imageView sizeToFit]; //
    
    CGFloat maxHeight = _imageView.height + _titleView.height + kVPadding1; // _subtitleView.height +  + kVPadding2;
    BOOL canShowImage = _imageView.image && self.height > maxHeight;
    
    CGFloat totalHeight = 0;
    
    if (canShowImage) {
        totalHeight += _imageView.height;
    }
    if (_titleView.text.length) {
        totalHeight += (totalHeight ? kVPadding1 : 0) + _titleView.height;
    }
    //    if (_subtitleView.text.length) {
    //        totalHeight += (totalHeight ? kVPadding2 : 0) + _subtitleView.height;
    //    }
    
    CGFloat top = floor(self.height/2 - totalHeight/2);
    
    if (canShowImage) {
        _imageView.origin = CGPointMake(floor(self.width/2 - _imageView.width/2), top);
        _imageView.hidden = NO;
        top += _imageView.height + kVPadding1;
        
    } else {
        _imageView.hidden = YES;
    }
    if (_titleView.text.length) {
        // 将_titleView设置为多行显示，300宽度，如果超过300宽度，那就设置为两行，如果没有超过300的宽度，那就一行，位置固定在计算的位置
        _titleView.origin = CGPointMake((floor(self.width/2 - _titleView.width/2) > 10) ? floor(self.width/2 - _titleView.width/2) : 10, top);
        top += _titleView.height + kVPadding2;
    }
    //    if (_subtitleView.text.length) {
    //        _subtitleView.origin = CGPointMake(floor(self.width/2 - _subtitleView.width/2), top);
    //    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Properties


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)title {
    return _titleView.text;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTitle:(NSString*)title {
    if ([title isNotEmpty]) {
        _titleView.text = title;
        //        if ([title hasSuffix:@"。"]) { // TODO: clean this!!!
        //            _titleView.text = [NSString stringWithFormat:@"%@ 点此尝试重新载入", title];
        //        } else {
        //            _titleView.text = [NSString stringWithFormat:@"%@。点此尝试重新载入", title];
        //        }
    }
    else {
        _titleView.text = @"点此尝试重新载入";
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)image {
    return _imageView.image;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setImage:(UIImage*)image {
    _imageView.image = image;
}


@end

@implementation LoadingView

{
    UIActivityIndicatorView *_indicatorView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = CGPointMake(self.width / 2, self.height / 2);
        [self addSubview:_indicatorView];
    }
    return self;
}

- (void)setIsLoading:(BOOL)isLoading {
    if (_isLoading != isLoading) {
        _isLoading = isLoading;
        if (isLoading) {
            [_indicatorView startAnimating];
        }
        else {
            [_indicatorView stopAnimating];
        }
    }
}

@end

#define kPageLoadingViewHeight 60


@implementation JHLoadingView
{
    UIActivityIndicatorView *_indicatorView;
    UILabel *_label;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kPageLoadingViewHeight, kPageLoadingViewHeight)];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.center = CGPointMake(self.width / 2, self.height / 2);
        [self addSubview:_indicatorView];
        
        self.layer.cornerRadius = 7;
        self.clipsToBounds = YES;
        self.backgroundColor = RGBCOLOR_HEX(0x313131);
        
        _label = [UILabel labelWithFontSize:14 fontColor:RGBCOLOR_HEX(0xffffff) text:@""];
        _label.left = kPageLoadingViewHeight;
        [self addSubview:_label];
    }
    return self;
}

- (void)dealloc {
    [_indicatorView stopAnimating];
}

- (void)updateWithText:(NSString *)text {
    _label.text = text;
    [_label sizeToFit];
    _label.centerY = kPageLoadingViewHeight / 2;
    if (text) {
        self.width = _label.right + 18;
    }
    else {
        self.width = kPageLoadingViewHeight;
    }
    [_indicatorView startAnimating];
}



@end