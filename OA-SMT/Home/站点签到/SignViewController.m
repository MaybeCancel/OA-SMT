//
//  SignViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/22.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SignViewController.h"
#import "SignRecodViewController.h"
#import "BaseCell.h"
#import "SignBtnView.h"
#import "StateListViewController.h"
#import "signModel.h"
#import "CCLocationManager.h"
@interface SignViewController ()
@property (nonatomic,strong)signModel* model;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    self.rightItemTitle = @"签到记录";
     __weak typeof(SignViewController*)weakself = self;
    self.rightItemHandle = ^{
        SignRecodViewController* sign = [[SignRecodViewController alloc]init];
        weakself.Hidden_BackTile = YES;
        [weakself pushVC:sign];
    };
    self.dataArray = [NSMutableArray arrayWithObjects:@"站号",@"站名",@"施工类型",@"经度",@"纬度",@"我的位置",@"签到时间", nil];
    [self setUp];
    [self getCurrentInfo];
}
- (void)setUp{
    self.model = [signModel new];
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, 64, ScreenWidth, 8*44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(31, 31, 31);
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    SignBtnView* signBtn = [SignBtnView shareSignBtnView];
    signBtn.frame = RR(0, CGRectGetMaxY(self.tableView.frame) + 32, ScreenWidth, 170);
    [self.view addSubview:signBtn];
    signBtn.signHandle = ^{
        if(self.model.stationName == nil){
            [LoadingView showAlertHUD:@"请选择站名" duration:1];
            return ;
        }
        if(self.model.latitude == nil){
            [LoadingView showAlertHUD:@"位置信息错误,请重新定位" duration:1];
            return ;
        }

        NSDictionary* dic = @{@"stationId":self.model.stationId,
                              @"userId":[Default objectForKey:@"userId"],
                              @"optType":self.model.stationType,
                              @"longtitude":self.model.longitude,
                              @"latitude":self.model.latitude,
                              @"address":self.model.currentLocation,
                              @"signinDate":self.model.currentTime
                              };
        BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:@"account/signIn"] isPost:YES Params:dic];
        [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
            if ([jsonDic[@"message"] isEqualToString:@"OK"]) {
                [LoadingView showAlertHUD:@"签到成功" duration:1];
            }
        }];
    };
    signBtn.reloacationHandle = ^{
        [self getCurrentInfo];
    };
}

- (void)getCurrentInfo{
    CCLocationManager* manager = [CCLocationManager shareManager];
    [manager starUpDataLocation];
    [manager getNewLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
        self.model.longitude = newLongitude;
        self.model.latitude = newLatitude;
        self.model.currentTime = [TimeTools getCurrentTimesWithFormat:@"YYYY-MM-dd hh:mm:ss"];
        CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(placemarks.count>0){
                CLPlacemark* placeMark = placemarks[0];
                self.model.currentLocation = [NSString stringWithFormat:@"%@%@%@",placeMark.administrativeArea,placeMark.locality,placeMark.thoroughfare];
            }
            [self.tableView reloadData];
        }];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 4;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        UIView* view = [[UIView alloc]init];
        view.backgroundColor = RGBColor(241, 241, 241);
        view.frame = RR(0, 0, self.view.width, 44);
        UILabel* label = [[UILabel alloc]init];
        label.frame = RR(13, 15, 120, 14);
        label.textColor = RGBColor(131, 131, 131);
        label.text = @"自动参数";
        [view addSubview:label];
        return view;
    }
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell* cell = [BaseCell nibCellWithTableView:tableView];
    if (indexPath.section == 0) {
         cell.leftString.text = self.dataArray[indexPath.row];
        if(indexPath.row == 0){
            cell.arrowHidden = YES;
            cell.rightString.text = self.model.stationNumber;
        }else if (indexPath.row == 1){
            cell.rightString.text = self.model.stationName;
        }else if (indexPath.row == 2){
            if ([self.model.stationType isEqualToString:@"0"]) {
                 cell.rightString.text = @"新建";
            }else if ([self.model.stationType isEqualToString:@"1"]){
                 cell.rightString.text = @"扩建";
            }
            cell.arrowHidden = YES;
        }
    }else if (indexPath.section == 1){
        cell.leftString.text = self.dataArray[indexPath.row+3];
        cell.userInteractionEnabled = NO;
        cell.arrowHidden = YES;
        if (indexPath.row == 0) {
            cell.rightString.text = self.model.longitude;
        }else if (indexPath.row == 1){
            cell.rightString.text = self.model.latitude;
        }else if (indexPath.row == 2){
            cell.rightString.text = self.model.currentLocation;
        }else if (indexPath.row == 3){
            cell.rightString.text = self.model.currentTime;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //站号
        }else if(indexPath.row == 1){
            //站名
            StateListViewController* list = [[StateListViewController alloc]init];
            self.Hidden_BackTile = YES;
            [self pushVC:list];
            //返回一个Model
            list.stateInfoHandle = ^(StateModel *model) {
                self.model.stationNumber = model.stationCode;
                self.model.stationName = model.stationName;
                self.model.stationType = model.projectType;
                self.model.stationId = model.stationId;
                [self.tableView reloadData];
            };
        }else if (indexPath.row == 2){
            //施工类型
        }
    }
}

@end
