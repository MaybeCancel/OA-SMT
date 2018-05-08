//
//  CCRefreshHeaderFooter.h
//  Abroad-agent
//
//  Created by Slark on 17/7/7.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
typedef void (^SuccesAction)();

@interface CCRefreshHeaderFooter : NSObject
+ (instancetype)shareRefresh;

- (void)RefreshWithScrollViewHeader:(UIScrollView*)scrollView pullText:(NSString*)pullText PullingText:(NSString*)pulling action:(SuccesAction)action;
@end
