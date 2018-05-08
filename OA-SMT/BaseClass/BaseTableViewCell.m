//
//  BaseTableViewCell.m
//  Abroad-agent
//
//  Created by Slark on 17/5/15.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
//- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 15;
//    NSLog(@"%@", NSStringFromCGRect(frame));
//    
//    [super setFrame:frame];
//}


/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
        if (tableView == nil) {
            return [[self alloc] init];
        }
        NSString *classname = NSStringFromClass([self class]);
        NSString *identifier = [classname stringByAppendingString:@"CellID"];
        [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
        return [tableView dequeueReusableCellWithIdentifier:identifier];
}


+ (instancetype)nibCellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"nibCellID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}
- (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    createTime = timeInterval / 1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {

        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前",years];
}
@end
