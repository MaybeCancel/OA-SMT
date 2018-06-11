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
#import "StationTypeController.h"

@interface SignViewController ()
@property (nonatomic,strong)signModel* model;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    self.rightItemTitle = @"签到记录";
    kWeakSelf(weakSelf);
    self.rightItemHandle = ^{
        SignRecodViewController* sign = [[SignRecodViewController alloc]init];
        weakSelf.Hidden_BackTile = YES;
        [weakSelf pushVC:sign];
    };
    self.dataArray = [NSMutableArray arrayWithObjects:@"站号",@"站名",@"施工类型",@"经度",@"纬度",@"我的位置",@"签到时间", nil];
    [self setUp];
    [self getCurrentInfo];
}
- (void)setUp{
    self.model = [signModel new];
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, 8*44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(31, 31, 31);
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    SignBtnView* signBtn = [SignBtnView shareSignBtnView];
    signBtn.frame = CGRM(0, CGRectGetMaxY(self.tableView.frame) + 32, SCREEN_WIDTH, 170);
    [self.view addSubview:signBtn];
    
    kWeakSelf(weakSelf);
    signBtn.signHandle = ^{
        if(weakSelf.model.stationName == nil){
            [LoadingView showAlertHUD:@"请选择站名" duration:1];
            return ;
        }
        else if(weakSelf.model.latitude == nil){
            [LoadingView showAlertHUD:@"位置信息错误,请重新定位" duration:1];
            return ;
        }
        else if(weakSelf.model.stationId == nil){
            [LoadingView showAlertHUD:@"请选择施工类型" duration:1];
            return ;
        }
        [LoadingView showProgressHUD:@""];
        NSDictionary* dic = @{@"stationId":weakSelf.model.stationId,
                              @"userId":[UserDef objectForKey:@"userId"],
                              @"optType":weakSelf.model.stationType,
                              @"longitude":weakSelf.model.longitude,
                              @"latitude":weakSelf.model.latitude,
                              @"address":weakSelf.model.currentLocation,
                              @"signinDate":weakSelf.model.currentTime
                              };
        BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:SignIn] isPost:YES Params:dic];
        [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
            if ([jsonDic[@"message"] isEqualToString:@"OK"]) {
                [LoadingView showAlertHUD:@"签到成功" duration:1];
            }
            else if(jsonDic[@"message"]){
                [LoadingView showAlertHUD:jsonDic[@"message"] duration:1];
            }
        }];
    };
    
    signBtn.reloacationHandle = ^{
        [weakSelf getCurrentInfo];
    };
}

- (void)getCurrentInfo{
    kWeakSelf(weakSelf);
    CCLocationManager* manager = [CCLocationManager shareManager];
    [manager starUpDataLocation];
    [manager getNewLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
        weakSelf.model.longitude = newLongitude;
        weakSelf.model.latitude = newLatitude;
        weakSelf.model.currentTime = [TimeTools getCurrentTimesWithFormat:@"YYYY-MM-dd hh:mm:ss"];
        CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(placemarks.count>0){
                CLPlacemark* placeMark = placemarks[0];
                weakSelf.model.currentLocation = [NSString stringWithFormat:@"%@%@%@",placeMark.administrativeArea,placeMark.locality,placeMark.thoroughfare];
            }
            [weakSelf.tableView reloadData];
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
        view.frame = CGRM(0, 0, self.view.width, 44);
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRM(13, 15, 120, 14);
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
            cell.rightString.text = self.model.stationTypeStr;
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
            kWeakSelf(weakSelf);
            list.stateInfoHandle = ^(StateModel *model) {
                weakSelf.model.stationNumber = model.stationCode;
                weakSelf.model.stationName = model.stationName;
                weakSelf.model.stationId = model.stationId;
                [weakSelf.tableView reloadData];
            };
        }else if (indexPath.row == 2){
            //施工类型
            StationTypeController *vc = [[StationTypeController alloc]init];
            kWeakSelf(weakSelf);
            vc.stationTypeBlock = ^(NSString *stationType, int type) {
                weakSelf.model.stationType = [NSString stringWithFormat:@"%d",type];
                weakSelf.model.stationTypeStr = stationType;
                [weakSelf.tableView reloadData];
            };
            [self pushVC:vc];
        }
    }
}

-(signModel *)model{
    if (!_model) {
        _model = [[signModel alloc]init];
        _model.stationType = @"1";
        _model.stationTypeStr = @"安装";
    }
    return _model;
}

@end
