//
//  UrlDefine.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h

//服务器地址
#define BASE_URL @"http://118.31.79.88:8080/EricssonApp"

/*-----------------登录---------------*/
#define Login @"/account/login"

/*-----------------工程信息---------------*/
#define GetProjectInfo @"/project/getProjectInfo"

/*-----------------完工照片---------------*/
#define GetPhotoDevices @"/project/getPhotoDevices"
#define GetStationData @"/project/getStationData"
#define UploadPhoto @"/project/uploadPhoto"

/*-----------------签到---------------*/
#define SignIn @"/account/signIn"
#define StationsList @"/account/getStations"
#define SignInLog @"/account/getSignInLog"

/*-----------------站点安装---------------*/
#define InstallInfoList @"/project/installInfoList"
#define AddInstallInfo @"/project/addInstallInfo"
#define GetInstallInfo @"/project/getInstallInfo"

/*-----------------站点调测---------------*/
#define TestInfoList @"/project/testInfoList"
#define AddTestInfo @"/project/addTestInfo"

/*-----------------收货验货---------------*/
#define ReceiveGoodsList @"/project/receiveGoodsList"
#define ReceiveGoodsInfo @"/project/receiveGoodsInfo"
#define AddReceiveGoodsInfo @"/project/addReceiveGoodsInfo"
#define CloseTransportProblem @"/project/closeTransportProblem"

/*-----------------开箱验货---------------*/
#define CheckoutGoodsList @"/project/checkoutGoodsList"
#define CheckoutGoodsInfo @"/project/checkoutGoodsInfo"
#define AddCheckoutGoodsInfo @"/project/addCheckoutGoodsInfo"

/*-----------------上传照片---------------*/
#define UploadFile @"/account/uploadFile"

/*-----------------告警排障---------------*/
#define AlarmList @"/project/alarmList"
#define AlarmInfo @"/project/alarmInfo"
#define UpdateAlarm @"/project/updateAlarm"

/*-----------------待办事项---------------*/
#define GetSchedule @"/project/getSchedule"

/*-----------------整改闭环---------------*/
#define RectificationList @"/project/getRectificationList"
#define RectificationInfo @"/project/getRectificationInfo"
#define UpdateRectificationInfo @"/project/updateRectificationInfo"

#endif /* UrlDefine_h */
