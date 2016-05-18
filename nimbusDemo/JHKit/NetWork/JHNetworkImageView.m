//
//  JHNetworkImageView.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHNetworkImageView.h"

@implementation JHNetworkImageView

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        
    }
    return self;
}

- (void) setUrlPath:(NSString *)urlPath {
    [self prepareForReuse];
    
    // 同一个URL会被请求多次? 如何处理呢?
    [self setPathToNetworkImage: urlPath];
}

- (UIImage*) defaultImage {
    return self.initialImage;
}

- (void) setDefaultImage:(UIImage *)defaultImage{
    self.initialImage = defaultImage;
}

+ (JHNetworkImageView *)roundViewWithFrame:(CGRect)frame {
    JHNetworkImageView *imageView = [[JHNetworkImageView alloc] initWithFrame:frame];
    imageView.layer.cornerRadius = imageView.width / 2;
    imageView.clipsToBounds = YES;
    imageView.layer.borderColor = RGBCOLOR_HEX(0xdedede).CGColor;
    imageView.layer.borderWidth = 1;
    return imageView;
}

- (void)setPathToNetworkImage:(NSString *)pathToNetworkImage forDisplaySize:(CGSize)displaySize contentMode:(UIViewContentMode)contentMode cropRect:(CGRect)cropRect
{
    [super setPathToNetworkImage:pathToNetworkImage forDisplaySize:displaySize contentMode:contentMode cropRect:cropRect];
    if (NIIsStringWithAnyText(pathToNetworkImage))
    {
        NSURL* url = nil;
        
        // Check for file URLs.
        if ([pathToNetworkImage hasPrefix:@"/"]) {
            // If the url starts with / then it's likely a file URL, so treat it accordingly.
            url = [NSURL fileURLWithPath:pathToNetworkImage];
            
        } else {
            // Otherwise we assume it's a regular URL.
            url = [NSURL URLWithString:pathToNetworkImage];
        }
        
        _urlPath = [url absoluteString];
    }
}

//
// 下载失败后重新下载的selector
//
- (void) reDownLoadBtTimer {
    [self setPathToNetworkImage: _urlPath];
}


@end
