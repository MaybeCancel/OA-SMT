//
//  DeviceHighCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DeviceHighCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UIView *lineView;
- (void)loadString:(NSString*)string;
@end
