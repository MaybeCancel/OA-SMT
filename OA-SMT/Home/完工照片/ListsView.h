//
//  ListsView.h
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListsView : UIView
@property (nonatomic,copy)void (^picPositionAction)(NSString* devicePart,NSString* detailPart,NSString* deviceId,NSString* positionId);


@property (nonatomic,copy)NSString* rightString;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSMutableArray* data2Array;

- (instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName;
- (void)hiddenTable;
@end
