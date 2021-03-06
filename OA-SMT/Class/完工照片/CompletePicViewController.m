//
//  CompletePicViewController.m
//  OA-SMT
//
//  Created by Slark on 2017/12/28.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "CompletePicViewController.h"
#import "ListsView.h"
#import "BaseCellView.h"
#import "BaseCell.h"
#import "BottombtnView.h"
#import "LLActionSheetView.h"
#import "ChoseSiteViewController.h"
#import "CCLocationManager.h"
#import "SiteInfoModel.h"
#import "ShootPicViewController.h"
#import "ShootDawnViewController.h"
#import "PostListViewController.h"
#import "HasUploadViewController.h"
#import "DeviceModel.h"

@interface CompletePicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, strong) NSMutableArray* rightArray;
@property (nonatomic, strong) SiteInfoModel* siteModel;
@property (nonatomic, strong) ListsView* lists;
@property (nonatomic, strong) BaseCellView * cellView;
@property (nonatomic, strong) BottombtnView* bottomView;
@property (nonatomic, assign) BOOL isLocation;

/** 设备部位照片数组*/
@property (nonatomic,strong)NSMutableArray* deviceArray;
/** 拍摄成功待上传照片数组*/
@property (nonatomic,strong)NSMutableArray* uploadMArr;
/** 已上传照片数组*/
@property (nonatomic,strong)NSMutableArray* hasUploadMArr;
@end

@implementation CompletePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*站点Model初始化*/
    self.siteModel = [[SiteInfoModel alloc]init];
    self.siteModel.objectType = @"新建";
    self.siteModel.objectName =  self.model.projectName;
    self.siteModel.projectId = self.model.projectId;
    self.title = @"完工照片";
    [self setUpUI];
    [self adminData];
    [self loadData];
    [self loadDevicePic];
  
//    kWeakSelf(weakSelf);
//    self.rightItemTitle = @"拍摄情况";
//    self.rightItemHandle = ^{
//        ShootDawnViewController* dawn = [[ShootDawnViewController alloc]init];
//        weakSelf.Hidden_BackTile = YES;
//        [weakSelf pushVC:dawn];
//    };
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.bottomView setUploadNum:(int)self.uploadMArr.count hasUploadNum:(int)self.hasUploadMArr.count];
}

/** 设备以及照片部位*/
- (void)loadDevicePic{
    self.deviceArray = [NSMutableArray new];
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetPhotoDevices] isPost:YES Params:@{@"stationId":@"0"}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* array = jsonDic[@"result"];
        for (NSDictionary* dic in array) {
            DeviceModel* model = [DeviceModel ModelWithDic:dic];
            [self.deviceArray addObject:model];
        }
        self.lists.dataArray = self.deviceArray;
    }];
}

- (void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetStationData] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* jsonArray = jsonDic[@"result"];
        if (jsonArray.count) {
            for (NSDictionary *dic in jsonArray) {
                NSString *projectId = [NSString stringWithFormat:@"%@",dic[@"projectId"]];
                if ([projectId isEqualToString:self.model.projectId]) {
                    self.siteModel.stationInfoArray = dic[@"stations"];
                }
            }
        }
        self.siteModel.steering = [UserDef objectForKey:@"userName"];
        [self.tableView reloadData];
    }];
}

//获取时间等默认静态信息
- (void)adminData{
    [self getLocationInfo];
}

//获取定位信息
- (void)getLocationInfo{
    kWeakSelf(weakSelf);
    self.siteModel.shootingTime = [TimeTools getCurrentTimesWithFormat:@"YYYY-MM-dd HH:mm:ss"];
    CCLocationManager* manager = [CCLocationManager shareManager];
    [manager starUpDataLocation];
    [manager getNewLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
        CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(placemarks.count>0){
                CLPlacemark* placeMark = placemarks[0];
                weakSelf.siteModel.longitude = newLongitude;
                weakSelf.siteModel.latitude = newLatitude;
                //省-市-区-街道-号牌
                weakSelf.siteModel.myLocation = [NSString stringWithFormat:@"%@%@%@",placeMark.administrativeArea,placeMark.locality,placeMark.name];
                [UserDef setObject:weakSelf.siteModel.myLocation forKey:@"myLocation"];
                [LoadingView showAlertHUD:@"定位成功" duration:1];
                weakSelf.isLocation = YES;
                [weakSelf.tableView reloadData];
            }
        }];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.lists hiddenTable];
}

