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

@interface QualityDetailViewController ()
@property (nonatomic,strong)QualityReportModel* model;
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)FoldListView* foldListView;
@property (nonatomic,strong)WarningReportView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;

@property (nonatomic,strong)NSArray* leftArray;
@property (nonatomic,strong)NSMutableArray* imageMArr;

@property (nonatomic, assign)int problemType;
@end

@implementation QualityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"告警处理报告";
    self.rightItemTitle = @"提交";
    kWeakSelf(weakSelf);
    self.rightItemHandle = ^{
        [weakSelf uploadImage];
    };
    [self setUp];
    [self loadData];
}
- (void)setUp{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.foldListView];
    [self.scrollView addSubview:self.imageShowView];
    [self.scrollView addSubview:self.boxView];
    [self.scrollView addSubview:self.addImageView];
    
    kWeakSelf(weakSelf);
    [self.imageShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.foldListView.mas_bottom);
        make.left.mas_equalTo(weakSelf.foldListView.mas_left);
        make.right.mas_equalTo(weakSelf.foldListView.mas_right);
        make.height.mas_equalTo(0);
    }];
    
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.imageShowView.mas_bottom);
        make.left.mas_equalTo(weakSelf.imageShowView.mas_left);
        make.right.mas_equalTo(weakSelf.imageShowView.mas_right);
        make.height.mas_equalTo(44*(weakSelf.boxView.leftTitles.count+1)+130);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.boxView.mas_bottom);
        make.left.mas_equalTo(weakSelf.boxView.mas_left);
        make.right.mas_equalTo(weakSelf.boxView.mas_right);
        make.height.mas_equalTo(115);
    }];
}

-(void)loadData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:RectificationInfo]
                                                   isPost:YES
                                                   Params:@{@"id":self.qualityId}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSDictionary* dic = jsonDic[@"result"];
        weakSelf.model = [QualityReportModel ModelWithDic:dic];
        [weakSelf handleCellRightData];
    }];
}

-(void)handleCellRightData{
    for (int index = 0; index < self.leftArray.count; index++) {
        switch (index) {
            case 0:
                [self.dataArray addObject:self.model.projectName];
                break;
            case 1:
                [self.dataArray addObject:self.model.stationName];
                break;
            case 2:
                [self.dataArray addObject:self.model.opinion];
                break;
            case 3:
                [self.dataArray addObject:self.model.inspectDate];
                break;
            case 4:
                [self.dataArray addObject:self.model.inspector];
                break;
        }
    }
    self.foldListView.rightArray = self.dataArray;
    //附件图片
    NSArray *imageArr = @[];
    CGFloat attachmentHeight = 0;
    if (self.model.attachment && self.model.attachment.length) {
        imageArr = [self.model.attachment componentsSeparatedByString:@","];
        attachmentHeight+=(30+imageArr.count*230);
    }
    self.imageShowView.images = imageArr;
    [self.imageShowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(attachmentHeight);
    }];
    self.scrollView.contentSize = CGSizeMake(0, self.foldListView.height+20+ 44*(self.boxView.leftTitles.count+1)+130+attachmentHeight+115);
}

//提交告警处理报告
-(void)submitReceiveGoodsInfoReport:(NSString *)imgs{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.qualityId forKey:@"id"];
    [para setObject:self.boxView.firstText forKey:@"isFinish"];
    [para setObject:self.boxView.noteText forKey:@"question"];
    [para setObject:imgs forKey:@"imgs"];
    [para setObject:[UserDef objectForKey:@"userId"] forKey:@"userId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:UpdateRectificationInfo]
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

//上传告警处理照片
-(void)uploadImage{
    if (self.imageMArr.count > 1) {
        kWeakSelf(weakSelf);
        NSMutableArray *imagePath = [NSMutableArray new];
        for (int i = 0; i < self.imageMArr.count-1; i++) {
            NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",[NSDate dateStringWithFormat:@"HHmmss"],i];
            [BaseRequest UploadImageWithUrl:[CCString getHeaderUrl:UploadFile] image:self.imageMArr[i] fielName:fileName completion:^(NSDictionary *jsonDic) {
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

- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = RGBColor(237, 237, 237);
    }
    return _scrollView;
}
- (FoldListView*)foldListView{
    if (_foldListView == nil) {
        _foldListView = [[FoldListView alloc]init];
        _foldListView.frame = CGRM(0, 0, SCREEN_WIDTH, 44 + self.leftArray.count* 44);
        _foldListView.topTitleString = @"质检反馈";
        _foldListView.leftArray = self.leftArray;
    }
    return _foldListView;
}

-(WarningReportView *)boxView{
    if (!_boxView) {
        _boxView = [[WarningReportView alloc]init];
        _boxView.leftTitles = [NSMutableArray arrayWithObjects:@"整改结果", nil];
        _boxView.headerString = @"整改闭环报告";
        _boxView.textPlaceHolder = @"无";
        _boxView.topTextViewTitle = @"遗留问题";
        _boxView.firstText = @"1";
        _boxView.noteText = @"";
        _boxView.isQualityDetail = YES;
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"有问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"2";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"无问题" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.firstText = @"1";
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

-(NSArray *)leftArray{
    if (!_leftArray) {
        _leftArray = @[@"项目",@"站点",@"问题描述",@"质检日期",@"质检工程师"];
    }
    return _leftArray;
}

-(NSMutableArray *)imageMArr{
    if (!_imageMArr) {
        _imageMArr = [[NSMutableArray alloc]init];
    }
    return _imageMArr;
}
@end
