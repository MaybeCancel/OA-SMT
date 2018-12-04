//
//  ShootPhotoViewController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/9/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseViewController.h"

@interface ShootPhotoViewController : UIViewController
@property (nonatomic,copy)void (^shootPicHandle)(UIImage* image);
@end
