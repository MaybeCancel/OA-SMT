//
//  AddImageView.h
//  OA-SMT
//
//  Created by Slark on 2018/3/1.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageView : UIView
@property (nonatomic,copy)NSString* title;
@property (nonatomic,strong)NSMutableArray* images;
@property (nonatomic,copy)void(^tapHandle)(void);
@property (nonatomic,copy)void(^deleteImageBlock)(int index);
- (void)reloadImageView;
@end
