//
//  NSObject+LMVobserverNetWorkState.m
//  leapmotor
//
//  Created by 李嘉军 on 2017/7/19.
//  Copyright © 2017年 Leapmotor. All rights reserved.
//

#import "NSObject+FGObserverNetWorkState.h"
#import "AFNetworking.h"
#import <objc/runtime.h>

@implementation NSObject (FGObserverNetWorkState)



- (void)observeNotification_ForNetWorkState_fg
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netWorkStateChanged_fg_private:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    self.networkReachabilityStatus_fg_private = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (BOOL)netWorkStateCanReachable_fg
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (void)netWorkStateChanged_fg:(NSNotification *)notification
{
    
}

- (void)netWorkStateLost_fg
{
    
}

- (void)netWorkStateReConnect_fg
{
    
}


- (BOOL)netWorkStateCanReachable_fg_private:(AFNetworkReachabilityStatus)status{
    if(status == AFNetworkReachabilityStatusUnknown ||
    status == AFNetworkReachabilityStatusNotReachable){
        return NO;
    }
    return YES;
}


- (void)netWorkStateChanged_fg_private:(NSNotification *)notification
{
    AFNetworkReachabilityStatus newNetworkReachabilityStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    //必须网络真正变化
    if(newNetworkReachabilityStatus == self.networkReachabilityStatus_fg_private){
        return;
    }
    BOOL oldnetWorkStateCanReachable_fg = [self netWorkStateCanReachable_fg_private:self.networkReachabilityStatus_fg_private];
    BOOL netWorkStateCanReachable_fg = [self netWorkStateCanReachable_fg];
    //发出网络变化通知
    self.networkReachabilityStatus_fg_private = newNetworkReachabilityStatus;
    [self netWorkStateChanged_fg:notification];
    //判断网络有没有真正在无网和有网之间变化
    if(netWorkStateCanReachable_fg != oldnetWorkStateCanReachable_fg){
        if(netWorkStateCanReachable_fg){
            [self netWorkStateReConnect_fg];
        }else{
            [self netWorkStateLost_fg];
        }
    }
}





//使用动态运行时添加数组对象multiDelegates，保存代理
- (void)setNetworkReachabilityStatus_fg_private:
(AFNetworkReachabilityStatus)networkReachabilityStatus_fg_private
{
    objc_setAssociatedObject(self, @selector(networkReachabilityStatus_fg_private), @(networkReachabilityStatus_fg_private), OBJC_ASSOCIATION_RETAIN);
}

- (AFNetworkReachabilityStatus)networkReachabilityStatus_fg_private
{
    NSNumber *networkReachabilityStatus_fg_private = objc_getAssociatedObject(self,@selector(networkReachabilityStatus_fg_private));
    if(networkReachabilityStatus_fg_private == nil)
    {
        networkReachabilityStatus_fg_private = @(AFNetworkReachabilityStatusUnknown);
        objc_setAssociatedObject(self, @selector(networkReachabilityStatus_fg_private), networkReachabilityStatus_fg_private, OBJC_ASSOCIATION_RETAIN);
    }
    return (AFNetworkReachabilityStatus)networkReachabilityStatus_fg_private.integerValue;
}

@end
