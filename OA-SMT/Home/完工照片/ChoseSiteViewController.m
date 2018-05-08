//
//  ChoseSiteViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ChoseSiteViewController.h"
#import "SiteInfoModel.h"

@interface ChoseSiteViewController ()
@property (nonatomic,strong)SiteInfoModel* siteModel;
@property (nonatomic,strong)NSMutableArray* stationIdArray;
@end

@implementation ChoseSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self initData];
}

- (void)setUp{
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)initData{
    if (self.infoArray == nil || self.infoArray.count == 0) {
        [LoadingView showAlertHUD:@"暂无数据,请稍后重试" duration:1];
        return;
    }
    self.dataArray = [NSMutableArray new];
    self.stationIdArray = [NSMutableArray new];
    if ([self.siteInfo isEqualToString:@"siteName"]) {
        self.title = @"选择站名";
        for (NSDictionary* dic in self.infoArray) {
            [self.dataArray addObject:dic[@"stationName"]];
        }
        [self.tableView reloadData];
    }else if ([self.siteInfo isEqualToString:@"siteNumber"]){
        self.title = @"选择站号";
        for (NSDictionary* dic in self.infoArray) {
            [self.dataArray addObject:dic[@"stationCode"]];
            [self.stationIdArray addObject:dic[@"stationId"]];
        }
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.siteInfo isEqualToString:@"siteName"]) {
        if (self.siteBack) {
            self.siteBack(self.dataArray[indexPath.row], 2,@"");
        }
    }else if ([self.siteInfo isEqualToString:@"siteNumber"]){
        if (self.siteBack) {
            self.siteBack(self.dataArray[indexPath.row], 1,self.stationIdArray[indexPath.row]);
        }
    }
    [self pop];
}

@end
