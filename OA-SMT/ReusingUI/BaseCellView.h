//
//  BaseCellView.h
//  Abroad-agent
//
//  Created by Slark on 17/6/15.
//  Copyright © 2017年 Slark. All rights reserved.


#import <UIKit/UIKit.h>

@interface BaseCellView : UIView
@property (nonatomic,copy)NSString* leftString;
@property (nonatomic,strong)NSString* rightString;
@property (nonatomic,strong)UIColor * TextColor;
@property (nonatomic,copy)void (^TapHandle)(void);
@property (nonatomic,assign)BOOL arrowHidden;
@property (nonatomic,assign)NSInteger rightFont;


@end
