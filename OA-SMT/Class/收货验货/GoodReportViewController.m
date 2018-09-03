//
//  ReceiveGoodReportViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "GoodReportViewController.h"
#import "ReportModel.h"
#import "OpenBoxReporyView.h"
#import "AddImageView.h"
#import "ImageShowView.h"

@interface GoodReportViewController ()

@property (nonatomic,strong)ReportModel* model;
@property (nonatomic,strong)OpenBoxReporyView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;

@property (nonatomic,strong)NSMutableArray* imageMArr;
@end

@implementation GoodReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self loadData];
}

-(void)setIsReceive:(BOOL)isReceive{
    _isReceive = isReceive;
    if (isReceive) {
        self.title = @"收货报告";
        self.boxView.leftTitles = [NSMutableArray arrayWithObjects:@"货物类型",@"实际到达日期",@"是否缺货", nil];
    }
    else{
        self.title = @"开箱报告";
        self.boxView.leftTitles = [NSMutableArray arrayWithObjects:@"货物类型",@"开箱日期",@"是否缺换货", nil];
    }
}

-(void)setStatus:(int)status{
    _status = status;
    kWeakSelf(weakSelf);
    switch (status) {
        case 0:{
            self.rightItemTitle = @"提交";
            self.rightItemHandle = ^{
                [weakSelf uploadImage];
            };
        }break;
        case 1:{
            self.boxView.userInteractionEnabled = NO;
        }break;
        case 2:{
            self.rightItemTitle = @"关闭问题";
            self.rightItemHandle = ^{
                [weakSelf closeTransportProblem];
            };
        }break;
    }
    
}

- (void)setUp{
    kWeakSelf(weakSelf);
    
    [self.view addSubview:self.boxView];
    [self.view addSubview:self.addImageView];
    [self.view addSubview:self.imageShowView];

    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(44*(weakSelf.boxView.leftTitles.count+1)+180);
    }];

    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.boxView.mas_left);
        make.right.mas_equalTo(weakSelf.boxView.mas_right);
        make.height.mas_equalTo(115);
    }];

    [self.imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.boxView.mas_left);
        make.right.mas_equalTo(weakSelf.boxView.mas_right);
    }];

}

//提交收货报告
-(void)submitReceiveGoodsInfoReport:(NSString *)imgs{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.goodsId forKey:@"goodsId"];
    [para setObject:self.boxView.firstText forKey:@"optDate"];
    [para setObject:self.boxView.secondText forKey:@"hasProblem"];
    [para setObject:self.boxView.noteText forKey:@"optNote"];
    [para setObject:imgs forKey:@"imgs"];
    [para setObject:[UserDef objectForKey:@"userName"] forKey:@"userName"];
    NSString *url;
    if (self.isReceive) {
        url = [CCString getHeaderUrl:AddReceiveGoodsInfo];
    }
    else{
        url = [CCString getHeaderUrl:AddCheckoutGoodsInfo];
    }
    BaseRequest* request = [BaseRequest cc_requestWithUrl:url
                                                   isPost:YES
                                                   Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            [LoadingView showAlertHUD:@"提交成功" duration:1.0];
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
            [weakSelf performSelector:@selector(pop) withObject:nil afterDelay:1.0];
        }
        else{
            [LoadingView showAlertHUD:@"提交失败" duration:1.0];
        }
    }];
}

//上传收货照片
-(void)uploadImage{
    if (self.imageMArr.count > 1) {
        kWeakSelf(weakSelf);
        NSMutableArray *imagePath = [NSMutableArray new];
        for (int i = 0; i < self.imageMArr.count-1; i++) {
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",[NSDate dateStringWithFormat:@"HHmmss"],i];
            [BaseRequest UploadImageWithUrl:[CCString getHeaderUrl:UploadFile] params:nil image:self.imageMArr[i] fielName:fileName completion:^(NSDictionary *jsonDic) {
                NSLog(@"jsonDic:%@",jsonDic);
                [imagePath addObjectsFromArray:jsonDic[@"result"]];
                if (imagePath.count == weakSelf.imageMArr.count-1) {
                    NSMutableString *imgs = [[NSMutableString alloc]init];
                    for (NSString *imgPath in imagePath) {
                        [imgs appendFormat:@"%@,",imgPath];
                    }
                    [imgs deleteCharactersInRange:NSMakeRange(imgs.length-1, 1)];
                    [weakSelf submitReceiveGoodsInfoReport:imgs];
                }
            }];
        }
    }
    else{
        [self submitReceiveGoodsInfoReport:@""];
    }
}

-(void)closeTransportProblem{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.goodsId forKey:@"goodsId"];
    if (self.isReceive) {
        [para setObject:@"0" forKey:@"type"];
    }
    else{
        [para setObject:@"1" forKey:@"type"];
    }
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:CloseTransportProblem]
                                                   isPost:YES
                                                   Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            [LoadingView showAlertHUD:@"关闭成功" duration:1.0];
            [weakSelf performSelector:@selector(pop) withObject:nil afterDelay:1.0];
        }
        else{
            [LoadingView showAlertHUD:@"关闭失败" duration:1.0];
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

- (void)updateFrame{
    //如果有照片
    if (self.imageMArr.count == 0 || !self.imageMArr) {
        return;
    }
}


#pragma mark
#pragma mark -- LazyLoad

-(OpenBoxReporyView *)boxView{
    if (!_boxView) {
        _boxView = [[OpenBoxReporyView alloc]init];
        _boxView.textPlaceHolder = @"无";
        _boxView.topTextViewTitle = @"货物问题描述";
        _boxView.thirdText = @"0";
        _boxView.noteText = @"";
        _boxView.secondText = [NSDate dateStringWithFormat:@"yyyy-MM-dd"];
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"批量收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"0";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"开箱收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"1";
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:problem];
            [alertVc addAction:noProblem];
            
            [weakSelf presentViewController:alertVc animated:YES completion:nil];
        };
        _boxView.secondClickBlock = ^{
            PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
            datePickManager.datePicker.datePickerMode = PGDatePickerModeDate;
            datePickManager.datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
                NSLog(@"dateComponents = %@", dateComponents);
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
                weakSelf.boxView.secondText = date;
            };
            [weakSelf presentToVC:datePickManager];
        };
        _boxView.thirdClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.thirdText = @"1";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.thirdText = @"0";
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

-(NSMutableArray *)imageMArr{
    if (!_imageMArr) {
        _imageMArr = [[NSMutableArray alloc]init];
    }
    return _imageMArr;
}

@end
