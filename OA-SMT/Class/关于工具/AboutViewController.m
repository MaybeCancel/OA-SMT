//
//  AboutViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/25.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "AboutViewController.h"
#import "BaseCell.h"
#import "ResetPasswordViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *appVersionLab;
@property (weak, nonatomic) IBOutlet UILabel *companyInfoLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray* dataSource;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
}

-(void)setupSubviews{
    self.appVersionLab.text = [NSString stringWithFormat:@"ESMT Ver%@",AppVersion];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableview.separatorStyle =UITableViewCellSelectionStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.bounces = NO;
    [self.backView addSubview:self.tableview];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = self.view.backgroundColor;
    [self.backView addSubview:lineView];
    
    kWeakSelf(weakSelf);
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(weakSelf.backView.mas_left);
        make.right.mas_equalTo(weakSelf.backView.mas_right);
        make.height.mas_equalTo(44*weakSelf.dataSource.count);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.tableview.mas_top);
        make.left.mas_equalTo(weakSelf.backView.mas_left);
        make.right.mas_equalTo(weakSelf.backView.mas_right);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark
#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell* cell = [BaseCell nibCellWithTableView:tableView];
    cell.leftString.font = [UIFont systemFontOfSize:15];
    cell.leftString.text =self.dataSource[indexPath.row];
    return cell;
}

#pragma mark
#pragma mark -- UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ResetPasswordViewController *vc = [ResetPasswordViewController new];
        [self pushVC:vc];
    }
    else{
        [self showToast:1.5 withMessage:@"此功能暂未开放"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark -- LazyLoad

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"修改密码"];
    }
    return _dataSource;
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
