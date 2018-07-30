
//
//  HasUploadViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "HasUploadViewController.h"
#import "PostPicCell.h"
#import "ReViewPhotoView.h"

@interface HasUploadViewController ()
@end

@implementation HasUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已上传列表";
    [self setUp];
}

- (void)setUp{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64-44) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hasUploadMArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostPicCell* cell = [PostPicCell cellWithTableView:tableView];
    UIImage *image = self.hasUploadMArr[indexPath.row];
    cell.uploadImage = image;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@_%@_%@",image.siteNumber,image.siteName,image.devicePicPart];
    cell.hasUpload = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReViewPhotoView *photoView = [[ReViewPhotoView alloc]initWithFrame:self.view.bounds Photo:self.hasUploadMArr[indexPath.row]];
    [kWindow addSubview:photoView];
}

@end
