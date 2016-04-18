//
//  HBCarmeraOverView.m
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import "HBCarmeraOverView.h"
#import "HBImageCollectionCell.h"
#import "HBBrowseImageController.h"
#define cellHight 60
#define cancelAccomplBtnW 45

#define SCREENSIZE [UIScreen mainScreen].bounds.size

static NSString * const CarmerPhotoCollectionViewCellID = @"CarmerPhotoCollectionViewCellID";
@interface HBCarmeraOverView() <UICollectionViewDataSource, UICollectionViewDelegate>
    @property(nonatomic, strong) UIButton *toPickCarmerBtn;
    @property(nonatomic, strong) UICollectionView *photoCollectionView;
    @property(nonatomic, strong) UIButton *cancelBtn;
    @property(nonatomic, strong) UIButton *accomplishBtn;
    @property(nonatomic, strong) UIImageView *viewfinder;                   // 取景框
@end

@implementation HBCarmeraOverView
#pragma mark <数据源>
- (void)setCarmeraPhotos:(NSMutableArray *)carmeraPhotos {
    _carmeraPhotos = carmeraPhotos;
    [self.photoCollectionView reloadData];
}

#pragma makr <懒加载>
- (UIButton *)toPickCarmerBtn {
    if (!_toPickCarmerBtn) {
        _toPickCarmerBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREENSIZE.width - cancelAccomplBtnW) * 0.5, SCREENSIZE.height - 49, cancelAccomplBtnW, cancelAccomplBtnW)];
        [_toPickCarmerBtn addTarget:self action:@selector(takeCarmerPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_toPickCarmerBtn setImage:[UIImage imageNamed:@"take_photo_pic"] forState: UIControlStateNormal];
    }
    return _toPickCarmerBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, self.toPickCarmerBtn.frame.origin.y + 7, cancelAccomplBtnW, cancelAccomplBtnW - 10)];
        [_cancelBtn addTarget:self action: @selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState: UIControlStateNormal];
    }
    return _cancelBtn;
}
-(UIButton *)accomplishBtn {
    if (!_accomplishBtn) {
        _accomplishBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 53, self.toPickCarmerBtn.frame.origin.y + 7, cancelAccomplBtnW, cancelAccomplBtnW - 10)];
        [_accomplishBtn addTarget:self action: @selector(accomplishAction) forControlEvents:UIControlEventTouchUpInside];
        [_accomplishBtn setTitle:@"完成" forState: UIControlStateNormal];
    }
    return _accomplishBtn;
}
- (UIImageView *)viewfinder {
    if (!_viewfinder) {
        CGFloat viewFinderHeight = SCREENSIZE.height - SCREENSIZE.height / 4.0;
        _viewfinder = [[UIImageView alloc] initWithFrame:CGRectMake(0, (viewFinderHeight - SCREENSIZE.width * (218.0 / 318.0)) * 0.5, SCREENSIZE.width, SCREENSIZE.width * (218.0 / 318.0))];
        _viewfinder.image = [UIImage imageNamed:@"bg1"];
    }
    return _viewfinder;
}
- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc] init];
        _photoCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREENSIZE.height *( 3.0 / 4.0)  + 8, SCREENSIZE.width, (SCREENSIZE.height *( 1 / 4.0) - cancelAccomplBtnW - 10 ) * (2.0 / 3.0)) collectionViewLayout:layout];
        [_photoCollectionView registerClass:[HBImageCollectionCell class] forCellWithReuseIdentifier: CarmerPhotoCollectionViewCellID];
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        layout.itemSize = CGSizeMake((SCREENSIZE.width / 3) - 25, (SCREENSIZE.height *( 1 / 4.0) - cancelAccomplBtnW - 10 ) * (2.0 / 3.0));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _photoCollectionView.backgroundColor = [UIColor blackColor];
    }
    return _photoCollectionView;}

- (instancetype)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview: self.toPickCarmerBtn];
        [self addSubview: self.photoCollectionView];
        [self addSubview: self.cancelBtn];
        [self addSubview: self.accomplishBtn];
        [self addSubview:self.viewfinder];
    }
    return self;
}

#pragma mark <拍摄, 取消, 完成>
- (void) takeCarmerPhoto:(UIButton *) sender {
    if (self.carmeraPhotos.count == self.maxPhotoNumber) {                          // 防止用户快速连拍
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"当前最多还能拍摄%ld张", (long)self.maxPhotoNumber] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        return;
    }
    if (self.takePhoto) {
        self.toPickCarmerBtn.enabled = NO;
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(changeTagePhotoBtnType) userInfo:nil repeats:NO];
        self.takePhoto();
    }
}

- (void) cancelAction {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void) accomplishAction {
    if (self.accomplishBlock) {
        self.accomplishBlock();
    }
}
- (void) changeTagePhotoBtnType {
    self.toPickCarmerBtn.enabled = YES;
}
#pragma mark <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.carmeraPhotos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HBImageCollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier: CarmerPhotoCollectionViewCellID forIndexPath:indexPath];
    cell.cutOutImage = ^(HBImageCollectionCell *cell) {                      // 删除图片
        NSIndexPath *path = [collectionView indexPathForCell:cell];
        [self.carmeraPhotos removeObjectAtIndex:path.item];
        [self.photoCollectionView reloadData];
    };
    cell.showImage = self.carmeraPhotos[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.browImageBlock) {                      // 浏览图片的点击事件, 传第图片所在的下标过去
        self.browImageBlock(indexPath);
    }
}

@end
