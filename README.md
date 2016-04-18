# 3CCameraPhoto
1. 导入头文件 ＜/br＞
2.#import "HBCarmeraPhtoControl.h"  ＜/br＞

/*＜/br＞
  MaxPhotoNumber: 最多连拍数       ＜/br＞
  maxSize : 图片压缩后的最大上限 如:200(KB), 表达示图片压缩后, 最大的大小要<=200, , 如果imageType 为HBCarmeraImageTypeBasic(原图)则maxSize不管用   ＜/br＞
  
  imageType:  HBCarmeraImageTypeEdit      // 压缩图片(按 maxSize大小进行压缩)  ＜/br＞
              HBCarmeraImageTypeBasic     // 原图     ＜/br＞
              
*/＜/br＞
 self.carmeraPhotoControl = [[HBCarmeraPhtoControl alloc] initMaxPhotoNumber:5 maxSize:200 imageType: HBCarmeraImageTypeEdit];＜/br＞
    self.carmeraPhotoControl.asscomplishAction = ^(NSMutableArray *photos) {            // 拍摄完成的回调用,photos里为拍摄的图片＜/br＞
        for (UIImage *image in photos) {＜/br＞
            // todo＜/br＞
        }＜/br＞
    };＜/br＞
    if ([HBCarmeraPhtoControl isCanCarmer]) {                                          //  判断相机权限＜/br＞
        self.carmeraPhotoControl.sourceType = UIImagePickerControllerSourceTypeCamera;＜/br＞
        [self presentViewController: self.carmeraPhotoControl animated: true completion: nil];      // todo＜/br＞
    }＜/br＞
