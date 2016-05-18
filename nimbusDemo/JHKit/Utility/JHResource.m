//
//  JHResource.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/29.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//



#import "JHResource.h"

static JHResource* _resource = nil;
@implementation JHResource

{
    // 基于内存的Cache
    NIImageMemoryCache* _imageCache;
}

+ (void) setSharedLocalCache: (JHResource*) resource {
    _resource = resource;
}



- (id) init {
    self = [super init];
    if (self) {
        _imageCache = [[NIImageMemoryCache alloc] init];
    }
    
    return self;
}

- (void) changeTheme: (NSString*) thema {
    // TODO:
}

+ (void) removeAll {
    NIDASSERT(_resource);
    return [_resource removeAll];
}

- (void) removeAll {
    if (_imageCache) {
        [_imageCache removeAllObjects];
    }
}

- (UIImage*) load: (NSString*) imagePath {
    if (![imagePath isNotEmpty]) {
        return nil;
    }
    
    UIImage* image = [_imageCache objectWithName: imagePath];
    if (!image) {
        image = [UIImage imageNamed: imagePath];
        if (image) {
            [_imageCache storeObject: image withName: imagePath];
        }
    }
    
    // 如果读取失败，在Debug时需要注意
    if (!image) {
        NIDPRINT(@"Resource Image not found: %@", imagePath);
    }
    //    NIDASSERT(image);
    
    return image;
}

- (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height {
    NSString* key = [imagePath stringByAppendingString:@"-s"];
    
    UIImage* image = [_imageCache objectWithName: key];
    if (!image) {
        image = [UIImage imageNamed: imagePath];
        
        if (image) {
            image = [image stretchableImageWithLeftCapWidth:width topCapHeight: height];
            
            [_imageCache storeObject: image withName: key];
        }
    }
    
    // 如果读取失败，在Debug时需要注意
    //    NIDASSERT(image);
    
    return image;
}
- (UIImage*) loadFliped: (NSString*) imagePath {
    NSString* key = [NSString stringWithFormat: @"%@-flip", imagePath];
    
    UIImage* image = [_imageCache objectWithName: key];
    if (!image) {
        image = [UIImage imageNamed: imagePath];
        
        if (image) {
            image = [UIImage imageHorizonalFliped: image];
            
            [_imageCache storeObject: image withName: key];
        }
    }
    // 如果读取失败，在Debug时需要注意
    NIDASSERT(image);
    
    return image;
    
}


+ (UIImage*) load: (NSString*) imagePath {
    
    //    NIDASSERT(_resource);
    return [_resource load: imagePath];
}

+ (UIImage*) loadFliped: (NSString*) imagePath {
    NIDASSERT(_resource);
    return [_resource loadFliped: imagePath];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor*) viewBackgroundColor {
    static UIColor* color = nil;
    if (color == nil) {
        color = RGBCOLOR_HEX(0xf1f1f1);
        //        color = [UIColor whiteColor];
    }
    return color;
}

@end
