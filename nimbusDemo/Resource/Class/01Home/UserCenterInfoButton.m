//
//  UserCenterInfoButton.m
//  ChunyuClinic
//
//  Created by Shenjinghao on 15/8/28.
//  Copyright (c) 2015年 lvjianxiong. All rights reserved.
//

#import "UserCenterInfoButton.h"

@implementation UserCenterInfoButton


{
    
    UILabel *_titleLabel;
    UILabel *_countLabel;
    UIImageView *_trendImageView;
    UIView *_badgeView;
}



- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        
        //  title
        _titleLabel = [UILabel labelWithFrame: CGRectMake(0, 29, frame.size.width, 11)
                                     fontSize: 10
                                    fontColor: COLOR_A10
                                         text: @""];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _titleLabel];
        
        //  count
        _countLabel = [UILabel labelWithFrame: CGRectMake(0, 9, frame.size.width, 15)
                                     fontSize: 14
                                    fontColor: COLOR_A10
                                         text: @""];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _countLabel];
        
        
//        (删除)
        /*
        //  trend Image
        _trendImageView = [[UIImageView alloc] initWithFrame: CGRectMake(58, 29, 11, 11)];
        _trendImageView.image = [[CYResource load: @"rank_trend_up.png"] imageWithTintColor: RGBCOLOR_HEX(0x0444fa)];
        _trendImageView.hidden = YES;
        [self addSubview: _trendImageView];
        
        //  badge Image
        _badgeView = [[UIView alloc] initWithFrame: CGRectMake(53, 6, 7, 7)];
        _badgeView.layer.cornerRadius = _badgeView.width/2;
        _badgeView.backgroundColor = RGBCOLOR_HEX(0xff3434);
        _badgeView.hidden = YES;
        [self addSubview: _badgeView];
        */
    }
    return self;
}


- (void) setTitle:(NSString*)title count:(NSString*)count {
    _titleLabel.text = title;
    _countLabel.text = count;
}


- (void) settitleText:(NSString*)title {
    _titleLabel.text = title;
}

- (void) setCount:(NSString*)count {
    _countLabel.text = count;
}


- (void) showBadge:(BOOL) show {
    _badgeView.hidden = !show;
}


- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted: highlighted];
    
    if (highlighted) {
        
        _countLabel.textColor = COLOR_A10;
        self.backgroundColor = [UIColor clearColor];//RGBCOLOR_HEX(0xebeef0);
    } else {
        
        _countLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
