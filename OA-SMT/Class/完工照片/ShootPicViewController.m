//
//  ShootPicViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ShootPicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PicTips.h"
#import "ShootDawnViewController.h"
@interface ShootPicViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;
@property(nonatomic)AVCaptureStillImageOutput *ImageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic)BOOL canCa;
//拍照生成的照片
@property (nonatomic,strong)UIImage *image;
//预览层
@property (nonatomic)UIImageView *imageView;
@property (nonatomic,strong)UIButton* shootingBtn;
@property (nonatomic,strong)UIButton* backBtn;

//第二次拍摄 判断
@property (nonatomic,assign)BOOL secondShoot;
@property (nonatomic,strong)PicTips* tips;
@property (nonatomic,strong)UILabel* littleTip;


@end

@implementation ShootPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断是否有相机权限
    _canCa = [self canUserCamear];
    if (_canCa) {
        [self customCamera];
        [self customUI];
    }else{
        return;
    }
}
- (void)customUI{
    /*水印视图*/
    _tips = [PicTips shareShootPic];
    _tips.frame = CGRM(15, 15, 220, 135);
    [_tips loadInfoFromModel:self.siteModel];
    [self.view addSubview:_tips];
   
    self.littleTip = [[UILabel alloc]initWithFrame:CGRM(0,SCREEN_HEIGHT - 15 - 20, SCREEN_WIDTH-15, 15)];
    self.littleTip.text = @"照片采用SMT移动APP拍摄";
    self.littleTip.textAlignment = NSTextAlignmentRight;
    self.littleTip.font = [UIFont systemFontOfSize:11];
    self.littleTip.textColor = RGBColor(230, 230, 230);
    [self.view addSubview:self.littleTip];
    
    
    self.shootingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shootingBtn.frame = CGRM(SCREEN_WIDTH / 2- (73/2), SCREEN_HEIGHT - 73 - 43, 73, 73);
    [self.shootingBtn setImage:[UIImage imageNamed:@"btn_photo_ing"] forState:UIControlStateNormal];
    [self.view addSubview:self.shootingBtn];
    [self.shootingBtn addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"btn_photo_forward"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    self.backBtn.sd_layout.leftSpaceToView(self.view, 15).widthIs(30).heightIs(30).bottomSpaceToView(self.view, 63);
}
- (void)customCamera{
    self.view.backgroundColor = [UIColor whiteColor];
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.session.sessionPreset = AVCaptureSessionPresetHigh;
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRM(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    //开始启动
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
}



#pragma mark - 返回
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 拍摄照片
- (void) shutterCamera
{
    if (self.secondShoot == NO) {
        [self shootimage];
        [self.shootingBtn setImage:[UIImage imageNamed:@"btn_photo_finish"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"btn_photo_cancel"] forState:UIControlStateNormal];
    }else{
        /*这里做照片操作 需要将照片保存传递过去*/
        [self saveImageToPhotoAlbum:self.image];
        /*将照片传到前一个界面*/
        if (self.shootPicHandle) {
            self.shootPicHandle(self.image);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)shootimage{
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        // 相机停止获取内容
        [self.session stopRunning];
        //获取相机拍照的照片
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.image = [UIImage imageWithData:imageData];
        self.imageView = [[UIImageView alloc]initWithFrame:self.previewLayer.frame];
        self.imageView.layer.masksToBounds = YES;
        
        //打水印
        self.image = [UIImage addWatemarkImageWithLogoImage:self.image watemarkImage:[UIImage imageWithUIView:self.littleTip] logoImageRect:self.previewLayer.frame watemarkImageRect:(CGRM(0,SCREEN_HEIGHT - 15 - 20, SCREEN_WIDTH, 15))];
        
        self.image = [UIImage addWatemarkImageWithLogoImage:self.image watemarkImage:[UIImage imageWithUIView:self.tips] logoImageRect:self.previewLayer.frame watemarkImageRect:CGRM(15, 15, 220, 135)];
        [self.image loadInfoFromModel:self.siteModel];
        self.imageView.image = self.image;
      
        self.secondShoot = YES;
    }];
}

#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{
//    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [LoadingView showAlertHUD:msg duration:1];
}

@end
