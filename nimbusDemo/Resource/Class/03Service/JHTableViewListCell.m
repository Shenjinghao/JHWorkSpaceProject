//
//  JHTableViewListCell.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/17.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHTableViewListCell.h"

@interface JHTableViewListCell ()



@end

@implementation JHTableViewListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _avatarImageView = [[NINetworkImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:20];
        _avatarImageView.initialImage = [UIImage load:@"default_user"];
        [self.contentView addSubview:_avatarImageView];
        
        _nicknameLabel = [UILabel labelWithFontSize:15 fontColor:COLOR_A3 text:@""];
        _nicknameLabel.frame = CGRectMake(_avatarImageView.right+10, 20, viewWidth()-_avatarImageView.right+30, 30);
        [self.contentView addSubview:_nicknameLabel];
        
        _line = [JHLineSeparator lineWithColor:COLOR_A7 width:0.5];
        _line.frame = CGRectMake(15, 69.5, viewWidth()-15, 0.5);
        [self.contentView addSubview:_line];
    }
    return self;
}


@end
