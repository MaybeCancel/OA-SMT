//
//  WorkOrderCell.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WorkOrderCell.h"

@interface WorkOrderCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *workNumberLab;
@property (nonatomic, strong) UILabel *workStateLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *workTypeLab;
@property (nonatomic, strong) UILabel *workLevelLab;
@property (nonatomic, strong) UILabel *createDateLab;
@property (nonatomic, strong) UILabel *endDateLab;
@property (nonatomic, strong) UILabel *projectNameLab;
@property (nonatomic, strong) UILabel *siteLab;
@property (nonatomic, strong) UILabel *siteNameLab;
@property (nonatomic, strong) UILabel *taskLab;
@property (nonatomic, strong) UILabel *taskDesLab;
@property (nonatomic, strong) UILabel *attachLab;
@property (nonatomic, strong) UILabel *attachmentLab;
@end

@implementation WorkOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.workNumberLab];
    [self.bgView addSubview:self.workStateLab];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.workTypeLab];
    [self.bgView addSubview:self.workLevelLab];
    [self.bgView addSubview:self.createDateLab];
    [self.bgView addSubview:self.endDateLab];
    [self.bgView addSubview:self.siteLab];
    [self.bgView addSubview:self.siteNameLab];
    [self.bgView addSubview:self.taskLab];
    [self.bgView addSubview:self.taskDesLab];
    [self.bgView addSubview:self.attachLab];
    [self.bgView addSubview:self.attachmentLab];
    [self.bgView addSubview:self.projectNameLab];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(5);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
    
    [self.workNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.bgView).offset(5);
    }];
    
    [self.workStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.workNumberLab.mas_centerY);
        make.right.mas_equalTo(self.bgView).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.workNumberLab.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(1);
    }];
    
    [self.workTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).offset(10);
        make.top.mas_equalTo(self.lineView).offset(10);
    }];
    
    [self.workLevelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.workTypeLab.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_centerX);
    }];
    
    [self.createDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.workTypeLab.mas_left);
        make.top.mas_equalTo(self.workTypeLab.mas_bottom).offset(10);
    }];
    
    [self.endDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.workLevelLab.mas_left);
        make.top.mas_equalTo(self.createDateLab.mas_top);
    }];
    
    [self.projectNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.createDateLab.mas_left);
        make.top.mas_equalTo(self.createDateLab.mas_bottom).offset(10);
    }];
    
    [self.siteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.createDateLab.mas_left);
        make.top.mas_equalTo(self.projectNameLab.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    [self.siteNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.siteLab.mas_right);
        make.top.mas_equalTo(self.siteLab.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(42);
    }];
    
    [self.taskLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.siteLab.mas_left);
        make.top.mas_equalTo(self.siteNameLab.mas_bottom).offset(10);
    }];
    
    [self.taskDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.siteNameLab.mas_left);
        make.top.mas_equalTo(self.taskLab.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(42);
    }];
    
    [self.attachLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.taskLab.mas_left);
        make.top.mas_equalTo(self.taskDesLab.mas_bottom).offset(10);
    }];
    
    [self.attachmentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.siteNameLab.mas_left);
        make.top.mas_equalTo(self.attachLab.mas_top);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(66);
    }];
}

-(void)setModel:(WorkOrderModel *)model{
    _model = model;
    self.workNumberLab.text = [NSString stringWithFormat:@"工单流水号：%@",model.serialNumber];
    if ([model.status isEqual:@0]) {
        self.workStateLab.text = @"未开始";
        self.workStateLab.backgroundColor = RGBColor(204, 204, 204);
    }
    else if ([model.status isEqual:@1]){
        self.workStateLab.text = @"进行中";
        self.workStateLab.backgroundColor = RGBColor(74, 142, 233);
    }
    else if ([model.status isEqual:@2]){
        self.workStateLab.text = @"已完成";
        self.workStateLab.backgroundColor = RGBColor(87, 202, 197);
    }
    NSString *workType = @"";
    switch (model.workOrderTypeId) {
        case 1:
            workType = @"收货验货";
            break;
        case 2:
            workType = @"安装施工";
            break;
        case 3:
            workType = @"告警处理";
            break;
        case 4:
            workType = @"整改闭环";
            break;
        case 5:
            workType = @"其他";
            break;
            
        default:
            break;
    }
    self.workTypeLab.text = [NSString stringWithFormat:@"工单类型：%@",workType];
    self.workLevelLab.text = [NSString stringWithFormat:@"工单优先级：%@",model.priority];
    self.createDateLab.text = [NSString stringWithFormat:@"创建日期：%@",[model.startDate substringToIndex:10]];
    self.endDateLab.text = [NSString stringWithFormat:@"截止日期：%@",[model.endDate substringToIndex:10]];
    self.projectNameLab.text = [NSString stringWithFormat:@"工程名称：%@",model.projectName];
    self.siteNameLab.text = model.stationName;
    self.taskDesLab.text = model.missionDetails;
    NSMutableString *attachment = [NSMutableString new];
    for (NSDictionary *dic in model.workOrderAttachment) {
        [attachment appendString:dic[@"attachmentName"]];
        [attachment appendString:@"\n"];
    }
    self.attachmentLab.text = attachment;
}

