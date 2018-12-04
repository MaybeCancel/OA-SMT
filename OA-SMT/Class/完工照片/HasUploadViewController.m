
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
#import "HasUploadPhotoModel.h"

@interface HasUploadViewController ()
@end

@implementation HasUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已上传列表";
    [self setUp];
    [self getImagesData];
}

- (void)setUp{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

-(void)getImagesData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:self.stationId forKey:@"stationId"];
    [param setObject:self.projectId forKey:@"projectId"];
    [param setObject:[UserDef objectForKey:@"userId"] forKey:@"userId"];

    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:getPhotoList] isPost:YES Params:param];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        
        if ([jsonDic[@"resultCode"] respondsToSelector:@selector(isEqualToString:)] && [jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            NSArray* array = jsonDic[@"result"];
            for (NSDictionary* dic in array) {
                HasUploadPhotoModel* model = [HasUploadPhotoModel ModelWithDic:dic];
                [weakSelf.hasUploadMArr addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hasUploadMArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostPicCell* cell = [PostPicCell cellWithTableView:tableView];
//    UIImage *image = self.hasUploadMArr[indexPath.row];
//    cell.uploadImage = image;
//    cell.nameLabel.text = [NSString stringWithFormat:@"%@_%@_%@",image.siteNumber,image.siteName,image.devicePicPart];
    HasUploadPhotoModel *model = self.hasUploadMArr[indexPath.row];
    cell.nameLabel.text = model.resourceId;
    cell.hasUpload = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HasUploadPhotoModel *model = self.hasUploadMArr[indexPath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_IMGURL,model.resourceId];
    NSURL *imageUrl = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    ReViewPhotoView *photoView = [[ReViewPhotoView alloc]initWithFrame:self.view.bounds Photo:image];
    [kWindow addSubview:photoView];
}

-(NSMutableArray *)hasUploadMArr{
    if (!_hasUploadMArr) {
        _hasUploadMArr = [NSMutableArray new];
    }
    return _hasUploadMArr;
}

-(NSString *)projectId{
    if (!_projectId) {
        _projectId = @"";
    }
    return _projectId;
}

-(NSString *)stationId{
    if (!_stationId) {
        _stationId = @"";
    }
    return _stationId;
}

@end
