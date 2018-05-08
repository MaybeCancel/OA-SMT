//
//  BaseTableViewCell.h
//  Abroad-agent
//
//  Created by Slark on 17/5/15.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  快速创建一个从xib中加载的tableview cell
 */
+ (instancetype)nibCellWithTableView:(UITableView *)tableView;

- (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval;


@end
