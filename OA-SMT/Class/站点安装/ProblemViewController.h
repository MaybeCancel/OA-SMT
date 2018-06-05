//
//  ProblemViewController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseViewController.h"

@interface ProblemViewController : BaseViewController
@property (nonatomic, copy) NSString *numberStr;
@property (nonatomic, copy) void (^feedbackBlock)(NSString *problemStr);
@end
