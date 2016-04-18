//
//  HBcarmeraPhtoControl.m
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import "HBcarmeraPhtoControl.h"
#import "HBCarmeraOverView.h"
#import "HBBrowseImageController.h"
//#import "AppInfo.h"

#define SCREENSIZE [UIScreen mainScreen].bounds.size

@interface HBCarmeraPhtoControl ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
    @property(nonatomic, strong) HBCarmeraOverView *carmerOverView;
    @property(nonatomic, strong) NSMutableArray *photos;
@end

@implementation HBCarmeraPhtoControl

#pragma mark : <懒加载>
- (HBCarmeraOverView *)carmerOverView {
    if (!_carmerOverView) {
        _carmerOverView = [[HBCarmeraOverView alloc] init];
        _carmerOverView.maxPhotoNumber = self.maxPhotoNumber;
        __weak __typeof__(self) weakSelf = self;
        _carmerOverView.takePhoto = ^() {                               // 拍摄
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            [strongSelf toPick];
        };
        
        _carmerOverView.cancelBlock = ^() {                             // 取消
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            [strongSelf dismissViewControllerAnimated:true completion:nil];
        };
        
        _carmerOverView.accomplishBlock = ^() {                         // 完成
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            if (strongSelf.asscomplishAction) {                         // 回调用所有图片给使用者
                strongSelf.asscomplishAction(strongSelf.photos);
            }
            [strongSelf dismissViewControllerAnimated:true completion:nil];
        };
        _carmerOverView.browImageBlock = ^(NSIndexPath *index) {       // 图片浏览
            HBBrowseImageController *browseImageControl = [[HBBrowseImageController alloc] initWithImages:weakSelf.photos selectIndex:index.item];
            [weakSelf presentViewController:browseImageControl animated:true completion:nil];
        };
        _carmerOverView.frame = self.view.bounds;
    }
    return _carmerOverView;
}

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (instancetype)initMaxPhotoNumber:(CGFloat ) maxNumber maxSize:(CGFloat) maxSize imageType:(HBCarmeraImageType) imageType {
    if (self = [super init]) {
        self.maxPhotoNumber = maxNumber;
        self.imageType = imageType;
        self.imageMaxSize = maxSize;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.showsCameraControls = NO;                  // 不显示原有控件
    self.cameraOverlayView = self.carmerOverView;   // 自定义的控制(界面)
}
#pragma mark <拍摄>
- (void) toPick {
    [self takePicture];
}
+ (BOOL) isCanCarmer {                              // 判断手机是否可用
   return [HBCarmeraPhtoControl isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark <UIImagePickerControllerDelegate>
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    CGFloat maxWidth = 0.0;

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取原始照片
    if (self.imageType == HBCarmeraImageTypeEdit) {
        if (image.size.width > image.size.height) {
            maxWidth = image.size.height / sqrt( UIImageJPEGRepresentation(image, 1.0).length / 1024 / self.imageMaxSize);
        }else {
            maxWidth = image.size.width / sqrt( UIImageJPEGRepresentation(image, 1.0).length / 1024 / self.imageMaxSize);
        }
        maxWidth =  maxWidth > SCREENSIZE.width ? maxWidth : SCREENSIZE.width ;
        image = [self scaleImageToWidth: maxWidth byImage: image];
        NSData *imageData = UIImageJPEGRepresentation(image, compression);
        while ([imageData length] > self.imageMaxSize && compression > maxCompression) {
            compression -= 0.1;
            imageData = UIImageJPEGRepresentation(image, compression);
        }
        image = [UIImage imageWithData: imageData];
    }
    [self.photos addObject: image];
    self.carmerOverView.carmeraPhotos = self.photos;                           //  将拍摄的图片,传给CollectionView显示
}

#pragma mark <按比利压缩图片>
- (UIImage *) scaleImageToWidth:(CGFloat) width byImage:(UIImage *)image{
    if (image.size.width < width) {
        return image;
    }
    CGFloat imgHeight = width * image.size.height / image.size.width;
    CGSize size  = CGSizeMake(width, imgHeight);
    UIGraphicsBeginImageContext(size);
    // 在制定区域中缩放绘制完整图像
    [image  drawInRect:CGRectMake(0, 0, size.width + 2, size.height + 2)];
    // 4. 获取绘制结果
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    return result;
}
@end
