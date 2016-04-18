//
//  ViewController.m
//  HBCameraPhotoController
//
//  Created by iOS-3C on 16/3/27.
//  Copyright © 2016年 heart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property(nonatomic, strong) HBCarmeraPhtoControl *carmeraPhotoControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 35)];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"拍摄" forState: UIControlStateNormal];
    [btn addTarget:self action: @selector(doCameraPhoto) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void) doCameraPhoto {
    self.carmeraPhotoControl = [[HBCarmeraPhtoControl alloc] initMaxPhotoNumber:5 maxSize:200 imageType: HBCarmeraImageTypeEdit];
    self.carmeraPhotoControl.asscomplishAction = ^(NSMutableArray *photos) {
        for (UIImage *image in photos) {
            // todo
        }
    };
    if ([HBCarmeraPhtoControl isCanCarmer]) {
        self.carmeraPhotoControl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController: self.carmeraPhotoControl animated: true completion: nil];
    }
}
@end
