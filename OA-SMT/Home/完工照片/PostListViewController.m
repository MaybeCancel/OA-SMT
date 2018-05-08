//
//  PostListViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "PostListViewController.h"
#import "PostPicCell.h"
@interface PostListViewController ()
@property (nonatomic,strong)UILabel* countLable;
@property (nonatomic,assign)BOOL isClick;
@property (nonatomic,strong)UIButton* statusBtn;
@property (nonatomic,assign)NSInteger count;
@end

@implementation PostListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"传输列表";
    self.count = 0;
    [self setUp];
}
- (void)setUp{
    self.countLable = [[UILabel alloc]initWithFrame:RR(15, 19+64, 180, 15)];
    self.countLable.textColor = RGBColor(119, 119, 119);
    self.countLable.text = [NSString stringWithFormat:@"等待上传(%ld)",self.shootedArray.count];
    self.countLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.countLable];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, CGRectGetMaxY(self.countLable.frame)+10, ScreenWidth, ScreenHeight - 64-44) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shootedArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* classId = @"PostPicCell";
    PostPicCell* cell = [tableView dequeueReusableCellWithIdentifier:classId];
    cell.isPost = self.isClick;
    if (!cell) {
        cell =[[PostPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classId];
    }
    UIImage* image = self.shootedArray[indexPath.row];
    NSLog(@"照片部位:~~~~%@",image.devicePicPart);
    cell.nameLabel.text = [NSString stringWithFormat:@"%@_%@_%@",image.siteNumber,image.siteName,image.devicePicPart];
    if (self.isClick) {
        [cell postImage:image];
    }
    //上传完成后的操作
    cell.postFinishHandle = ^{
        self.count ++;
        NSLog(@"上传成功数量:%ld",self.count);
        if (self.count == self.shootedArray.count) {
            [LoadingView showAlertHUD:@"全部上传完成" duration:1];
            [self.shootedArray removeAllObjects];
            [self.tableView reloadData];
        }

    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]init];
    self.statusBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.statusBtn setTitle:@"全部开始" forState:UIControlStateNormal];
    [self.statusBtn setTitle:@"全部暂停" forState:UIControlStateSelected];
    self.statusBtn.frame = RR(24, 15, ScreenWidth - 48, 50);
    [self.statusBtn setTitleColor:RGBColor(92, 92, 92) forState:UIControlStateNormal];
    self.statusBtn.layerBorderColor = RGBColor(217, 217, 217);
    self.statusBtn.layerBorderWidth = 1.5;
    self.statusBtn.layerCornerRadius = 7;
    [view addSubview:self.statusBtn];
    [self.statusBtn addTarget:self action:@selector(gogogo) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80.0f;
}
- (void)gogogo{
    NSLog(@"postpostpost");
    self.isClick = !self.isClick;
    self.statusBtn.selected = self.isClick;
    [self.tableView reloadData];
    
   // PostPicCell* cell = [self.tableView cellForRowAtIndexPath:];
}

@end
