//
//  ProblemTypeViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProblemTypeViewController.h"
#import "ProblemTypeCell.h"
@interface ProblemTypeViewController ()

@end

@implementation ProblemTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"遗留问题类型";
    [self setupUI];
    [self makeData];
}

-(void)setupUI{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)makeData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Alarm" ofType:@"plist"];
    self.dataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemTypeCell* cell = [ProblemTypeCell nibCellWithTableView:tableView];
    cell.alarmTypeLab.text = [self.dataArray[indexPath.row] objectForKey:@"alarm_type"];
    cell.alarmDescribeLab.text = [NSString stringWithFormat:@"建议故障处理方法：%@",[self.dataArray[indexPath.row] objectForKey:@"alarm_describe"]];
    if (self.selectedIndex == indexPath.row) {
        cell.selectImg.hidden = NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.problemTypeBlock) {
        self.problemTypeBlock([self.dataArray[indexPath.row] objectForKey:@"alarm_type"], (int)indexPath.row);
        [self pop];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
