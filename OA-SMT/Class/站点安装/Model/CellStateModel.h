//
//  CellStateModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface CellStateModel : BaseModel
@property (nonatomic, assign) BOOL state;//当前安装事项是否完成
@property (nonatomic, copy) NSString *problem;//当前安装事项的遗留问题
@end
