//
//  JHSplitPhotoViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/18.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHSplitPhotoViewController.h"
#import <ReactiveCocoa.h>
#import "PECropViewController.h"

@interface JHSplitPhotoViewController ()<UIActionSheetDelegate,PECropViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) JHFilledColorButton *btn1;
@property (nonatomic, strong) JHFilledColorButton *btn2;

@property (nonatomic) UIPopoverController *popover;   //iPad会有，同UISplitViewController

@end

@implementation JHSplitPhotoViewController

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, viewWidth() - 30, 460)];
    self.imageView.backgroundColor = COLOR_A6;
    self.imageView.image = [UIImage imageWithColor:COLOR_A6 andSize:CGSizeMake(viewWidth(), 460)];
    [self.view addSubview:self.imageView];
    
    _btn1 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, 500, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"编辑" fontSize:16 isBold:NO];
    
    [[[_btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:_btn1.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        [self openEditor:x];
    }];
    [self.view addSubview:_btn1];
    
    _btn2 = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, _btn1. bottom + 20, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"打开" fontSize:16 isBold:NO];
    
    [[[_btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:_btn2.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        [self cameraButtonAction:x];
    }];
    [self.view addSubview:_btn2];
    
    
}

#pragma mark - Action methods

- (void)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.imageView.image;
    
    UIImage *image = self.imageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)cameraButtonAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        [actionSheet showFromBarButtonItem:self.btn1 animated:YES];
    } else {
        [actionSheet showFromToolbar:self.navigationController.toolbar];
    }
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = croppedImage;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
}
- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updateEditButtonEnabled
{
    self.btn2.enabled = !!self.imageView.image;
}

#pragma mark - UIActionSheetDelegate methods

/*
 Open camera or photo album.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

#pragma mark - Private methods

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:self.btn2
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
        [self.popover presentPopoverFromBarButtonItem:self.btn2
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    } else {
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
        [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
}


@end
