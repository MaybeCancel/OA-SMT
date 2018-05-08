//
//  BaseCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftString;
@property (strong, nonatomic) IBOutlet UILabel *rightString;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImage;
@property (nonatomic,assign)BOOL arrowHidden;
@end
