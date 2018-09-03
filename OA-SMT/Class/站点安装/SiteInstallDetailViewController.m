//
//  SiteInstallDetailViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/18.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SiteInstallDetailViewController.h"
#import "ProblemViewController.h"
#import "InstallReportCell.h"
#import "CellStateModel.h"

@interface SiteInstallDetailViewController ()
{
    NSTimer *_timer;
    BOOL _isSelected;
}
@property (nonatomic,strong)NSMutableArray *flagArray;
@property (nonatomic,strong)NSMutableArray *reportMArr;
@property (nonatomic,strong)NSMutableArray *problemMArr;
@property (nonatomic,strong)NSDictionary *installInfoDic;
@end

@implementation SiteInstallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"2G&3G安装检查报告";
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:IntervalTime target:self selector:@selector(changeSelectedTimer) userInfo:nil repeats:YES];
    _isSelected = YES;
    
    kWeakSelf(weakSelf);
    if (self.status == 0) {   //未开始
        self.rightItemTitle = @"保存";
        self.rightItemHandle = ^{
            [weakSelf uploadReport];
        };
        [self setupUI];
        [self makeData];
    }
    else if (self.status == 1){   //进行中
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

-(void)setupUI{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
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
    [para setObject:self.model.stationId forKey:@"stationId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetInstallInfo] isPost:YES Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"result:%@",jsonDic);
        if ([jsonDic[@"result"] isKindOfClass:[NSDictionary class]]) {
            weakSelf.installInfoDic = jsonDic[@"result"];
            [weakSelf makeData];
        }
    }];
}

- (void)makeData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SiteReport" ofType:@"plist"];
    
    self.dataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    _flagArray  = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i ++) {
        [_flagArray addObject:@"0"];
    }
    
    kWeakSelf(weakSelf);
    [self.dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *rowArr = obj[@"list"];
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < rowArr.count; i++) {
            CellStateModel *model = [[CellStateModel alloc]init];
            NSString *installKey = [NSString stringWithFormat:@"isInstall%d_%d",(int)idx+1,i+1];
            NSString *noteKey = [NSString stringWithFormat:@"note%d_%d",(int)idx+1,i+1];
            if (weakSelf.status == 0 ||
                weakSelf.installInfoDic[installKey] == nil ||
                [weakSelf.installInfoDic[installKey] isKindOfClass:[NSNull class]] ||
                [weakSelf.installInfoDic[installKey] isEqual:@0]) {
                model.state = NO;
            }
            else{
                model.state = YES;
            }
            if (weakSelf.status != 0 && weakSelf.installInfoDic[noteKey]) {
                model.problem = weakSelf.installInfoDic[noteKey];
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
            if ([model.problem isKindOfClass:[NSString class]] && model.problem.length) {
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
    [para setObject:self.model.stationId forKey:@"stationId"];
    NSString __block *status = @"2";
    for (int index = 0; index < self.reportMArr.count; index++) {
        NSArray *arr = self.reportMArr[index];
        [arr enumerateObjectsUsingBlock:^(CellStateModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *installKey = [NSString stringWithFormat:@"isInstall%d_%d",index+1,(int)idx+1];
            NSString *noteKey = [NSString stringWithFormat:@"note%d_%d",index+1,(int)idx+1];
            [para setObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithBool:model.state]] forKey:installKey];
            [para setObject:model.problem forKey:noteKey];
            if (!model.state) {
                status = @"1";
            }
        }];
    }
    [para setObject:status forKey:@"status"];// 1：进行中 2：已完成
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:AddInstallInfo] isPost:YES Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"%@",jsonDic);
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            [LoadingView showAlertHUD:@"提交成功" duration:(CGFloat)1.0];
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
            [weakSelf performSelector:@selector(pop) withObject:nil afterDelay:1.0];
        }
        else{
            [LoadingView showAlertHUD:@"提交失败" duration:(CGFloat)1.0];
        }
    }];
}

-(void)changeSelectedTimer{
    _isSelected = YES;
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
        
        //如果是已完成，则报告静态展示即可
        if (weakSelf.status == 2) {
            cell.userInteractionEnabled = NO;
        }
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
    if (indexPath.section < self.reportMArr.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CellStateModel *model = self.reportMArr[indexPath.section][indexPath.row];
        if (model.state) {
            model.state = !model.state;
        }
        else if (_isSelected){
            model.state = !model.state;
            _isSelected = NO;
            _timer.fireDate = [NSDate dateWithTimeInterval:IntervalTime sinceDate:[NSDate date]];
        }
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
        if ([_flagArray[indexPath.section] isEqualToString:@"0"]){
            return 0;
        }
        else{
            NSString *rowTitle = self.dataArray[indexPath.section][@"list"][indexPath.row];
            CGFloat height = [rowTitle realHeightFromWidth:SCREEN_WIDTH-10*4-20-30 Font:17];
            return height+24;
        }
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
        [sectionLabel addGestureRecognizer:tap];
    }
    else{
        sectionLabel.text = @"遗留问题";
        sectionLabel.backgroundColor = RGBColor(241, 241, 241);
    }
    
    return sectionLabel;
}


- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    NSArray *arr = self.dataArray[index][@"list"];
    for (int i = 0; i < arr.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([self.flagArray[index] isEqualToString:@"0"]) {
        self.flagArray[index] = @"1";
        [self.tableView reloadRowsAtIndexPaths:indexArray
                          withRowAnimation:UITableViewRowAnimationFade];
    } else { //收起
        _flagArray[index] = @"0";
        [self.tableView reloadRowsAtIndexPaths:indexArray
                          withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -- LazyLoad

-(NSMutableArray *)flagArray{
    if (!_flagArray) {
        _flagArray = [[NSMutableArray alloc]init];
    }
    return _flagArray;
}

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

-(NSDictionary *)installInfoDic{
    if (!_installInfoDic) {
        _installInfoDic = [[NSDictionary alloc]init];
    }
    return _installInfoDic;
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
