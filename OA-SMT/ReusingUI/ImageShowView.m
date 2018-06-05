//
//  ImageShowView.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/30.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ImageShowView.h"
#import "ImageCell.h"

@interface ImageShowView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation ImageShowView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setImages:(NSArray *)images{
    _images = images;
    if (images.count == 0) {
        self.hidden = YES;
    }
    self.height = self.height + 230*images.count;
    self.tableview.height = 230*images.count;
    [self.tableview reloadData];
}

-(void)setupUI{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    titleLab.text = @"附件";
    [self addSubview:titleLab];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 0) style:(UITableViewStylePlain)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.images.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [ImageCell nibCellWithTableView:tableView];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]] placeholderImage:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}


@end
