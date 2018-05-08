//
//  DeleteBtnView.h
//  OA-SMT
//
//  Created by Slark on 2018/3/2.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteBtnView : UIView
- (IBAction)DeleteClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *contenImageView;
@property (nonatomic,copy)void(^deleteBtnAction)(void);
@property (nonatomic,assign)BOOL deleteBtnHidden;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;


+ (instancetype)createBtnView;
@end
