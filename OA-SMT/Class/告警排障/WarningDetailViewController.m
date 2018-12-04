//
//  WarningDetailViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WarningDetailViewController.h"
#import "ReportModel.h"
#import "WarningReportView.h"
#import "FoldListView.h"
#import "AddImageView.h"
#import "ImageShowView.h"
#import "WarningInfoModel.h"
#import "ProblemTypeViewController.h"
#import "SubmitBtnView.h"
#import "ShootPhotoViewController.h"

@interface WarningDetailViewController ()
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)WarningReportView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;
@property (nonatomic,strong)SubmitBtnView* submitView;
@property (nonatomic,strong)NSMutableArray* imageMArr;
@end

@implementation WarningDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"告警处理";
    [self setUp];
    
    if (![self.model.status isEqual:@0]) {
    
        self.boxView.firstText = [self.model.isSolve isEqual:@0] ? @"0" : @"1";
        self.boxView.noteText = self.model.note;
        
        self.addImageView.hidden = YES;
        self.submitView.hidden = YES;
        self.boxView.userInteractionEnabled = NO;
        
        self.imageShowView.images = self.model.imageArr;
        self.scrollView.contentSize = CGSizeMake(0,44*self.boxView.leftTitles.count+130+230*self.model.imageArr.count);
    }
}
- (void)setUp{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageShowView];
    [self.scrollView addSubview:self.boxView];
    [self.scrollView addSubview:self.addImageView];
    [self.view addSubview:self.submitView];
    
    kWeakSelf(weakSelf);
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.scrollView.mas_top);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(44*weakSelf.boxView.leftTitles.count+130);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.boxView.mas_left);
        make.right.mas_equalTo(weakSelf.boxView.mas_right);
        make.height.mas_equalTo(115);
    }];
    
    [self.imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
    }];
}

//提交告警处理报告
-(void)submitReceiveGoodsInfoReport{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSString *status = [self.boxView.firstText isEqualToString:@"0"] ? @"1" : @"2";
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.model.id forKey:@"id"];
    [para setObject:self.boxView.firstText forKey:@"isSolve"];
    [para setObject:self.boxView.noteText forKey:@"note"];
    [para setObject:status forKey:@"status"];
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

//上传告警处理照片
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
#pragma mark -- LazyLoad

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = RGBColor(237, 237, 237);
    }
    return _scrollView;
}

-(WarningReportView *)boxView{
    if (!_boxView) {
        _boxView = [[WarningReportView alloc]init];
        _boxView.leftTitles = [NSMutableArray arrayWithObjects:@"是否解决", nil];
        _boxView.textPlaceHolder = @"无";
        _boxView.topTextViewTitle = @"遗留问题";
        _boxView.firstText = @"1";
        _boxView.noteText = @"";
        _boxView.isQualityDetail = NO;
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"1";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
            ShootPhotoViewController* shoot = [[ShootPhotoViewController alloc]init];
            [weakSelf presentToVC:shoot];
            shoot.shootPicHandle = ^(UIImage *image) {
                [weakSelf saveImageToPhotoAlbum:image];
                [weakSelf.imageMArr addObject:image];
                weakSelf.addImageView.images = weakSelf.imageMArr;
            };
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
