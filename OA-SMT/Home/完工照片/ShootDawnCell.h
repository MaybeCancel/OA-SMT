//
//  ShootDawnCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ShootDawnCell : BaseTableViewCell
@property (nonatomic,copy)void (^deleteBtnHandle)(void);
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleBtnSpace;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemSpace;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic,assign)BOOL btn_Delete;
@property (nonatomic,assign)CGFloat leftSpace;

@end
