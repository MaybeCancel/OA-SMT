//
//  CCRefreshHeaderFooter.m
//  Abroad-agent
//
//  Created by Slark on 17/7/7.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "CCRefreshHeaderFooter.h"
#import "MJRefresh.h"
@implementation CCRefreshHeaderFooter
+ (instancetype)shareRefresh{
    static CCRefreshHeaderFooter* shareRefresh;
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        shareRefresh = [[CCRefreshHeaderFooter alloc]init];;
    });
    return shareRefresh;
}
- (void)RefreshWithScrollViewHeader:(UIScrollView *)scrollView pullText:(NSString *)pullText PullingText:(NSString *)pulling action:(SuccesAction)action{
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        action();
    }];
    scrollView.mj_header = header;
    [header setTitle:pullText forState:MJRefreshStateRefreshing];
    [header setTitle:pulling forState:MJRefreshStateIdle];
}
@end
