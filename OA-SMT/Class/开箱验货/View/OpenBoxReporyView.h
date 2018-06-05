//
//  OpenBoxReporyView.h
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellView.h"
@interface OpenBoxReporyView : UIView

@property (nonatomic,copy)NSString* headerString;
@property (nonatomic,strong)NSMutableArray* leftTitles;
@property (nonatomic,copy)NSString* firstText;
@property (nonatomic,copy)NSString* secondText;
@property (nonatomic,copy)NSString* noteText;
@property (nonatomic,copy)NSString* topTextViewTitle;
@property (nonatomic,copy)NSString* textPlaceHolder;
@property (nonatomic,copy)void (^firstClickBlock)(void);
@property (nonatomic,copy)void (^secondClickBlock)(void);

@end
