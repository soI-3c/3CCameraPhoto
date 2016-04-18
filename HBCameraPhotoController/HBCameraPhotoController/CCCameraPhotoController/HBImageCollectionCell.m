//
//  HBImageCollectionCellCollectionCell.m
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import "HBImageCollectionCell.h"
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define CutOutBtnWH 15

@interface HBImageCollectionCell()
    @property(nonatomic, strong) UIImageView *imageView;
@end

@implementation HBImageCollectionCell

- (void)setShowImage:(UIImage *)showImage {
    _showImage = showImage;
    self.imageView.image = self.showImage;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
       _imageView.contentMode = self.frame.size.width >= SCREENSIZE.width ?  UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
- (UIButton *)cutOutBtn {
    if (!_cutOutBtn) {
        _cutOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - CutOutBtnWH, 0, CutOutBtnWH, CutOutBtnWH)];
        [_cutOutBtn setImage:[UIImage imageNamed:@"ico_pic_del"] forState:UIControlStateNormal];
        [_cutOutBtn addTarget: self action:@selector(cutOutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cutOutBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.cutOutBtn];
    }
    return self;
}

- (void) cutOutAction {                         // 删除图片
    if (self.cutOutImage) {
        self.cutOutImage(self);
    }
}
@end
