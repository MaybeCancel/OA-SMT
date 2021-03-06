//
//  ObjectInfoViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/7.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProjectInfoViewController.h"
#import "NHCustomSegmentView.h"
#import "BaseCellView.h"
#import "ProjectInfoCell.h"
#import "LMJDropdownMenu.h"
#import "ProjectInfoModel.h"
#import "ProjectStationModel.h"

@interface ProjectInfoViewController ()<LMJDropdownMenuDelegate>
@property (nonatomic, strong) NHCustomSegmentView *segmentView;
@property (nonatomic, strong) ProjectInfoModel *projectInfoModel;
@property (nonatomic, strong) BaseCellView *customerCell;
@property (nonatomic, strong) BaseCellView *projectCell;
@property (nonatomic, strong) LMJDropdownMenu *customerMenu;
@property (nonatomic, strong) LMJDropdownMenu *projectMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) NSMutableArray *stationDataSource;
@property (nonatomic, assign) BOOL isLandscap;
@property (nonatomic, copy) NSString *isFinish;
@property (nonatomic, copy) NSString *projectId;
@end

@implementation ProjectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rightItemImageName = @"btn_rotate";
    self.isLandscap = YES;
    kWeakSelf(weakSelf);
    self.rightItemHandle = ^{
        if (weakSelf.isLandscap) {
            [weakSelf landscapAction:nil];
        }
        else{
            [weakSelf portraitAction:nil];
        }
        weakSelf.isLandscap = !weakSelf.isLandscap;
    };

    [self setupUI];
    [self makeConstraints];
    [self loadData];
    
}

-(void)loadData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetProjectList]
                                                   isPost:YES
                                                   Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        NSMutableArray *clientMArr = [NSMutableArray new];
        NSMutableArray *projectMArr = [NSMutableArray new];
        for (NSDictionary* dic in result) {
            ProjectInfoModel* model = [[ProjectInfoModel alloc]initWithDictionary:dic error:nil];
            [clientMArr addObject:model.clientName];
            [weakSelf.dataArray addObject:model];
        }
        if (weakSelf.dataArray.count != 0) {
            ProjectInfoModel *infoModel = weakSelf.dataArray[0];
            weakSelf.projectInfoModel = infoModel;
            for (ProjectListModel *model in infoModel.projectList) {
                [projectMArr addObject:model.projectName];
            }
            weakSelf.customerCell.rightString = infoModel.clientName;
            if (infoModel.projectList && infoModel.projectList.count != 0) {
                _projectId = [infoModel.projectList[0] projectId];
                weakSelf.projectCell.rightString = [infoModel.projectList[0] projectName];
            }
        }
        [self.customerMenu setMenuTitles:clientMArr rowHeight:44];
        [weakSelf.projectMenu setMenuTitles:projectMArr rowHeight:44];
        [weakSelf loadStationData];
    }];
}

-(void)loadStationData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.isFinish forKey:@"isFinish"];
    [para setObject:self.projectId forKey:@"projectId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetStationInfo]
                                                   isPost:YES
                                                   Params:para];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        [weakSelf.stationDataSource removeAllObjects];
        for (NSDictionary *dict in result) {
            ProjectStationModel *model = [ProjectStationModel ModelWithDic:dict];
            [weakSelf.stationDataSource addObject:model];
        }
        [weakSelf.tableView reloadData];
    }];
}

-(void)setupUI{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"SafariForward"] style:(UIBarButtonItemStylePlain) target:self action:@selector(dismissBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.titleView = self.segmentView;
    [self.view addSubview:self.customerCell];
    [self.view addSubview:self.projectCell];
    [self.view addSubview:self.customerMenu];
    [self.view addSubview:self.projectMenu];
    [self.view addSubview:self.scrollView];
    
    self.tableView = [[BaseTableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.tableView];
}

-(void)makeConstraints{
    [self.customerCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(64);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    
    [self.projectCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customerCell.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    
    [self.customerMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.customerCell);
    }];

    [self.projectMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.projectCell);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.projectCell.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.left.mas_equalTo(self.scrollView.mas_left);
        make.height.mas_equalTo(SCREEN_HEIGHT-64-44*2-15-10);
        make.width.mas_equalTo(800);
    }];
}

-(void)dismissBack{
    [self portraitAction:nil];
    [self dismiss];
}

#pragma mark
#pragma mark -- 横竖屏切换

-(BOOL)shouldAutorotate{
    return NO;
}

// 横屏
- (void)landscapAction:(id)sender {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_WIDTH-64-44*2-15-10);
    }];
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

