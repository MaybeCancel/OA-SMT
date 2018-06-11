//
//  BaseViewController.m
//  ios-2Block
//
//  Created by Slark on 17/1/12.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIBarButtonItem* rightItem;
@property (nonatomic,strong)UIImagePickerController * pic;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Hidden_BackTile = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBColor(241, 241, 241);
    self.barColor = RGBColor(251, 251, 251);
    self.arrowColor = RGBColor(83, 83, 83);
    [self setupSubviews];
    NSLog(@">>>class name:%@",NSStringFromClass([self class]));
}

-(void)dealloc{
    NSLog(@">>>dealloc class name:%@",NSStringFromClass([self class]));
}

- (void)setRightItemTitle:(NSString *)rightItemTitle{
    _rightItemTitle = rightItemTitle;
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:_rightItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightItemImageName:(NSString *)rightItemImageName{
    _rightItemImageName = rightItemImageName;
   UIImage *rightImage = [[UIImage imageNamed:rightItemImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)setArrowColor:(UIColor *)arrowColor{
    _arrowColor = arrowColor;
    self.navigationController.navigationBar.tintColor = _arrowColor;
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:_titleColor};
}
- (void)setBarColor:(UIColor *)barColor{
    _barColor = barColor;
    self.navigationController.navigationBar.barTintColor = _barColor;
}

- (void)rightClick{
    if (self.rightItemHandle) {
        self.rightItemHandle();
    }
}

- (void)pushVC:(UIViewController *)vc{
    if([vc isKindOfClass:[UIViewController class]] ==NO) return;
    if(self.navigationController ==nil) return;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pop{
    if (self.navigationController==nil) return;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc{
    if ([vc isKindOfClass:[UIViewController class]] ==NO) return;
    if (self.navigationController==nil) return;
    [self.navigationController popToViewController:vc animated:YES];
}
- (void)popToRootVc{
    if (self.navigationController==nil) return;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)presentToVC:(UIViewController *)vc{
    if([vc isKindOfClass:[UIViewController class]]==NO) return;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)addchildVc:(UIViewController *)childVc{
    if([childVc isKindOfClass:[UIViewController class]] ==NO) return;
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
}
- (void)removeChildVc:(UIViewController *)childVc{
    if([childVc isKindOfClass:[UIViewController class]] ==NO) return;
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
    
}
- (void)setHidden_BackTile:(BOOL)Hidden_BackTile{
    _Hidden_BackTile = Hidden_BackTile;
    if (_Hidden_BackTile) {
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = backButtonItem;
    }
}


/** 加载数据*/
- (void)loadData{
    
}

-(void)setupSubviews{
    
}

//照片倒转90度方法
-(UIImage *)fixOrientation:(UIImage *)aImage {
    if (aImage.imageOrientation == UIImageOrientationUp)
        
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(NSData *)compressImageData:(UIImage *)myimage

{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        
        if (data.length>1024*1024) {//1M以及以上
            
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
            if(data.length > 1020*1024){
                data = UIImageJPEGRepresentation(myimage, 0.05);
            }
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            
            data=UIImageJPEGRepresentation(myimage, 0.9);

        }
    }
    return data;
}

- (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        
        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前",years];
}
- (void)OpenAlbumAlert{
    UIAlertController* alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 选择照片
//前往照片图库
- (void)openAlbum{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];//用户可以随意移动以及缩放图像
    ipc.allowsEditing = NO;//允许用户缩放拖动
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark 打开相机 须获得用户权限
//打开相机
- (void)openCamera{
    _pic = [[UIImagePickerController alloc] init];
    _pic.sourceType = UIImagePickerControllerSourceTypeCamera;//图像来源
    //用户可以随意移动以及缩放图像
    _pic.allowsEditing = NO;//允许用户缩放拖动
    _pic.delegate = self;
    [self presentViewController:_pic animated:YES completion:nil];
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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

-(void)showToast:(NSTimeInterval)duration withMessage:(NSString *)message{
    [self.view makeToast:message duration:duration position:CSToastPositionCenter];
}
@end
