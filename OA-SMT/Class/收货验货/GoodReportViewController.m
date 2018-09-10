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
#import "SubmitBtnView.h"

@interface GoodReportViewController ()

@property (nonatomic,strong)OpenBoxReporyView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;
@property (nonatomic,strong)SubmitBtnView* submitView;

@property (nonatomic,strong)NSMutableArray* imageMArr;

@property (nonatomic,strong)NSString* typeOfGoods;  //货物类型
@end

@implementation GoodReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货货物";
    [self setUp];
    [self loadData];
    
    if ([self.model.status isEqual:@0]) {
        [self.view addSubview:self.submitView];
    }
    else{
        
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
-(void)submitReceiveGoodsInfoReport{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.model.id forKey:@"id"];    //工单id
    [para setObject:self.typeOfGoods forKey:@"typeOfGoods"];  //货物类型
    [para setObject:self.boxView.secondText forKey:@"endData"];  //货物日期
    [para setObject:self.boxView.thirdText forKey:@"isSolve"];   //是否缺货
    [para setObject:self.boxView.noteText forKey:@"note"];   //货物问题描述
    
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:UpdateWorkOrder]
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

-(void)closeTransportProblem{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
//    [para setObject:self.goodsId forKey:@"goodsId"];
//    if (self.isReceive) {
//        [para setObject:@"0" forKey:@"type"];
//    }
//    else{
//        [para setObject:@"1" forKey:@"type"];
//    }
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
        _boxView.firstText = @"批量收货";
        _boxView.thirdText = @"0";
        _boxView.noteText = @"";
        _boxView.secondText = [NSDate dateStringWithFormat:@"yyyy-MM-dd"];
        _boxView.leftTitles = [NSMutableArray arrayWithObjects:@"货物类型",@"货物日期",@"是否缺货", nil];
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"批量收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"批量收货";
                weakSelf.typeOfGoods = @"0";
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"开箱收货" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"开箱收货";
                weakSelf.typeOfGoods = @"1";
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"问题货物" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"问题货物";
                weakSelf.typeOfGoods = @"2";
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:action1];
            [alertVc addAction:action2];
            [alertVc addAction:action3];
            
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

-(NSString *)typeOfGoods{
    if (!_typeOfGoods) {
        _typeOfGoods = @"0";
    }
    return _typeOfGoods;
}
@end
