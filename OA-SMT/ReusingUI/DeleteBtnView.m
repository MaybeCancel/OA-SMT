//
//  DeleteBtnView.m
//  OA-SMT
//
//  Created by Slark on 2018/3/2.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "DeleteBtnView.h"

@implementation DeleteBtnView

- (IBAction)DeleteClick:(id)sender {
    if(self.deleteBtnAction){
        self.deleteBtnAction();
    }
}
+ (instancetype)createBtnView{
    return [[[NSBundle mainBundle] loadNibNamed:@"DeleteBtnView" owner:nil options:nil] lastObject];
}
- (void)setDeleteBtnHidden:(BOOL)deleteBtnHidden{
    _deleteBtnHidden = deleteBtnHidden;
    self.deleteBtn.hidden = _deleteBtnHidden;
}
@end
