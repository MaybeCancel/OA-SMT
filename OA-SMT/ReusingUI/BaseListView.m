//
//  BaseListView.m
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseListView.h"

@class BaseListView;

@interface BaseListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)BaseTableView* tableView;

@end

@implementation BaseListView
+ (instancetype)baseListView{
    return [[[NSBundle mainBundle] loadNibNamed:@"BaseListView" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    __weak typeof(BaseListView*)weakSel = self;
    [self addTapActionWithBlock:^{
        [weakSel roatAnimationWithView:weakSel.rightImage];
        if (weakSel.tapHandle) {
            weakSel.tapHandle();
        }
    }];
}
- (void)roatAnimationWithView:(UIView*)view{
    view.transform = CGAffineTransformRotate(view.transform, M_PI);//旋转180
}
- (void)setLeftString:(NSString *)leftString{
    _leftString = leftString;
    self.leftLabel.text = _leftString;
}

#pragma mark tableView - delegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    return cell;
    
}

#pragma mark tableView - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}




@end
