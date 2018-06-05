//
//  ConstructionTypeController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "StationTypeController.h"

@interface StationTypeController ()

@end

@implementation StationTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"施工类型";
    [self.dataArray addObjectsFromArray:@[@"验货",@"安装",@"调测",@"整改",@"其他"]];
    [self setupUI];
}

-(void)setupUI{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, self.dataArray.count*44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(31, 31, 31);
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.stationTypeBlock) {
        self.stationTypeBlock(self.dataArray[indexPath.row], (int)indexPath.row);
        [self pop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
