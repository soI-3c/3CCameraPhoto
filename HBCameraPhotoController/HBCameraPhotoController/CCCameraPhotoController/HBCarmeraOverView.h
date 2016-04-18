//
//  HBCarmeraOverView.h
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark <自定义相机界面>
typedef void(^takeCarmerPhoto)();
typedef void(^cancelBlock)();
typedef void(^accomplishBlock)();
typedef void(^browImageBlock)(NSIndexPath *);

@interface HBCarmeraOverView : UIView
    @property(nonatomic, strong) NSMutableArray *carmeraPhotos;
    @property(nonatomic, copy) takeCarmerPhoto takePhoto;                   // 拍摄
    @property(nonatomic, copy) cancelBlock cancelBlock;                     // 取消
    @property(nonatomic, copy) accomplishBlock accomplishBlock;             // 完成
    @property(nonatomic, copy) browImageBlock browImageBlock;               // 点击图片浏览
    @property(nonatomic, assign) NSInteger maxPhotoNumber;                  // 最大拍摄张数

@end
