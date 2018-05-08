//
//  ShootDawnViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ShootDawnViewController.h"
#import "AddItemBtnView.h"
#import "ShootDawnCell.h"
@interface ShootDawnViewController ()
@property (nonatomic,strong)NSMutableArray* itemTitleArray;

@property (nonatomic,strong)NSMutableArray* addMuArray;
@property (nonatomic,strong)NSMutableArray* addRuuArray;
@property (nonatomic,strong)NSMutableArray* addTTArray;

@property (nonatomic,assign)NSInteger MU;
@property (nonatomic,assign)NSInteger RUU;
@property (nonatomic,assign)NSInteger TT;
@end

@implementation ShootDawnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拍摄情况";
    self.MU = 1;
    self.RUU = 1;
    self.TT = 1;
    
    self.itemTitleArray = [NSMutableArray arrayWithObjects:@"基站全景",@"室内地线",@"配套电源",@"GPS连接器及避雷器",@"GPS",@"室外电缆及接地",@"OVP照片",@"RRU跳线",@"光纤电缆", nil];
    self.addMuArray = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"MU0%ld",self.MU], nil];
    self.addRuuArray = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"RUU0%ld",self.RUU], nil];
    self.addTTArray = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"天线0%ld",self.TT], nil];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, 64, ScreenWidth,ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.rightItemTitle = @"保存";
    self.rightItemHandle = ^{
        NSLog(@"save");
    };
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 9;
    }else if(section == 1){
        return self.addMuArray.count;
    }else if(section == 2){
        return self.addRuuArray.count;
    }else if(section == 3){
        return self.addTTArray.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ShootDawnCell* cell  = [ShootDawnCell nibCellWithTableView:tableView];
        cell.btn_Delete = YES;
        cell.leftSpace = 15;
        cell.itemLabel.text = self.itemTitleArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ShootDawnCell* cell  = [ShootDawnCell nibCellWithTableView:tableView];
        cell.leftSpace = 51;
        if (indexPath.row == self.addMuArray.count-1&&indexPath.row != 0) {
            cell.btn_Delete = NO;
        }else{
            cell.btn_Delete = YES;
        }
        cell.itemLabel.text = self.addMuArray[indexPath.row];
        
        cell.deleteBtnHandle = ^{
            [self.addMuArray removeObjectAtIndex:self.addMuArray.count-1];
            [self.tableView reloadData];
        };
        
        return cell;
    }
    
    if (indexPath.section == 2) {
         ShootDawnCell* cell  = [ShootDawnCell nibCellWithTableView:tableView];
         cell.leftSpace = 51;
        if (indexPath.row == self.addRuuArray.count-1&&indexPath.row != 0) {
            cell.btn_Delete = NO;
        }else{
            cell.btn_Delete = YES;
        }
        cell.itemLabel.text = self.addRuuArray[indexPath.row];
        
        cell.deleteBtnHandle = ^{
            [self.addRuuArray removeObjectAtIndex:self.addRuuArray.count-1];
            [self.tableView reloadData];
        };
        
        return cell;
    }
    if (indexPath.section == 3) {
         ShootDawnCell* cell  = [ShootDawnCell nibCellWithTableView:tableView];
         cell.leftSpace = 51;
        if (indexPath.row == self.addTTArray.count-1&&indexPath.row != 0) {
            cell.btn_Delete = NO;
        }else{
            cell.btn_Delete = YES;
        }
        cell.itemLabel.text = self.addTTArray[indexPath.row];
        
        cell.deleteBtnHandle = ^{
            [self.addTTArray removeObjectAtIndex:self.addTTArray.count-1];
            [self.tableView reloadData];
        };
        
        return cell;
    }
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        AddItemBtnView* btnView = [self addItemViewWithTitle:@"MU"];
        btnView.addHanle = ^{
            self.MU = self.MU + 1;
            [self.addMuArray addObject:[NSString stringWithFormat:@"MU0%ld",self.MU]];
            [self.tableView reloadData];
        };
        return btnView;
    }else if (section == 2){
        AddItemBtnView* btnView = [self addItemViewWithTitle:@"RRU"];
        btnView.addHanle = ^{
            self.RUU = self.RUU + 1;
            [self.addRuuArray addObject:[NSString stringWithFormat:@"RUU0%ld",self.RUU]];
            [self.tableView reloadData];
        };
        return btnView;
    }else if (section == 3){
        AddItemBtnView* btnView = [self addItemViewWithTitle:@"天线"];
        btnView.addHanle = ^{
            self.TT = self.TT + 1;
            [self.addTTArray addObject:[NSString stringWithFormat:@"天线0%ld",self.TT]];
            [self.tableView reloadData];
        };
        return btnView;
    }
    return nil;
}
- (AddItemBtnView*)addItemViewWithTitle:(NSString*)title{
    AddItemBtnView* btnView = [AddItemBtnView shareAddItem];
    btnView.backgroundColor = RGBColor(241, 241, 241);
    btnView.frame = RR(0, 0, ScreenWidth, 44);
    btnView.leftTitleString = title;
    return btnView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }else{
        return 44;
    }
}
@end
