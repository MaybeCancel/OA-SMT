//
//  ObjectInfoViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/7.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ObjectInfoViewController.h"
#import "NHCustomSegmentView.h"
#import "ObjectInfoView.h"
#import "BaseCellView.h"
@interface ObjectInfoViewController ()
@property (nonatomic,strong)UIScrollView* scrollView;
@end

@implementation ObjectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NHCustomSegmentView *segment = [[NHCustomSegmentView alloc] initWithItemTitles:@[@"未完成", @"已完成"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 175, 35);
    [segment clickDefault];
    segment.NHCustomSegmentViewBtnClickHandle = ^(NHCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
       
    };
    
    BaseCellView* cell = [[BaseCellView alloc]init];
    cell.frame = RR(0, 64, ScreenWidth, 44);
    cell.leftString = @"客户";
    cell.rightString = @"JSCMCC";
    cell.arrowHidden = YES;
    [self.view addSubview:cell];
    
    BaseCellView* cell1 = [[BaseCellView alloc]init];
    cell1.frame = RR(0, CGRectGetMaxY(cell.frame), ScreenWidth, 44);
    cell1.leftString = @"项目";
    cell1.rightString = @"SCMY17";
    cell1.arrowHidden = YES;
    [self.view addSubview:cell1];
    

    self.rightItemImageName = @"btn_rotate";
    self.rightItemHandle = ^{
        
    };
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.bounces = NO;
    self.scrollView.frame = RR(0, CGRectGetMaxY(cell1.frame)+10, ScreenWidth,  300);
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(73*9+20, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
   
    
    ObjectInfoView* infoView = [[ObjectInfoView alloc]init];
    infoView.frame = RR(5, 5, 73*9+10, 44*6);
    infoView.models = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self.scrollView addSubview:infoView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
