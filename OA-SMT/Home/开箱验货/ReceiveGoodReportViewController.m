//
//  ReceiveGoodReportViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ReceiveGoodReportViewController.h"
#import "BaseListView.h"
#import "BaseCellPe.h"
#import "ReportModel.h"
#import "OpenBoxReporyView.h"
#import "FoldListView.h"
#import "AddImageView.h"
@interface ReceiveGoodReportViewController ()
@property (nonatomic,strong)NSArray* leftArray;
@property (nonatomic,strong)ReportModel* model;
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)OpenBoxReporyView* boxView;
@property (nonatomic,strong)BaseListView* list;
@property (nonatomic,strong)FoldListView* foldList;
@property (nonatomic,strong)AddImageView* addImageView;

@property (nonatomic,strong)NSMutableArray* images;
@end

@implementation ReceiveGoodReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货报告";
    self.rightItemTitle = @"提交";
    self.rightItemHandle = ^{};
    [self setUp];
   // [self loadData];
}
- (void)setUp{
    __weak typeof(ReceiveGoodReportViewController*)weaksel = self;
    self.images = [NSMutableArray new];;
    self.scrollView = [[UIScrollView alloc]initWithFrame:RR(0, 64, ScreenWidth, ScreenHeight - 64)];
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = RGBColor(237, 237, 237);
    [self.view addSubview:self.scrollView];
    
    self.leftArray = @[@"区域",@"省",@"运营商",@"网络制式",@"项目",@"客户PO号",@"内部订单号",@"物流号",@"站点",@"货运号",@"箱号",@"箱数",@"级别",@"产品型号",@"描述",@"箱内数量",@"序列号"];
    self.foldList = [[FoldListView alloc]init];
    self.foldList.topTitleString = @"收货报告";
    self.foldList.frame = RR(0, 0, ScreenWidth, self.leftArray.count*44 + 44);
    self.foldList.leftArray = self.leftArray;
    [self.scrollView addSubview:self.foldList];
    
    //收货 修改这里界面也修改这里
    self.boxView = [[OpenBoxReporyView alloc]init];
    self.boxView.titles = [NSMutableArray arrayWithObjects:@"开箱日期",@"开箱站点", nil];
    self.boxView.frame =RR(0, CGRectGetMaxY(self.foldList.frame), ScreenWidth, 44*(self.boxView.titles.count+1)+130);
    self.boxView.textPlaceHolder = @"请填写货物问题描述";
    self.boxView.headerString = @"开箱报告";
    self.boxView.topTextViewTitle = @"货物问题描述";
    [self.scrollView addSubview:self.boxView];

    self.addImageView = [[AddImageView alloc]init];
    self.addImageView.title = @"照片";
    self.addImageView.frame = RR(0, CGRectGetMaxY(self.boxView.frame), ScreenWidth, 115);
    [self.scrollView addSubview:self.addImageView];
    
    self.addImageView.tapHandle = ^{
        [weaksel OpenAlbumAlert];
    };
    
    self.scrollView.contentSize = CGSizeMake(0, self.foldList.height+20+ self.boxView.height+self.addImageView.height);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   // image = [UIImage imageWithData:[self ]];
    [self.images addObject:image];
    [self updateFrame];
    [self dismiss];
}

- (void)updateFrame{
    //如果有照片
    if (self.images.count==0||!self.images) {
        return;
    }
    self.scrollView.contentSize = CGSizeMake(0, self.foldList.height+20+ self.boxView.height+self.addImageView.height);
}

- (void)loadData{
    self.dataArray = [NSMutableArray new];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:@"/project/checkoutGoodsInfo"] isPost:YES Params:@{@"goodsId":self.goodsId}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSDictionary* dic = jsonDic[@"result"];
        self.model = [ReportModel ModelWithDic:dic];
        [self.tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 17;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellPe* cell = [BaseCellPe nibCellWithTableView:tableView];
    cell.leftLabel.text = self.leftArray[indexPath.row];
    cell.rightLabel.text = @"666";//self.dataArray[indexPath.row];
//    switch (indexPath.row) {
//        case 0:
//             cell.rightLabel.text = self.model.city;
//            break;
//        case 1:
//             cell.rightLabel.text = self.model.province;
//            break;
//        case 2:
//             cell.rightLabel.text = self.model.clientName;
//            break;
//        case 3:
//             cell.rightLabel.text = self.model.networkType;
//            break;
//        case 4:
//             cell.rightLabel.text = self.model.projectName;
//            break;
//        case 5:
//             cell.rightLabel.text = self.model.poCode;
//            break;
//        case 6:
//             cell.rightLabel.text = self.model.orderCode;
//            break;
//        case 7:
//             cell.rightLabel.text = self.model.logisticsCode;
//            break;
//        case 8:
//             cell.rightLabel.text = self.model.stationName;
//            break;
//        case 9:
//             cell.rightLabel.text = self.model.freightCode;
//            break;
//        case 10:
//             cell.rightLabel.text = self.model.packageCode;
//            break;
//        case 11:
//             cell.rightLabel.text = self.model.packageNum;
//            break;
//        case 12:
//             cell.rightLabel.text = self.model.level;
//            break;
//        case 13:
//             cell.rightLabel.text = self.model.modelCode;
//            break;
//        case 14:
//             cell.rightLabel.text = self.model.note;
//            break;
//        case 15:
//             cell.rightLabel.text = self.model.totalCount;
//            break;
//        case 16:
//             cell.rightLabel.text = self.model.serialCode;
//            break;
//
//    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    return 62;
}
@end
