//
//  PostPicCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "PostPicCell.h"

@implementation PostPicCell{
    UIView* _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.picMiniImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_JPG"]];
    [self.contentView addSubview:self.picMiniImage];
   
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = RGBColor(26, 26, 26);
    self.nameLabel.text = @"A001_江宁大学城基站_基站全景[全景01]";
    self.nameLabel.font = [UIFont systemWithScreen:14];
    [self.contentView addSubview:self.nameLabel];
    
    
    self.picSize = [[UILabel alloc]init];
    self.picSize.textAlignment = NSTextAlignmentLeft;
    self.picSize.textColor = RGBColor(148, 148, 148);
    self.picSize.text = @"106K/300K";
    self.picSize.font = [UIFont systemWithScreen:12];
    [self.contentView addSubview:self.picSize];
 

    self.networkSpeed = [[UILabel alloc]init];
    self.networkSpeed.textAlignment = NSTextAlignmentRight;
    self.networkSpeed.textColor = RGBColor(148, 148, 148);
    self.networkSpeed.text = @"102K/S";
    self.networkSpeed.font = [UIFont systemWithScreen:12];
    [self.contentView addSubview:self.networkSpeed];
 
    
    self.circleProgress = [[ZXYCircleProgress alloc]initWithFrame:CGRM(self.width-35-15, 12, 35, 35) progress:0];
    self.circleProgress.bottomColor = RGBColor(231, 231, 231);
    self.circleProgress.topColor = RGBColor(56, 117, 231);
    self.circleProgress.progressWidth = 2;
    [self.circleProgress.statueBtn addTarget:self action:@selector(postImage) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.circleProgress];
 
    
    _lineView = [[UIView alloc]init];
    [self.contentView addSubview:_lineView];
    _lineView.backgroundColor = RGBColor(231, 231, 231);
    
    self.picMiniImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 12).widthIs(29).heightIs(35);
    self.nameLabel.sd_layout.leftSpaceToView(self.picMiniImage, 10).topSpaceToView(self.contentView, 12).heightIs(18).widthIs(self.width-100);
    self.picSize.sd_layout.leftEqualToView(self.nameLabel).topSpaceToView(self.nameLabel, 5).heightIs(15).widthIs(120);
    self.networkSpeed.sd_layout.topEqualToView(self.picSize).rightSpaceToView(self.contentView, 126/2).widthIs(90).heightIs(15);
    
    self.circleProgress.sd_layout.rightSpaceToView(self.contentView, 15).topEqualToView(self.nameLabel).heightIs(35).widthIs(35);
    _lineView.sd_layout.leftSpaceToView(self.contentView, 15).widthIs(SCREEN_WIDTH - 15).heightIs(1).bottomSpaceToView(self.contentView, 0);
}

-(void)setHasUpload:(BOOL *)hasUpload{
    _hasUpload = hasUpload;
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.sd_layout.leftSpaceToView(self.picMiniImage, 10).topSpaceToView(self.contentView, 12).heightIs(36).widthIs(self.width-100);
    self.picSize.hidden = YES;
    self.networkSpeed.hidden = YES;
    self.circleProgress.hidden = YES;
}

- (void)setIsPost:(BOOL)isPost{
    _isPost = isPost;
     self.circleProgress.statueBtn.selected = _isPost;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.circleProgress.progress = _progress;
}

- (void)loadDataFromModel:(PostInfoModel*)model{
    /** 这里做假设  如果model里面有照片就进行储存 进行上传操作
     *  第二种方案 在Model里面设置一个新的值 然后进行判断 只有第一个进行上传
     */
    if(model.image){
        [self uploadOpeartion:model.image];
    }
}
- (void)postImage{
    if(self.uploadImage){
        [self uploadOpeartion:self.uploadImage];
    }
}
- (void)uploadOpeartion:(UIImage*)image{
    NSDictionary* requestDic = @{@"projectId":[NSString stringWithFormat:@"%@",image.projectId],
                          @"stationId":[NSString stringWithFormat:@"%@",image.stationId],
                          @"deviceId":image.deviceId,
                          @"positionId":[NSString stringWithFormat:@"%@",image.positionId],
                          @"userId":[NSString stringWithFormat:@"%@",[UserDef objectForKey:@"userId"]],
                          @"longitude":image.longitude,
                          @"latitude":image.latitude,
                          @"address":[UserDef objectForKey:@"myLocation"],
                          @"photoDate":image.shootingTime
                          };
    /* 上传操作 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];//声明返回的数据是json
    manager.requestSerializer =[AFJSONRequestSerializer serializer];//声明请求的数据是json
    //设置请求头
    [manager.requestSerializer setValue:@"application/json;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    
    NSString* urlstring = [CCString getHeaderUrl:UploadPhoto];
    [manager POST:urlstring parameters:requestDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传操作
        NSData *zipData = [image compressMaxDataSizeKBytes:300];
        //图片现在名字为image  命名规则 站号_站名_设备及照片部位  exp:A001_江宁大学城基站_基站全景[机房和塔建]
        NSString *fileName = [NSString stringWithFormat:@"%@_%@_%@.jpg",image.siteNumber,image.siteName,image.devicePicPart];
        [formData appendPartWithFileData:zipData name:@"1213" fileName:fileName mimeType:@"image/jpeg"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //进度条数值更新  如果不成功则需要使用 KVO
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
             CGFloat progress =  uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
                NSLog(@"进度~~~~~~~~%.f",progress);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.circleProgress.progress = progress;
                    if(progress > 0.99f){
                        NSLog(@"进度条完成");
                    }
                });
            });
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //上传成功
            NSMutableDictionary *dictttt = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if([dictttt[@"message"] isEqualToString:@"OK"]){
                NSLog(@"~~~~~~~~~~上传成功");
                if (self.postFinishHandle) {
                    self.postFinishHandle(image);
                }
            }
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //上传失败
    
    }];
}


@end