- (void)setUpUI{
    
    [self.view addSubview:self.lists];
    
    // 站号_站名_照片部位[具体角度]
    [self.view addSubview:self.cellView];
    
    [self.view addSubview:self.bottomView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cellView.frame), self.view.width, 10*40) style:UITableViewStylePlain];
    self.tableView.separatorStyle =UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"项目名称",@"站号",@"站名",@"督导",@"经度",@"纬度",@"我的位置",@"拍摄时间", nil];
}

#pragma mark
#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell* cell = [BaseCell nibCellWithTableView:tableView];
    cell.leftString.text =self.dataArray[indexPath.row];
    cell.userInteractionEnabled = NO;
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.arrowImage.hidden = NO;
        cell.userInteractionEnabled = YES;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.rightString.text = self.siteModel.objectName;
            break;
        case 1:
            cell.rightString.text = self.siteModel.siteNumber;
            break;
        case 2:
            cell.rightString.text = self.siteModel.siteName;
            break;
        case 3:  //督导
            cell.rightString.text = self.siteModel.steering;
            break;
        case 4:  //经度
            cell.rightString.text = self.siteModel.longitude;
            break;
        case 5:  //纬度
            cell.rightString.text = self.siteModel.latitude;
            break;
        case 6:  //我的位置
            cell.rightString.font = [UIFont systemFontOfSize:15];
            cell.rightString.text = self.siteModel.myLocation;
            break;
        case 7: //拍摄时间
            cell.rightString.text = self.siteModel.shootingTime;
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark
#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = RGBColor(241, 241, 241);
    view.frame = CGRM(0, 0, self.view.width, 44);
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRM(13, 15, 120, 14);
    label.textColor = RGBColor(131, 131, 131);
    label.text = @"自动参数";
    [view addSubview:label];
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = RGBColor(241, 241, 241);
    view.frame = CGRM(0, 0, self.view.width, 44);
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRM(13, 15, 130, 14);
    label.textColor = RGBColor(131, 131, 131);
    label.text = @"当前定位信号弱:";
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"去重新定位" forState:UIControlStateNormal];
    btn.frame = CGRM(CGRectGetMaxX(label.frame), 15, 120, 14);
    [btn setTitleColor:RGBColor(56, 117, 231) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapdown:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [view addSubview:label];
    return view;
}
- (void)tapdown:(UIButton*)btn{
    [self getLocationInfo];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChoseSiteViewController* site = [[ChoseSiteViewController alloc]init];
    kWeakSelf(weakSelf);
    site.siteBack = ^(NSDictionary *siteDic){
        weakSelf.siteModel.siteNumber = siteDic[@"stationCode"];
        weakSelf.siteModel.stationId = siteDic[@"stationId"];
        weakSelf.siteModel.siteName = siteDic[@"stationName"];
        [weakSelf.tableView reloadData];
    };
    
    site.infoArray = self.siteModel.stationInfoArray;
    site.stationId = self.model.stationId;
    self.Hidden_BackTile = YES;
    if (indexPath.row == 2) {
        site.siteInfo = @"siteName";
        [self pushVC:site];
    }else if (indexPath.row == 1){
        site.siteInfo = @"siteNumber";
        [self pushVC:site];
    }
}

#pragma mark
#pragma mark -- LazyLoad

-(ListsView *)lists{
    if (!_lists) {
        _lists = [[ListsView alloc]initWithTitle:@"设备及照片部位" imageName:@"btn_listD"];
        _lists.frame = CGRM(0, 64, SCREEN_WIDTH, 44);
        kWeakSelf(weakSelf);
        _lists.picPositionAction = ^(NSString* devicePart,NSString *detaiPart,NSString* deviceId,NSString* position) {
            weakSelf.siteModel.PicPosition = devicePart;
            weakSelf.siteModel.detaiPart = detaiPart;
            weakSelf.siteModel.deviceId = deviceId;
            weakSelf.siteModel.positionId = position;;
            weakSelf.lists.rightString = [NSString stringWithFormat:@"%@[%@]",devicePart,detaiPart];
            [weakSelf.tableView reloadData];
        };
    }
    return _lists;
}

