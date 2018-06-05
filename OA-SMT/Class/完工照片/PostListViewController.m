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
@property (nonatomic,assign)NSInteger willUploadcount;
@property (nonatomic,assign)NSInteger hasUploadcount;
@end

@implementation PostListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"传输列表";
    self.hasUploadcount = 0;
    self.willUploadcount = self.shootedArray.count;
    [self setUp];
}
- (void)setUp{
    self.countLable = [[UILabel alloc]initWithFrame:CGRM(15, 19+64, 180, 15)];
    self.countLable.textColor = RGBColor(119, 119, 119);
    self.countLable.text = [NSString stringWithFormat:@"等待上传(%ld)",self.willUploadcount];
    self.countLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.countLable];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, CGRectGetMaxY(self.countLable.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT - 64-44) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
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
    cell.uploadImage = image;
    NSLog(@"照片部位:~~~~%@",image.devicePicPart);
    cell.nameLabel.text = [NSString stringWithFormat:@"%@_%@_%@",image.siteNumber,image.siteName,image.devicePicPart];
    if (self.isClick) {
        [cell postImage];
    }
    //上传完成后的操作
    kWeakSelf(weakSelf);
    cell.postFinishHandle = ^{
        weakSelf.hasUploadcount++;
        weakSelf.willUploadcount--;
        NSLog(@"上传成功数量:%ld",self.hasUploadcount);
        if (weakSelf.willUploadcount == 0) {
            [LoadingView showAlertHUD:@"全部上传完成" duration:1];
            [weakSelf.shootedArray removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        weakSelf.countLable.text = [NSString stringWithFormat:@"等待上传(%ld)",weakSelf.willUploadcount];
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
    self.statusBtn.frame = CGRM(24, 15, SCREEN_WIDTH - 48, 50);
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