#pragma mark -- LazyLoad

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layerBorderWidth = 1.0;
        _bgView.layerBorderColor = [UIColor blackColor];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UILabel *)workNumberLab{
    if (!_workNumberLab) {
        _workNumberLab = [[UILabel alloc]init];
        _workNumberLab.text = @"工单流水号：";
        _workNumberLab.font = [UIFont systemFontOfSize:17];
    }
    return _workNumberLab;
}

-(UILabel *)workStateLab{
    if (!_workStateLab) {
        _workStateLab = [[UILabel alloc]init];
        _workStateLab.text = @"未完结";
        _workStateLab.textAlignment = NSTextAlignmentCenter;
        _workStateLab.layerCornerRadius = 10;
        _workStateLab.font = [UIFont systemFontOfSize:16];
        _workStateLab.backgroundColor = RGBColor(87, 203, 197);
        _workStateLab.textColor = [UIColor whiteColor];
    }
    return _workStateLab;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

-(UILabel *)workTypeLab{
    if (!_workTypeLab) {
        _workTypeLab = [[UILabel alloc]init];
        _workTypeLab.text = @"工单类型：";
        _workTypeLab.font = [UIFont systemFontOfSize:15];
        _workTypeLab.textColor = RGBColor(82, 82, 82);
    }
    return _workTypeLab;
}

-(UILabel *)workLevelLab{
    if (!_workLevelLab) {
        _workLevelLab = [[UILabel alloc]init];
        _workLevelLab.text = @"工单优先级：";
        _workLevelLab.font = [UIFont systemFontOfSize:15];
        _workLevelLab.textColor = RGBColor(82, 82, 82);
    }
    return _workLevelLab;
}

-(UILabel *)createDateLab{
    if (!_createDateLab) {
        _createDateLab = [[UILabel alloc]init];
        _createDateLab.text = @"创建日期：";
        _createDateLab.font = [UIFont systemFontOfSize:15];
        _createDateLab.textColor = RGBColor(82, 82, 82);
    }
    return _createDateLab;
}

-(UILabel *)endDateLab{
    if (!_endDateLab) {
        _endDateLab = [[UILabel alloc]init];
        _endDateLab.text = @"截止日期：";
        _endDateLab.font = [UIFont systemFontOfSize:15];
        _endDateLab.textColor = RGBColor(82, 82, 82);
    }
    return _endDateLab;
}

-(UILabel *)siteLab{
    if (!_siteLab) {
        _siteLab = [[UILabel alloc]init];
        _siteLab.text = @"站点名称：";
        _siteLab.font = [UIFont systemFontOfSize:15];
        _siteLab.textColor = RGBColor(82, 82, 82);
    }
    return _siteLab;
}

-(UILabel *)siteNameLab{
    if (!_siteNameLab) {
        _siteNameLab = [[UILabel alloc]init];
        _siteNameLab.layerBorderWidth = 1.0;
        _siteNameLab.layerBorderColor = RGBColor(82, 82, 82);
        _siteNameLab.numberOfLines = 2;
        _siteNameLab.font = [UIFont systemFontOfSize:15];
        _siteNameLab.textColor = RGBColor(82, 82, 82);
    }
    return _siteNameLab;
}

-(UILabel *)taskLab{
    if (!_taskLab) {
        _taskLab = [[UILabel alloc]init];
        _taskLab.text = @"任务描述：";
        _taskLab.font = [UIFont systemFontOfSize:15];
        _taskLab.textColor = RGBColor(82, 82, 82);
    }
    return _taskLab;
}

-(UILabel *)taskDesLab{
    if (!_taskDesLab) {
        _taskDesLab = [[UILabel alloc]init];
        _taskDesLab.layerBorderWidth = 1.0;
        _taskDesLab.layerBorderColor = RGBColor(82, 82, 82);
        _taskDesLab.numberOfLines = 2;
        _taskDesLab.font = [UIFont systemFontOfSize:15];
        _taskDesLab.textColor = RGBColor(82, 82, 82);
    }
    return _taskDesLab;
}

-(UILabel *)attachLab{
    if (!_attachLab) {
        _attachLab = [[UILabel alloc]init];
        _attachLab.text = @"工单附件：";
        _attachLab.font = [UIFont systemFontOfSize:15];
        _attachLab.textColor = RGBColor(82, 82, 82);
    }
    return _attachLab;
}

-(UILabel *)attachmentLab{
    if (!_attachmentLab) {
        _attachmentLab = [[UILabel alloc]init];
        _attachmentLab.layerBorderWidth = 1.0;
        _attachmentLab.layerBorderColor = RGBColor(82, 82, 82);
        _attachmentLab.font = [UIFont systemFontOfSize:15];
        _attachmentLab.textColor = RGBColor(82, 82, 82);
        _attachmentLab.numberOfLines = 3;
    }
    return _attachmentLab;
}

-(UILabel *)projectNameLab{
    if (!_projectNameLab) {
        _projectNameLab = [[UILabel alloc]init];
        _projectNameLab.text = @"工程名称：";
        _projectNameLab.font = [UIFont systemFontOfSize:15];
        _projectNameLab.textColor = RGBColor(82, 82, 82);
    }
    return _projectNameLab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];

    // Configure the view for the selected state
}

@end