// 竖屏
- (void)portraitAction:(id)sender {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT-64-44*2-15-10);
    }];
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    if (self.customerMenu == menu) {
        ProjectInfoModel *infoModel = self.dataArray[number];
        self.projectInfoModel = infoModel;
        NSMutableArray *projectMArr = [NSMutableArray new];
        for (ProjectListModel *model in infoModel.projectList) {
            [projectMArr addObject:model.projectName];
        }
        [self.projectMenu setMenuTitles:projectMArr rowHeight:44];
    }
    else{
        ProjectListModel *listModel = self.projectInfoModel.projectList[number];
        self.projectId = listModel.projectId;
        [self loadStationData];
    }
}

#pragma mark
#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stationDataSource.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProjectInfoCell *cell = [ProjectInfoCell nibCellWithTableView:tableView];
    if (indexPath.row%2) {
        cell.backgroundColor = RGBColor(255, 255, 255);
    }
    else{
        cell.backgroundColor = RGBColor(248, 248, 248);
    }
    if (indexPath.row == 0) {
        cell.rowDatas = self.tableItems;
    }
    else{
        ProjectStationModel *model = self.stationDataSource[indexPath.row-1];
        NSMutableArray *rowDatas = [NSMutableArray new];
        [rowDatas addObject:model.stationCode];
        [rowDatas addObject:model.stationName];
        [rowDatas addObject:model.receiveDate];
        [rowDatas addObject:model.checkoutDate];
        [rowDatas addObject:model.installDate];
        [rowDatas addObject:model.testDate];
        [rowDatas addObject:model.inspectDate];
        [rowDatas addObject:model.rectifyDate];
        [rowDatas addObject:model.acceptDate];
        cell.rowDatas = rowDatas;
    }
    return cell;
}

#pragma mark
#pragma mark -- UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeight;
}


#pragma mark
#pragma mark -- LazyLoad

-(NHCustomSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[NHCustomSegmentView alloc] initWithItemTitles:@[@"未完成", @"已完成"]];
        _segmentView.frame = CGRectMake(0, 0, 175, 35);
        [_segmentView clickDefault];
        kWeakSelf(weakSelf);
        _segmentView.NHCustomSegmentViewBtnClickHandle = ^(NHCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
            weakSelf.isFinish = [NSString stringWithFormat:@"%d",(int)currentIndex];
            [weakSelf loadStationData];
        };
    }
    return _segmentView;
}

-(BaseCellView *)customerCell{
    if (!_customerCell) {
        _customerCell = [[BaseCellView alloc]init];
        _customerCell.leftString = @"客户";
        _customerCell.rightString = @"";
        _customerCell.arrowHidden = YES;
    }
    return _customerCell;
}

-(BaseCellView *)projectCell{
    if (!_projectCell) {
        _projectCell = [[BaseCellView alloc]init];
        _projectCell.leftString = @"项目";
        _projectCell.rightString = @"";
        _projectCell.arrowHidden = YES;
    }
    return _projectCell;
}

-(LMJDropdownMenu *)customerMenu{
    if (!_customerMenu) {
        _customerMenu = [[LMJDropdownMenu alloc] init];
        [_customerMenu.mainBtn setTitleColor:[UIColor clearColor] forState:(UIControlStateNormal)];
        _customerMenu.mainBtn.backgroundColor = [UIColor clearColor];
        _customerMenu.mainBtn.layer.borderWidth = 0;
        _customerMenu.delegate = self;
    }
    return _customerMenu;
}

-(LMJDropdownMenu *)projectMenu{
    if (!_projectMenu) {
        _projectMenu = [[LMJDropdownMenu alloc] init];
        [_projectMenu.mainBtn setTitleColor:[UIColor clearColor] forState:(UIControlStateNormal)];
        _projectMenu.mainBtn.backgroundColor = [UIColor clearColor];
        _projectMenu.mainBtn.layer.borderWidth = 0;
        _projectMenu.delegate = self;
    }
    return _projectMenu;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(itemWidth*self.tableItems.count, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

-(NSArray *)tableItems{
    if (!_tableItems) {
        _tableItems = @[@"站号",@"站名",@"收货",@"开箱",@"安装",@"调测",@"质检",@"整改",@"验收"];
    }
    return _tableItems;
}

-(NSMutableArray *)stationDataSource{
    if(!_stationDataSource){
        _stationDataSource = [NSMutableArray new];
    }
    return _stationDataSource;
}

-(ProjectInfoModel *)projectInfoModel{
    if (!_projectInfoModel) {
        _projectInfoModel = [ProjectInfoModel new];
    }
    return _projectInfoModel;
}

-(NSString *)isFinish{
    if (!_isFinish) {
        _isFinish  = @"0";
    }
    return _isFinish;
}

-(NSString *)projectId{
    if (!_projectId) {
        _projectId = @"";
    }
    return _projectId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
