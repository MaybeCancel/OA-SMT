//
//  FoldListView.h
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldListView : UIView
/**
 * leftLabel数据源
 */
@property (nonatomic,strong)NSArray* leftArray;

/**
 * rightLabel数据源
 */
@property (nonatomic,strong)NSArray* rightArray;

@property (nonatomic,copy)NSString* topTitleString;

@property (nonatomic,copy) void (^foldActionBlock)(CGFloat diffHeight);

@end
