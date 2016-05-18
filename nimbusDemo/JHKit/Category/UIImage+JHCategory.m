//
//  UIImage+JHCategory.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/11.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "UIImage+JHCategory.h"

#import "objc/runtime.h"
#import "NIInMemoryCache.h"

static UIImage *_image = nil;

@interface UIImage (JHCategory)
/**
 *  基于内存的Cache  category里面添加属性要重载运行时
 */
@property (nonatomic) NIImageMemoryCache *imageCache;

@end


@implementation UIImage (JHCategory)
/**
 *  默认@synthesize
 */
@dynamic imageCache;

static char KImageCacheKey;

- (void)setImageCache:(NIImageMemoryCache *)imageCache
{
    objc_setAssociatedObject(self, &KImageCacheKey, imageCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NIImageMemoryCache *)imageCache
{
    return objc_getAssociatedObject(self, &KImageCacheKey);
}


- (void) setProperty:(UIImage *)value
{
    objc_setAssociatedObject(self, @selector(property), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *) property
{
    return objc_getAssociatedObject(self, @selector(property));
}

#pragma mark 截图,将当前页面转化成image
- (UIImage *) getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.bounds.size);
    //下载的图片会失真
    //    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, [UIScreen mainScreen].scale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

#pragma mark 下载电子版名片并存入手机
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NIDPRINT(@"%d",[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]);
    
    if (error == nil) {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alerView show];
    }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"授权失败，请授权相册管理" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alerView show];
    }else if (error != nil){
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败，请重新保存" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
#pragma mark 加载图片
- (UIImage *)load:(NSString *)imagePath
{
    if (![imagePath isNotEmpty]) {
        return nil;
    }
    UIImage *image = [self.imageCache objectWithName:imagePath];
    if (!image) {
        image = [UIImage imageNamed:imagePath];
        if (image) {
            [self.imageCache storeObject:image withName:imagePath];
        }
    }
    /**
     *  如果读取失败，在Debug时需要注意
     */
    if (!image) {
        NIDPRINT(@"Resource Image not found: %@", imagePath);
    }
    return image;
}

+ (UIImage *)load:(NSString *)imagePath
{
    //下面的方法怎么不管用了？？
//    return [_image load:imagePath];
    return [UIImage imageNamed:imagePath];
}

/**
 *  填充颜色
 */
- (UIImage*) imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor: tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage*) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode) blendMode {
    NIDPRINTMETHODNAME();
    
    // keep alpha, set opaque to NO
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage* tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height {
    NIDASSERT(_image);
    return [_image loadStretch: imagePath capWidth: width capHeight: height];
}
- (UIImage*) loadStretch: (NSString*) imagePath capWidth: (int) width capHeight: (int)height {
    NSString* key = [imagePath stringByAppendingString:@"-s"];
    
    UIImage* image = [self.imageCache objectWithName: key];
    if (!image) {
        image = [UIImage imageNamed: imagePath];
        
        if (image) {
            image = [image stretchableImageWithLeftCapWidth:width topCapHeight: height];
            
            [self.imageCache storeObject: image withName: key];
        }
    }
    
    // 如果读取失败，在Debug时需要注意
    //    NIDASSERT(image);
    
    return image;
}

+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size {
    
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage*) imageHorizonalFliped: (UIImage*) image {
    return [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
}


@end
