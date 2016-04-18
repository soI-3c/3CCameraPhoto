//
//  HBcarmeraPhtoControl.h
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark <相机拍摄>
typedef void (^accomplishTakePhoto)(NSMutableArray *);                  // 完成拍摄后的回调用所有图片
typedef NS_ENUM(NSUInteger, HBCarmeraImageType) {                       // 原图, 与缩略图
    HBCarmeraImageTypeEdit,
    HBCarmeraImageTypeBasic
};

@interface HBCarmeraPhtoControl : UIImagePickerController
    @property(nonatomic, strong) accomplishTakePhoto asscomplishAction;
    @property(nonatomic, assign) NSInteger maxPhotoNumber;              // 最大拍摄张数
    @property(nonatomic, assign) HBCarmeraImageType imageType;          // 默认是缩略图 HBCarmeraImageTypeEdit. 按屏幕宽压缩
    @property(nonatomic, assign) CGFloat imageMaxSize;                  // 压缩后最大的大小
    + (BOOL) isCanCarmer;
    //若imageType == HBCarmeraImageTypeBasic, 则 maxSize不起作用
    -(instancetype)initMaxPhotoNumber:(CGFloat ) maxNumber maxSize:(CGFloat) maxSize imageType:(HBCarmeraImageType) imageType;
@end
