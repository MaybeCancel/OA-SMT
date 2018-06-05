//
//  PostPicCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ZXYCircleProgress.h"
#import "PostInfoModel.h"
#import "SiteInfoModel.h"
@interface PostPicCell : BaseTableViewCell
/** 图片小图*/
@property (nonatomic,strong)UIImageView* picMiniImage;
/** 照片名字*/
@property (nonatomic,strong)UILabel* nameLabel;
/** 图片大小*/
@property (nonatomic,strong)UILabel* picSize;
/** 当前上传速度*/
@property (nonatomic,strong)UILabel* networkSpeed;
/** 进度条*/
@property (nonatomic,strong)ZXYCircleProgress* circleProgress;
/** 上传的图片*/
@property (nonatomic,strong)UIImage* uploadImage;


@property (nonatomic,assign)BOOL isPost;

@property (nonatomic,assign)CGFloat progress;

- (void)loadDataFromModel:(PostInfoModel*)model;

- (void)postImage;

@property (nonatomic,copy)void (^postFinishHandle)(void);
@end
