//
//  SiteTestDetailViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SiteTestDetailViewController.h"
#import "ProblemViewController.h"
#import "InstallReportCell.h"
#import "CellStateModel.h"

@interface SiteTestDetailViewController ()<LMJDropdownMenuDelegate>
{
//    NSTimer *_timer;
//    BOOL _isSelected;
    NSString *_stationId;
}
@property (nonatomic,strong) NSMutableArray *reportMArr;
@property (nonatomic,strong) NSMutableArray *problemMArr;
@property (nonatomic,strong) NSMutableArray *testInfoArr;
@property (nonatomic,strong) NSArray *stationNameArr;
@property (nonatomic,strong) NSArray *stationIdArr;
@property (nonatomic,strong) LMJDropdownMenu *dropDownView;
@end

@implementation SiteTestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GSM调测检查报告";
//    _timer = [NSTimer scheduledTimerWithTimeInterval:IntervalTime target:self selector:@selector(changeSelectedTimer) userInfo:nil repeats:YES];
//    _isSelected = YES;
    
    self.stationNameArr = [self.model.stationName componentsSeparatedByString:@","];
    self.stationIdArr = [self.model.stationId componentsSeparatedByString:@","];
    _stationId = self.stationIdArr[0];
    
    kWeakSelf(weakSelf);
    if ([self.model.status isEqual:@0] || [self.model.status isEqual:@1]) {   //未开始、进行中
        self.rightItemTitle = @"保存";
        self.rightItemHandle = ^{
            [weakSelf uploadReport];
        };
        [self setupUI];
        [self loadData];
    }
    else{   //已完成
        [self setupUI];
        [self loadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if (_timer.isValid) {
//        [_timer invalidate];
//    }
//    _timer = nil;
}

-(void)setupUI{
    [self.view addSubview:self.dropDownView];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, HEIGHT(self.dropDownView)+64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)loadData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setObject:[UserDef objectForKey:@"userId"] forKey:@"userId"];
    [para setObject:self.model.projectId forKey:@"projectId"];
    [para setObject:_stationId forKey:@"stationId"];
    [para setObject:@"3" forKey:@"type"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetReportInfoV2] isPost:YES Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"result:%@",jsonDic);
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            weakSelf.testInfoArr = jsonDic[@"result"];
            [weakSelf makeData];
        }
        else{
            [weakSelf makeData];
        }
    }];
}

- (void)makeData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SiteTestReport" ofType:@"plist"];
    
    self.dataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    [self.reportMArr removeAllObjects];
    
    kWeakSelf(weakSelf);
    [self.dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *rowArr = obj[@"list"];
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < rowArr.count; i++) {
            NSString *massgeNumber = [NSString stringWithFormat:@"%lu.%d",idx+1,i+1];
            NSDictionary *infoDic = @{};
            for (NSDictionary *dic in weakSelf.testInfoArr) {
                NSString *numberStr = [NSString stringWithFormat:@"%@",dic[@"massgeNumber"]];
                if ([numberStr isEqualToString:massgeNumber]) {
                    infoDic = dic;
                    break;
                }
            }
            CellStateModel *model = [[CellStateModel alloc]init];
            if ([infoDic[@"flag"] isEqual:@1]) {
                model.state = YES;
            }
            else{
                model.state = NO;
            }
            if (![weakSelf.model.status isEqual:@0] && infoDic[@"node"]) {
                model.problem = infoDic[@"node"];
            }
            else{
                model.problem = @"";
            }
            [mArr addObject:model];
        }
        [weakSelf.reportMArr addObject:mArr];
    }];
    [self makeProblemData];
    [self.tableView reloadData];
}

-(void)makeProblemData{
    kWeakSelf(weakSelf);
    [self.problemMArr removeAllObjects];
    for (int i = 0; i < self.reportMArr.count; i++) {
        NSArray *arr = self.reportMArr[i];
        [arr enumerateObjectsUsingBlock:^(CellStateModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if (model.problem.length) {
                [weakSelf.problemMArr addObject:[NSString stringWithFormat:@"%d.%d %@",i+1,(int)idx+1,model.problem]];
            }
        }];
    }
    [self.tableView reloadData];
}

-(void)uploadReport{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setObject:[UserDef objectForKey:@"userId"] forKey:@"userId"];
    [para setObject:self.model.projectId forKey:@"projectId"];
    [para setObject:_stationId forKey:@"stationId"];
    [para setObject:@"3" forKey:@"type"];
    NSMutableArray *nodeMArr = [NSMutableArray new];
    for (int index = 0; index < self.reportMArr.count; index++) {
        NSArray *arr = self.reportMArr[index];
        [arr enumerateObjectsUsingBlock:^(CellStateModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *nodeDic = [NSMutableDictionary new];
            NSString *massgeNumber = [NSString stringWithFormat:@"%d.%d",index+1,(int)idx+1];
            [nodeDic setObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:model.state]] forKey:@"flag"];
            [nodeDic setObject:model.problem forKey:@"node"];
            [nodeDic setObject:massgeNumber forKey:@"massgeNumber"];
            [nodeMArr addObject:nodeDic];
        }];
    }
    [para setObject:nodeMArr forKey:@"nodeArray"];
    
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:AddReportInfoV2] isPost:YES Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"%@",jsonDic);
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            [weakSelf updateStatus];
        }
        else{
            [LoadingView showAlertHUD:@"提交失败" duration:1.0];
        }
    }];
}

