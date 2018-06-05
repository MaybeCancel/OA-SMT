//
//  ReportModel.m
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel

-(NSString *)city{
    if (!_city) {
        _city = @"";
    }
    return _city;
}

-(NSString *)province{
    if (!_province) {
        _province = @"";
    }
    return _province;
}

-(NSString *)clientName{
    if (!_clientName) {
        _clientName = @"";
    }
    return _clientName;
}

-(NSString *)networkType{
    if (!_networkType) {
        _networkType = @"";
    }
    return _networkType;
}

-(NSString *)projectName{
    if (!_projectName) {
        _projectName = @"";
    }
    return _projectName;
}

-(NSString *)poCode{
    if (!_poCode) {
        _poCode = @"";
    }
    return _poCode;
}

-(NSString *)orderCode{
    if (!_orderCode) {
        _orderCode = @"";
    }
    return _orderCode;
}

-(NSString *)logisticsCode{
    if (!_logisticsCode) {
        _logisticsCode = @"";
    }
    return _logisticsCode;
}

-(NSString *)stationName{
    if (!_stationName) {
        _stationName = @"";
    }
    return _stationName;
}

-(NSString *)freightCode{
    if (!_freightCode) {
        _freightCode = @"";
    }
    return _freightCode;
}

-(NSString *)packageCode{
    if (!_packageCode) {
        _packageCode = @"";
    }
    return _packageCode;
}

-(NSString *)packageNum{
    if (!_packageNum) {
        _packageNum = @"";
    }
    return _packageNum;
}

-(NSString *)level{
    if (!_level) {
        _level = @"";
    }
    return _level;
}

-(NSString *)modelCode{
    if (!_modelCode) {
        _modelCode = @"";
    }
    return _modelCode;
}

-(NSString *)note{
    if (!_note) {
        _note = @"";
    }
    return _note;
}

-(NSString *)totalCount{
    if (!_totalCount) {
        _totalCount = @"";
    }
    return _totalCount;
}

-(NSString *)serialCode{
    if (!_serialCode) {
        _serialCode = @"";
    }
    return _serialCode;
}
-(NSString *)optDate{
    if (!_optDate) {
        _optDate = @"";
    }
    return _optDate;
}

-(NSString *)imgs{
    if (!_imgs) {
        _imgs = @"";
    }
    return _imgs;
}

-(NSString *)optStationId{
    if (!_optStationId) {
        _optStationId = @"";
    }
    return _optStationId;
}

-(NSString *)optNote{
    if (!_optNote) {
        _optNote = @"";
    }
    return _optNote;
}

-(NSString *)hasProblem{
    if (!_hasProblem) {
        _hasProblem = @"";
    }
    return _hasProblem;
}



@end
