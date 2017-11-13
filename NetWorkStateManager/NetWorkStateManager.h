//
//  NetWorkStateManager.h
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/19.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NetWorkStateChangedNotificationName @"NetWorkStateChanged"



typedef NS_ENUM(NSInteger, NetWorkState) {
    NetWorkStateUnknown          = -1,//未识别的网络
    NetWorkStateNotReachable     = 0,//不可达的网络
    NetWorkStateReachableViaWiFi = 1,//wifi网络
    NetWorkStateReachableViaWwan = 2,//蜂窝网络
    
};

@interface NetWorkStateManager : NSObject


+ (instancetype)shareManager;

//当前网络状态
@property (readonly, nonatomic)  NetWorkState netWorkState;
//当前的wifi标识
@property (readonly,copy, nonatomic) NSString *wifiBSSID;

- (BOOL)isWiFiOpend;

@end
