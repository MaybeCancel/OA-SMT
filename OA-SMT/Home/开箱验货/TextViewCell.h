//
//  TextViewCell.h
//  OA-SMT
//
//  Created by Slark on 2018/3/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TextViewCell : BaseTableViewCell<UITextViewDelegate>
@property (nonatomic,copy)NSString* placeHolder;
@property (strong, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
