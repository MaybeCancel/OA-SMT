//
//  BaseTextView.h
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextView : UIView<UITextViewDelegate>
@property (nonatomic,copy)NSString* topString;
@property (nonatomic,copy)NSString* placeholderString;
@end
