//
//  JHCollectionViewCell.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHCollectionViewCell.h"

@implementation JHCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView:frame];
    }
    return self;
}

- (void)createView:(CGRect)frame
{
    //image:45*45
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat centerX = frame.size.width / 2;
    CGFloat centerY = frame.size.height / 2;
    _collectionImage = [[NINetworkImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.contentView addSubview:_collectionImage];
    [_collectionImage setCenter:CGPointMake(centerX, centerY - 12)];
    
    _collectionName = [UILabel labelWithFrame:CGRectMake(0, 0, frame.size.width - 10, 20) fontSize:12 fontColor:RGBCOLOR_HEX(0x808080) text:nil];
    [_collectionName setCenter:CGPointMake(centerX, centerY + 25)];
    [_collectionName setBackgroundColor:[UIColor clearColor]];
    [_collectionName setTextAlignment:NSTextAlignmentCenter];
    [_collectionName setAdjustsFontSizeToFitWidth:YES];
    [self.contentView addSubview:_collectionName];
}

@end
