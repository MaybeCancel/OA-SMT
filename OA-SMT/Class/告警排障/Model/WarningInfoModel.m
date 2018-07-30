//
//  WarningInfoModel.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WarningInfoModel.h"

@implementation WarningInfoModel

-(NSString *)alarmId{
    if (!_alarmId) {
        _alarmId = @"";
    }
    return _alarmId;
}

-(NSString *)projectName{
    if (!_projectName) {
        _projectName = @"";
    }
    return _projectName;
}

-(NSString *)alarmDate{
    if (!_alarmDate) {
        _alarmDate = @"";
    }
    return _alarmDate;
}

-(NSString *)alarmNote{
    if (!_alarmNote) {
        _alarmNote = @"";
    }
    return @"";
}

-(int)alarmLevel{
    if (!_alarmLevel) {
        _alarmLevel = 0;
    }
    return _alarmLevel;
}

-(NSString *)userName{
    if (!_userName) {
        _userName = @"";
    }
    return _userName;
}

-(NSString *)attachment{
    if (!_attachment) {
        _attachment = @"";
    }
    return _attachment;
}

-(NSString *)isSolve{
    if (!_isSolve) {
        _isSolve = @"";
    }
    return _isSolve;
}

-(int)questionType{
    if (!_questionType) {
        _questionType = 0;
    }
    return _questionType;
}

-(NSString *)question{
    if (!_question) {
        _question = @"";
    }
    return _question;
}

-(NSString *)imgs{
    if (!_imgs) {
        _imgs = @"";
    }
    return _imgs;
}


@end
