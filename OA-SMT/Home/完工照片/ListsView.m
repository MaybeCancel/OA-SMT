//
//  ListsView.m
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ListsView.h"
#import "DeviceModel.h"
#import "DeviceHighCell.h"
@class ListsView;
@interface ListsView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSString* deviceId;
@property (nonatomic,strong)NSMutableArray* satationIdArray;


@property (nonatomic,copy)NSString* devicePart;
@property (nonatomic,copy)NSString* detailPart;

@end
@implementation ListsView{
    UIView* _backView; //透明背景图
    UIView* _headView; //单条头视图
    UILabel* _titleLabel;//title
    UIImageView* _imageView;
    
    
    UILabel* _rightLabel;//详情label
    
    UITableView* _tableView;
    UITableView* _tableView1;
    NSString* _title;
    NSString* _imageName;
    BOOL _exchange;
}

- (void)hiddenTable{
    [self roatAnimationWithView:_imageView];
    _exchange = YES;
    _backView.hidden = YES;
}

- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName{
    self = [super init];
    if (self) {
        _title = title;
        _imageName = imageName;
        [self setUp];
    }
    return self;
}
- (void)setUp{
    UIView* headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    _headView = headView;
    [self addSubview:headView];
    [headView addTapActionWithBlock:^{
        [self expressBgView];
       
    }];
    
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.text = _title;
    _titleLabel = titleLabel;
    [headView addSubview:titleLabel];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageName]];
    _imageView = imageView;
    [imageView addTapActionWithBlock:^{
        [self expressBgView];
    }];
    [headView addSubview:imageView];
    
    
    UIView* bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    _backView = bgView;
    _backView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
   
    
    // 两个下拉列表
    UITableView* tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;


    UITableView* tableView1 = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1 = tableView1;
    tableView1.delegate = self;
    tableView1.dataSource = self;

    [bgView addSubview:tableView];
    [bgView addSubview:tableView1];
    
    UILabel* rightLabel = [[UILabel alloc]init];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.text = @"";
    _rightLabel = rightLabel;
    [headView addSubview:rightLabel];
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    //处理第二个表
    DeviceModel* model = _dataArray.firstObject;
    self.detailPart = model.photoDevice;
    self.deviceId = model.id;
 
    NSArray* array = model.photoPositions;
    NSMutableArray* array2 = [NSMutableArray new];
    for (NSDictionary* dic in array) {
        [array2 addObject:dic[@"photoPosition"]];
    }
    _data2Array = array2;
    [_tableView reloadData];
    [_tableView1 reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return _dataArray.count;
    }else{
        return _data2Array.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (_tableView == tableView) {
            UITableViewCell* cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = @"123";
            DeviceModel* model = self.dataArray[indexPath.row];
            cell.textLabel.text = model.photoDevice;
            return cell;
        }
        DeviceHighCell* cell = [DeviceHighCell nibCellWithTableView:tableView];
         [cell loadString:self.data2Array[indexPath.row]];
        return cell;
}
- (void)expressBgView{
    [self roatAnimationWithView:_imageView];
    if (_exchange) {
        _backView.hidden = YES;
    }else{
        _backView.hidden = NO;
        _tableView.frame = RR(0, 0, self.width/2, 0);
        [UIView animateWithDuration:0.3 animations:^{
            _tableView.frame = RR(0, 0, self.width/2, 44*9);
        }];
        _tableView1.frame = RR(self.width/2, 0, self.width/2, 0);
        [UIView animateWithDuration:0.3 animations:^{
            _tableView1.frame = RR(self.width/2, 0, self.width/2, 44*9);
        }];
    }
    _exchange = !_exchange;
}
- (void)roatAnimationWithView:(UIView*)view{
    view.transform = CGAffineTransformRotate(view.transform, M_PI);//旋转180
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headView.frame = RR(0, 0, self.width, 44);
    _titleLabel.frame = RR(12, 12, 130, 20);
    _imageView.frame = RR(self.width - 15 - 12 , 18, 12, 8);
    _backView.frame = RR(0, 108, self.width, ScreenHeight - 108);
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
    CGSize size=[_rightString sizeWithAttributes:attrs];
    _rightLabel.frame = RR(self.width - size.width - 15-12-2, 12, size.width, 20);
}
//set
- (void)setRightString:(NSString *)rightString{
    _rightString = rightString;
    _rightLabel.text = _rightString;
    [self layoutSubviews];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableView == tableView) {
        DeviceModel* model = _dataArray[indexPath.row];
        self.deviceId = model.id;
        self.devicePart = model.photoDevice;
        NSArray* array = model.photoPositions;
        NSMutableArray* array2 = [NSMutableArray new];
        self.satationIdArray = [NSMutableArray new];
        for (NSDictionary* dic in array) {
            [array2 addObject:dic[@"photoPosition"]];
            [self.satationIdArray addObject:dic[@"id"]];
        }
        _data2Array = array2;
        [_tableView1 reloadData];
    }else if (tableView == _tableView1){
        self.detailPart = self.data2Array[indexPath.row];
        if (self.picPositionAction) {
            self.picPositionAction(self.devicePart,self.detailPart,self.deviceId,self.satationIdArray[indexPath.row]);
        }
          [self hiddenTable];
    }
}


@end
