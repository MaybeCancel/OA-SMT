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
#import "DeviceModel.h"
@interface CompletePicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, strong) NSMutableArray* rightArray;
@property (nonatomic, strong) SiteInfoModel* siteModel;
@property (nonatomic, strong) ListsView* lists;
@property (nonatomic, assign) BOOL isLocation;

/** 设备部位照片数组*/
@property (nonatomic,strong)NSMutableArray* deviceArray;
/** 拍摄成功照片数组*/
@property (nonatomic,strong)NSMutableArray* shootedArray;
@end

@implementation CompletePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*站点Model初始化*/
    self.siteModel = [[SiteInfoModel alloc]init];
    self.siteModel.objectType = @"新建";
    /*拍摄成功数组初始化*/
    self.shootedArray = [NSMutableArray new];
    self.title = @"完工照片";
    self.rightItemTitle = @"拍摄情况";
    [self setUpUI];
    [self adminData];
    [self loadData];
    [self loadDevicePic];
  
    kWeakSelf(weakSelf);
    self.rightItemHandle = ^{
        ShootDawnViewController* dawn = [[ShootDawnViewController alloc]init];
        weakSelf.Hidden_BackTile = YES;
        [weakSelf pushVC:dawn];
    };
    
  
}
/** 设备以及照片部位*/
- (void)loadDevicePic{
    self.deviceArray = [NSMutableArray new];
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
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetStationData] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* jsonArray = jsonDic[@"result"];
        NSDictionary* resultDic = jsonArray.firstObject;
        self.siteModel.objectName =  resultDic[@"projectName"];
        self.siteModel.stationInfoArray = resultDic[@"stations"];
        self.siteModel.projectId = resultDic[@"projectId"];
        [self.tableView reloadData];
    }];
}

//获取时间等默认静态信息
- (void)adminData{
    [self getLocationInfo];
}
//获取定位信息
- (void)getLocationInfo{
    self.siteModel.shootingTime = [TimeTools getCurrentTimesWithFormat:@"YYYY-MM-dd HH:mm:ss"];
    CCLocationManager* manager = [CCLocationManager shareManager];
    [manager starUpDataLocation];
    [manager getNewLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
        CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(placemarks.count>0){
                CLPlacemark* placeMark = placemarks[0];
                self.siteModel.longitude = newLongitude;
                self.siteModel.latitude = newLatitude;
                self.siteModel.myLocation = [NSString stringWithFormat:@"%@%@%@",placeMark.administrativeArea,placeMark.locality,placeMark.thoroughfare];
                [UserDef setObject:self.siteModel.myLocation forKey:@"myLocation"];
                [LoadingView showAlertHUD:@"定位成功" duration:1];
                self.isLocation = YES;
                NSLog(@"~~~~~~~%@",self.siteModel.myLocation);
                [self.tableView reloadData];
            }
        }];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.lists hiddenTable];
}

- (void)setUpUI{
    kWeakSelf(weakSelf);
    self.lists = [[ListsView alloc]initWithTitle:@"设备及照片部位" imageName:@"btn_listD"];
    self.lists.frame = CGRM(0, 64, SCREEN_WIDTH, 44);
    [self.view addSubview:self.lists];
    self.lists.picPositionAction = ^(NSString* devicePart,NSString *detaiPart,NSString* deviceId,NSString* position) {
        weakSelf.siteModel.PicPosition = devicePart;
        weakSelf.siteModel.detaiPart = detaiPart;
        weakSelf.siteModel.deviceId = deviceId;
        weakSelf.siteModel.positionId = position;;
        weakSelf.lists.rightString = [NSString stringWithFormat:@"%@[%@]",devicePart,detaiPart];
        [weakSelf.tableView reloadData];
    };
    
    // 站号_站名_照片部位[具体角度]
    BaseCellView * cellView = [[BaseCellView alloc]init];
    cellView.frame = CGRM(0, CGRectGetMaxY(self.lists.frame)+15, self.view.width, 44);
    cellView.leftString = @"工程类型";
    cellView.rightString = self.siteModel.objectType;
    [self.view addSubview:cellView];
    
    cellView.TapHandle = ^{
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cellView.frame), self.view.width, 10*44) style:UITableViewStylePlain];
    self.tableView.separatorStyle =UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"项目名称",@"站号",@"站名",@"督导",@"经度",@"纬度",@"我的位置",@"拍摄时间", nil];
    
    BottombtnView* bottomView = [BottombtnView shareBottomBtnView];
    bottomView.frame = CGRM(0, self.view.height - 50, self.view.width, 50);
    [self.view addSubview:bottomView];
    bottomView.leftBottombtnHandle = ^{
        /**
         1.定位必须成功
         2.照片部位
         3.工程类型
         4.项目名称
         5.站号,站点信息
         6.当前时间
         */
        if (!self.isLocation||!self.siteModel.PicPosition||!self.siteModel.objectType||!self.siteModel.siteName||!self.siteModel.siteNumber||!self.siteModel.objectName) {
            [LoadingView showAlertHUD:@"请完善信息!!" duration:1];
            return ;
        }
        ShootPicViewController* shoot = [[ShootPicViewController alloc]init];
        shoot.siteModel = self.siteModel;
        [self presentToVC:shoot];
        shoot.shootPicHandle = ^(UIImage *image) {
            NSLog(@"照片部位:~~~~%@",image.devicePicPart);
            [self.shootedArray addObject:image];
        };
    };
    bottomView.rightBottombtnHandle = ^{
        if (self.shootedArray.count == 0) {
            [LoadingView showAlertHUD:@"请您先拍照" duration:1];
            return ;
        }
        PostListViewController* list = [[PostListViewController alloc]init];
        self.Hidden_BackTile = YES;
        list.shootedArray = self.shootedArray;
        [self pushVC:list];
    };
    
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
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
            cell.rightString.text = self.siteModel.siteName;
            break;
        case 4:  //经度
            cell.rightString.text = self.siteModel.longitude;
            break;
        case 5:  //纬度
            cell.rightString.text = self.siteModel.latitude;
            break;
        case 6:  //我的位置
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
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
    self.Hidden_BackTile = YES;
    if (indexPath.row == 2) {
        site.siteInfo = @"siteName";
        [self pushVC:site];
    }else if (indexPath.row == 1){
        site.siteInfo = @"siteNumber";
        [self pushVC:site];
    }
}

@end
