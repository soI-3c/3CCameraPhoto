//
//  HBImageCollectionCellCollectionCell.h
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark <浏览显示的cell>

@class HBImageCollectionCell;
typedef void(^cutOutCellPhoto)(HBImageCollectionCell *);

@interface HBImageCollectionCell : UICollectionViewCell
    @property(nonatomic, strong) UIImage *showImage;
    @property(nonatomic, strong) cutOutCellPhoto cutOutImage;
    @property(nonatomic, strong) UIButton *cutOutBtn;                       // 删除
@end
