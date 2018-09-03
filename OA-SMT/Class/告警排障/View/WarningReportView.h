//
//  WarningReportView.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarningReportView : UIView
@property (nonatomic,strong)NSMutableArray* leftTitles;
@property (nonatomic,copy)NSString* firstText;
@property (nonatomic,copy)NSString* secondText;
@property (nonatomic,copy)NSString* noteText;
@property (nonatomic,copy)NSString* topTextViewTitle;
@property (nonatomic,copy)NSString* textPlaceHolder;
@property (nonatomic,assign)BOOL isQualityDetail;
@property (nonatomic,copy)void (^firstClickBlock)(void);
@property (nonatomic,copy)void (^secondClickBlock)(void);
@end
