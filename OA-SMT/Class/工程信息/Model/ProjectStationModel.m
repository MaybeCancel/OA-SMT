//
//  ProjectStationModel.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProjectStationModel.h"

@implementation ProjectStationModel

-(NSString *)stationId{
    if (!_stationId) {
        _stationId = @"";
    }
    return _stationId;
}

-(NSString *)stationCode{
    if (!_stationCode) {
        _stationCode = @"";
    }
    return _stationCode;
}

-(NSString *)stationName{
    if (!_stationName) {
        _stationName = @"";
    }
    return _stationName;
}

-(NSString *)receiveDate{
    if (!_receiveDate) {
        _receiveDate = @"";
    }
    return _receiveDate;
}

-(NSString *)checkoutDate{
    if (!_checkoutDate) {
        _checkoutDate = @"";
    }
    return _checkoutDate;
}

-(NSString *)installDate{
    if (!_installDate) {
        _installDate = @"";
    }
    return _installDate;
}

-(NSString *)testDate{
    if (!_testDate) {
        _testDate = @"";
    }
    return _testDate;
}

-(NSString *)inspectDate{
    if (!_inspectDate) {
        _inspectDate = @"";
    }
    return _inspectDate;
}

-(NSString *)rectifyDate{
    if (!_rectifyDate) {
        _rectifyDate = @"";
    }
    return _rectifyDate;
}

-(NSString *)acceptDate{
    if (!_acceptDate) {
        _acceptDate = @"";
    }
    return _acceptDate;
}

@end
