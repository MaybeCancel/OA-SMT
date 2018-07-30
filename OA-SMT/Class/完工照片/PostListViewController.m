//
//  PostListViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "PostListViewController.h"
#import "PostPicCell.h"
#import "ReViewPhotoView.h"

@interface PostListViewController ()
@property (nonatomic,strong)UILabel* countLable;
@property (nonatomic,assign)BOOL isClick;
@property (nonatomic,strong)UIButton* statusBtn;
@property (nonatomic,assign)NSInteger willUploadcount;
@end

@implementation PostListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"传输列表";
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
    PostPicCell* cell = [PostPicCell cellWithTableView:tableView];
    UIImage *image = self.shootedArray[indexPath.row];
    cell.isPost = self.isClick;
    cell.uploadImage = image;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@_%@_%@",image.siteNumber,image.siteName,image.devicePicPart];
    if (self.isClick) {
        [cell postImage];
    }
    //上传完成后的操作
    kWeakSelf(weakSelf);
    cell.postFinishHandle = ^(UIImage *image) {
        [weakSelf.hasUploadMArr addObject:image];
        [weakSelf.shootedArray removeObject:image];
        weakSelf.willUploadcount--;
        if (weakSelf.willUploadcount == 0) {
            [LoadingView showAlertHUD:@"全部上传完成" duration:1];
            [weakSelf.shootedArray removeAllObjects];
        }
        weakSelf.countLable.text = [NSString stringWithFormat:@"等待上传(%ld)",weakSelf.willUploadcount];
        [weakSelf.tableView reloadData];
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
    [self.statusBtn addTarget:self action:@selector(allUpload) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80.0f;
}
- (void)allUpload{
    self.isClick = !self.isClick;
    self.statusBtn.selected = self.isClick;
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReViewPhotoView *photoView = [[ReViewPhotoView alloc]initWithFrame:self.view.bounds Photo:self.shootedArray[indexPath.row]];
    [kWindow addSubview:photoView];
}

@end
