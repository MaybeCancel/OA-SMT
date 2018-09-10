//
//  QualityDetailViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/2.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "QualityDetailViewController.h"
#import "WarningReportView.h"
#import "FoldListView.h"
#import "AddImageView.h"
#import "ImageShowView.h"
#import "QualityReportModel.h"
#import "ProblemTypeViewController.h"
#import "SubmitBtnView.h"

@interface QualityDetailViewController ()
@property (nonatomic,strong)WarningReportView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;
@property (nonatomic,strong)SubmitBtnView* submitView;
@property (nonatomic,strong)NSMutableArray* imageMArr;
@end

@implementation QualityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"整改闭环";
    [self setUp];
}
- (void)setUp{
    [self.view addSubview:self.imageShowView];
    [self.view addSubview:self.boxView];
    [self.view addSubview:self.addImageView];
    [self.view addSubview:self.submitView];
    
    kWeakSelf(weakSelf);
    [self.imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(0);
    }];
    
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imageShowView.mas_bottom);
        make.left.mas_equalTo(weakSelf.imageShowView.mas_left);
        make.right.mas_equalTo(weakSelf.imageShowView.mas_right);
        make.height.mas_equalTo(44*(weakSelf.boxView.leftTitles.count+1)+180);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.boxView.mas_left);
        make.right.mas_equalTo(weakSelf.boxView.mas_right);
        make.height.mas_equalTo(115);
    }];
}

//提交告警处理报告
-(void)submitReceiveGoodsInfoReport{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.model.id forKey:@"id"];
    [para setObject:self.boxView.firstText forKey:@"isSolve"];
    [para setObject:self.boxView.noteText forKey:@"note"];

    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:UpdateWorkOrder]
                                                   isPost:YES
                                                   Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            [LoadingView showAlertHUD:@"提交成功" duration:1.0];
            [weakSelf performSelector:@selector(pop) withObject:nil afterDelay:1.0];
        }
        else{
            [LoadingView showAlertHUD:@"提交失败" duration:1.0];
        }
    }];
}

//上传整改闭环照片
-(void)uploadImage{
    if (self.imageMArr.count > 1) {
        kWeakSelf(weakSelf);
        
        NSMutableArray *imagePath = [NSMutableArray new];
        
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:[NSString stringWithFormat:@"%d",self.model.workOrderTypeId] forKey:@"workOrderTypeId"];
        [params setObject:self.model.id forKey:@"workOrderId"];
        [params setObject:@"" forKey:@"note"];
        
        for (int i = 0; i < self.imageMArr.count-1; i++) {
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",[NSDate dateStringWithFormat:@"HHmmss"],i];
            [BaseRequest UploadImageWithUrl:[CCString getHeaderUrl:UploadWorkFile] params:params image:self.imageMArr[i] fielName:fileName completion:^(NSDictionary *jsonDic) {
                
                [imagePath addObjectsFromArray:jsonDic[@"result"]];
                if (imagePath.count == weakSelf.imageMArr.count-1) {
                    [weakSelf submitReceiveGoodsInfoReport];
                }
            }];
        }
    }
    else{
        [self submitReceiveGoodsInfoReport];
    }
}

#pragma mark
#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self saveImageToPhotoAlbum:image];
    [self.imageMArr addObject:image];
    self.addImageView.images = self.imageMArr;
    [self dismiss];
}

#pragma mark
#pragma mark -- LazyLoad

-(WarningReportView *)boxView{
    if (!_boxView) {
        _boxView = [[WarningReportView alloc]init];
        _boxView.leftTitles = [NSMutableArray arrayWithObjects:@"整改结果", nil];
        _boxView.textPlaceHolder = @"无";
        _boxView.topTextViewTitle = @"遗留问题";
        _boxView.firstText = @"0";
        _boxView.noteText = @"";
        _boxView.isQualityDetail = YES;
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"有问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"1";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"无问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"0";
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:problem];
            [alertVc addAction:noProblem];
            
            [weakSelf presentViewController:alertVc animated:YES completion:nil];
        };
    }
    return _boxView;
}

-(AddImageView *)addImageView{
    if (!_addImageView) {
        _addImageView = [[AddImageView alloc]init];
        _addImageView.title = @"照片";
        kWeakSelf(weakSelf);
        _addImageView.tapHandle = ^{
            [weakSelf OpenAlbumAlert];
        };
        _addImageView.deleteImageBlock = ^(int index) {
            [weakSelf.imageMArr removeObjectAtIndex:index];
            weakSelf.addImageView.images = weakSelf.imageMArr;
        };
    }
    return _addImageView;
}

-(ImageShowView *)imageShowView{
    if (!_imageShowView) {
        _imageShowView = [[ImageShowView alloc]init];
    }
    return _imageShowView;
}

-(SubmitBtnView *)submitView{
    if (!_submitView) {
        _submitView = [[SubmitBtnView alloc]initWithFrame:CGRM(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80)];
        kWeakSelf(weakSelf);
        _submitView.SubmitBlock = ^(){
            [weakSelf uploadImage];
        };
    }
    return _submitView;
}

-(NSMutableArray *)imageMArr{
    if (!_imageMArr) {
        _imageMArr = [[NSMutableArray alloc]init];
    }
    return _imageMArr;
}
@end