-(void)updateStatus{
    kWeakSelf(weakSelf);
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setObject:[UserDef objectForKey:@"userId"] forKey:@"userId"];
    [para setObject:self.model.id forKey:@"workOrderId"];
    [para setObject:self.model.projectId forKey:@"projectId"];
    [para setObject:self.model.stationId forKey:@"stationId"];
    
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:updateWorkOrderStatus] isPost:YES Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"%@",jsonDic);
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

-(void)changeSelectedTimer{
//    _isSelected = YES;
}

#pragma mark -- UITableViewDataSource

//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.problemMArr.count) {
        return self.dataArray.count+1;
    }
    else{
        return self.dataArray.count;
    }
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < self.reportMArr.count) {
        NSArray *arr = self.dataArray[section][@"list"];
        return arr.count;
    }
    else{
        return self.problemMArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.reportMArr.count) {
        InstallReportCell *cell = [InstallReportCell nibCellWithTableView:tableView];
        cell.titleLab.text = self.dataArray[indexPath.section][@"list"][indexPath.row];
        //当前安装项状态处理
        __block CellStateModel *model = self.reportMArr[indexPath.section][indexPath.row];
        cell.model = model;
        
        //这句话很重要 不信你就删掉试试
        cell.clipsToBounds = YES;
        //安装问题定位操作
        kWeakSelf(weakSelf);
        cell.hasProblemHandle = ^{
            ProblemViewController *vc = [[ProblemViewController alloc]init];
            vc.numberStr = [NSString stringWithFormat:@"%d.%d",(int)indexPath.section+1,(int)indexPath.row+1];
            vc.feedbackBlock = ^(NSString *problemStr) {
                model.problem = problemStr;
                [weakSelf makeProblemData];
            };
            [weakSelf pushVC:vc];
        };
        return cell;
    }
    else{
        BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
        cell.textLabel.text = self.problemMArr[indexPath.row];
        return cell;
    }
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dropDownView hideDropDown];
    if (indexPath.section < self.reportMArr.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CellStateModel *model = self.reportMArr[indexPath.section][indexPath.row];
        if (model.state) {
            model.state = !model.state;
        }
        else{
            model.state = !model.state;
//            _isSelected = NO;
//            _timer.fireDate = [NSDate dateWithTimeInterval:IntervalTime sinceDate:[NSDate date]];
        }
//        else{
//            [self.view makeToast:@"检测目录需间隔30秒"];
//        }
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
}


//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < self.reportMArr.count) {
        NSString *sectionTitle = self.dataArray[section][@"name"];
        CGFloat height = [sectionTitle realHeightFromWidth:SCREEN_WIDTH-30 Font:17];
        return height+24;
    }
    else{
        return 35;
    }
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < self.reportMArr.count){
        NSString *rowTitle = self.dataArray[indexPath.section][@"list"][indexPath.row];
        CGFloat height = [rowTitle realHeightFromWidth:SCREEN_WIDTH-10*4-20-30 Font:17];
        return height+24;
    }
    else{
        return 44;
    }
}

//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *sectionLabel = [[UILabel alloc] init];
    sectionLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    sectionLabel.numberOfLines = 0;
    sectionLabel.tag = 100 + section;
    sectionLabel.userInteractionEnabled = YES;
    
    if (section < self.reportMArr.count) {
        sectionLabel.text = self.dataArray[section][@"name"];
        sectionLabel.backgroundColor = [UIColor whiteColor];
    }
    else{
        sectionLabel.text = @"遗留问题";
        sectionLabel.backgroundColor = RGBColor(241, 241, 241);
    }
    
    return sectionLabel;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.dropDownView hideDropDown];
}

#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    _stationId = self.stationIdArr[number];
    [self loadData];
}

#pragma mark -- LazyLoad

-(NSMutableArray *)reportMArr{
    if (!_reportMArr) {
        _reportMArr = [[NSMutableArray alloc]init];
    }
    return _reportMArr;
}

-(NSMutableArray *)problemMArr{
    if (!_problemMArr) {
        _problemMArr = [[NSMutableArray alloc]init];
    }
    return _problemMArr;
}

-(NSMutableArray *)testInfoArr{
    if (!_testInfoArr) {
        _testInfoArr = [NSMutableArray new];
    }
    return _testInfoArr;
}

-(LMJDropdownMenu *)dropDownView{
    if (!_dropDownView) {
        _dropDownView = [[LMJDropdownMenu alloc]init];
        [_dropDownView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
        [_dropDownView setMenuTitles:self.stationNameArr rowHeight:30];
        [_dropDownView.mainBtn setTitle:self.stationNameArr[0] forState:(UIControlStateNormal)];
        _dropDownView.delegate = self;
    }
    return _dropDownView;
}

-(NSArray *)stationNameArr{
    if (!_stationNameArr) {
        _stationNameArr = [NSArray new];
    }
    return _stationNameArr;
}

-(NSArray *)stationIdArr{
    if (!_stationIdArr) {
        _stationIdArr = [NSArray new];
    }
    return _stationIdArr;
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
