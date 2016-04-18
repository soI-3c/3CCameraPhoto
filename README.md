# 3CCameraPhoto
   相机连拍功能     
   
1. 导入头文件  
2.#import "HBCarmeraPhtoControl.h"  


/*  
  MaxPhotoNumber: 最多连拍数  
  
  maxSize : 图片压缩后的最大上限 如:200(KB), 表达示图片压缩后, 最大的大小要<=200, , 如果imageType  
  为HBCarmeraImageTypeBasic(原图)则maxSize不管用     
  
  imageType:  HBCarmeraImageTypeEdit      // 压缩图片(按 maxSize大小进行压缩)  
              HBCarmeraImageTypeBasic     // 原图  
*/  
在你要触发相机的事件中:  

  self.carmeraPhotoControl = [[HBCarmeraPhtoControl alloc] initMaxPhotoNumber:5 maxSize:200 imageType: HBCarmeraImageTypeEdit];  
 
    self.carmeraPhotoControl.asscomplishAction = ^(NSMutableArray *photos) {            // 拍摄完成的回调用,photos里为拍摄的图片  
        for (UIImage *image in photos) {  
            // todo  
        }  
    };  
    if ([HBCarmeraPhtoControl isCanCarmer]) {                                          //  判断相机权限  
        self.carmeraPhotoControl.sourceType = UIImagePickerControllerSourceTypeCamera;  
        [self presentViewController: self.carmeraPhotoControl animated: true completion: nil];      // todo   
    }
