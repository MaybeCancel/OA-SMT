//
//  ShootPicViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteInfoModel.h"

@interface ShootPicViewController : UIViewController
@property (nonatomic,strong)SiteInfoModel* siteModel;
@property (nonatomic,copy)void (^shootPicHandle)(UIImage* image);

@end
