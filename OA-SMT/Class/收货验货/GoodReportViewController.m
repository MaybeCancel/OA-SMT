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
#import "FoldListView.h"
#import "AddImageView.h"
#import "ImageShowView.h"

@interface GoodReportViewController ()

@property (nonatomic,strong)ReportModel* model;
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)FoldListView* foldListView;
@property (nonatomic,strong)OpenBoxReporyView* boxView;
@property (nonatomic,strong)AddImageView* addImageView;
@property (nonatomic,strong)ImageShowView* imageShowView;

@property (nonatomic,strong)NSArray* leftArray;
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
        self.foldListView.topTitleString = @"收货报告";
        self.boxView.leftTitles = [NSMutableArray arrayWithObjects:@"实际到达日期",@"是否缺货", nil];
        self.boxView.headerString = @"收货报告";
    }
    else{
        self.title = @"开箱报告";
        self.foldListView.topTitleString = @"到货电子清单";
        self.boxView.leftTitles = [NSMutableArray arrayWithObjects:@"开箱日期",@"是否缺换货", nil];
        self.boxView.headerString = @"开箱报告";
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
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.foldListView];
    [self.scrollView addSubview:self.boxView];
    [self.scrollView addSubview:self.addImageView];
    [self.scrollView addSubview:self.imageShowView];

    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.foldListView.mas_bottom);
        make.left.mas_equalTo(weakSelf.foldListView.mas_left);
        make.right.mas_equalTo(weakSelf.foldListView.mas_right);
        make.height.mas_equalTo(44*(weakSelf.boxView.leftTitles.count+1)+130);
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

- (void)loadData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:ReceiveGoodsInfo]
                                                   isPost:YES
                                                   Params:@{@"goodsId":self.goodsId}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSDictionary* dic = jsonDic[@"result"];
        weakSelf.model = [ReportModel ModelWithDic:dic];
        [weakSelf handleCellRightData];
    }];
}

-(void)handleCellRightData{
    for (int index = 0; index < self.leftArray.count; index++) {
        switch (index) {
            case 0:
                [self.dataArray addObject:self.model.city];
                break;
            case 1:
                [self.dataArray addObject:self.model.province];
                break;
            case 2:
                [self.dataArray addObject:self.model.clientName];
                break;
            case 3:
                [self.dataArray addObject:self.model.networkType];
                break;
            case 4:
                [self.dataArray addObject:self.model.projectName];
                break;
            case 5:
                [self.dataArray addObject:self.model.poCode];
                break;
            case 6:
                [self.dataArray addObject:self.model.orderCode];
                break;
            case 7:
                [self.dataArray addObject:self.model.logisticsCode];
                break;
            case 8:
                [self.dataArray addObject:self.model.stationName];
                break;
            case 9:
                [self.dataArray addObject:self.model.freightCode];
                break;
            case 10:
                [self.dataArray addObject:self.model.packageCode];
                break;
            case 11:
                [self.dataArray addObject:self.model.packageNum];
                break;
            case 12:
                [self.dataArray addObject:self.model.level];
                break;
            case 13:
                [self.dataArray addObject:self.model.modelCode];
                break;
            case 14:
                [self.dataArray addObject:self.model.note];
                break;
            case 15:
                [self.dataArray addObject:self.model.totalCount];
                break;
            case 16:
                [self.dataArray addObject:self.model.serialCode];
                break;
        }
    }
    self.foldListView.rightArray = self.dataArray;
    if (self.status != 0) {
        self.boxView.firstText = self.model.optDate;
        self.boxView.secondText = self.model.hasProblem;
        self.boxView.noteText = self.model.optNote;
        
        self.addImageView.hidden = YES;
        NSArray *imageArr = [self.model.imgs componentsSeparatedByString:@","];
        self.imageShowView.images = imageArr;
        self.scrollView.contentSize = CGSizeMake(0, self.foldListView.height+20+ 44*(self.boxView.leftTitles.count+1)+130+230*imageArr.count);
    }
    else{
        self.imageShowView.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(0, self.foldListView.height+20+ 44*(self.boxView.leftTitles.count+1)+130+115);
    }
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
    self.scrollView.contentSize = CGSizeMake(0, self.foldListView.height+20+ self.boxView.height+self.addImageView.height);
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

-(FoldListView *)foldListView{
    if (!_foldListView) {
        _foldListView = [[FoldListView alloc]init];
        _foldListView.frame = CGRM(0, 0, SCREEN_WIDTH, self.leftArray.count*44 + 44);
        _foldListView.leftArray = self.leftArray;
        kWeakSelf(weakSelf);
        _foldListView.foldActionBlock = ^(CGFloat diffHeight) {
            weakSelf.scrollView.contentSize = CGSizeMake(0, weakSelf.scrollView.contentSize.height + diffHeight);
        };
    }
    return _foldListView;
}

-(OpenBoxReporyView *)boxView{
    if (!_boxView) {
        _boxView = [[OpenBoxReporyView alloc]init];
        _boxView.textPlaceHolder = @"无";
        _boxView.topTextViewTitle = @"货物问题描述";
        _boxView.secondText = @"0";
        _boxView.noteText = @"";
        _boxView.firstText = [NSDate dateStringWithFormat:@"yyyy-MM-dd"];
        kWeakSelf(weakSelf);
        _boxView.firstClickBlock = ^{
            PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
            datePickManager.datePicker.datePickerMode = PGDatePickerModeDate;
            datePickManager.datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
                NSLog(@"dateComponents = %@", dateComponents);
                NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
                weakSelf.boxView.firstText = date;
            };
            [weakSelf presentToVC:datePickManager];
        };
        _boxView.secondClickBlock = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }];
            UIAlertAction *problem = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.secondText = @"1";
            }];
            UIAlertAction *noProblem = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                weakSelf.boxView.secondText = @"0";
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
        _leftArray = @[@"区域",@"省",@"运营商",@"网络制式",@"项目",@"客户PO号",@"内部订单号",@"物流号",@"站点",@"货运号",@"箱号",@"箱数",@"级别",@"产品型号",@"描述",@"箱内数量",@"序列号"];
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