-(BaseCellView *)cellView{
    if (!_cellView) {
        _cellView = [[BaseCellView alloc]init];
        _cellView.frame = CGRM(0, CGRectGetMaxY(self.lists.frame)+15, self.view.width, 44);
        _cellView.leftString = @"工程类型";
        _cellView.rightString = self.siteModel.objectType;
        kWeakSelf(weakSelf);
        _cellView.TapHandle = ^{
            LLActionSheetView* sheet = [[LLActionSheetView alloc]initWithTitleArray:@[@"新建",@"扩容"] andShowCancel:YES];
            [sheet show];
            sheet.ClickIndex = ^(NSInteger index) {
                if (index == 2) {//扩容
                    weakSelf.siteModel.objectType = @"扩容";
                }else if (index ==1){//新建
                    weakSelf.siteModel.objectType = @"新建";
                }
                [weakSelf.tableView reloadData];
            };
        };
    }
    return _cellView;
}

-(BottombtnView *)bottomView{
    if (!_bottomView) {
        _bottomView = [BottombtnView shareBottomBtnView];
        _bottomView.frame = CGRM(0, self.view.height - 90, self.view.width, 90);
        kWeakSelf(weakSelf);
        //开始拍照的回调
        _bottomView.topBottombtnHandle = ^{
            /**
             1.定位必须成功
             2.照片部位
             3.工程类型
             4.项目名称
             5.站号,站点信息
             6.当前时间
             */
            if (!weakSelf.isLocation||!weakSelf.siteModel.PicPosition||!weakSelf.siteModel.objectType||!weakSelf.siteModel.siteName||!weakSelf.siteModel.siteNumber||!weakSelf.siteModel.objectName) {
                [LoadingView showAlertHUD:@"请完善信息!!" duration:1];
                return ;
            }
            ShootPicViewController* shoot = [[ShootPicViewController alloc]init];
            shoot.siteModel = weakSelf.siteModel;
            [weakSelf presentToVC:shoot];
            shoot.shootPicHandle = ^(UIImage *image) {
                NSLog(@"照片部位:~~~~%@",image.devicePicPart);
                [weakSelf.uploadMArr addObject:image];
            };
        };
        
        //待上传的回调
        _bottomView.leftBottombtnHandle = ^{
            if (weakSelf.uploadMArr.count == 0) {
                [LoadingView showAlertHUD:@"请您先拍照" duration:1];
                return ;
            }
            PostListViewController* listView = [[PostListViewController alloc]init];
            listView.shootedArray = weakSelf.uploadMArr;
            listView.hasUploadMArr = weakSelf.hasUploadMArr;
            listView.model = weakSelf.model;
            listView.refreshBlock = ^{
                if (weakSelf.refreshBlock) {
                    weakSelf.refreshBlock();
                }
            };
            [weakSelf pushVC:listView];
        };
        
        //已上传的回调
        _bottomView.rightBottombtnHandle = ^{
//            if (weakSelf.hasUploadMArr.count == 0) {
//                [LoadingView showAlertHUD:@"暂无已上传照片" duration:1];
//                return ;
//            }
            HasUploadViewController* listView = [[HasUploadViewController alloc]init];
            listView.projectId = weakSelf.siteModel.projectId;
            NSString *stationId = @"";
            for (NSDictionary *dic in weakSelf.siteModel.stationInfoArray) {
                stationId = [NSString stringWithFormat:@"%@,%@",dic[@"stationId"],stationId];
            }
            if (stationId.length > 0) {
                stationId = [stationId substringToIndex:stationId.length-1];
            }
            listView.stationId = stationId;
            [weakSelf pushVC:listView];
        };
    }
    return _bottomView;
}

-(NSMutableArray *)uploadMArr{
    if (!_uploadMArr) {
        _uploadMArr = [NSMutableArray new];
    }
    return _uploadMArr;
}

-(NSMutableArray *)hasUploadMArr{
    if (!_hasUploadMArr) {
        _hasUploadMArr = [NSMutableArray new];
    }
    return _hasUploadMArr;
}


@end
