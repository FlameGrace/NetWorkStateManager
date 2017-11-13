//
//  NetWorkStateManager.m
//  flamegrace@hotmail.com
//
//  Created by Flame Grace on 16/9/19.
//  Copyright © 2016年 flamegrace@hotmail.com. All rights reserved.
//

#import "NetWorkStateManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>


@interface NetWorkStateManager()


@property (strong, nonatomic) Reachability *netWorkReachability;
@property (readwrite, nonatomic)  NetWorkState netWorkState;


@end


@implementation NetWorkStateManager

static NetWorkStateManager *shareManager = nil;


+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[NetWorkStateManager alloc]init];
    });
    return shareManager;
}

- (id)init
{
    if(self = [super init])
    {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        self.netWorkReachability = [Reachability reachabilityForInternetConnection];
        [self getCurrentNetWorkState];
        [self.netWorkReachability startNotifier];
    }
    return self;
}



- (void)reachabilityChanged:(NSNotification *)notification
{
    [self getCurrentNetWorkState];
    
}

//获取当前网络状态
- (void)getCurrentNetWorkState
{
    
    NetWorkState lastNetWorkState = self.netWorkState;
    
    NetworkStatus internetStatus = [_netWorkReachability currentReachabilityStatus];
    NetWorkState netWorkState;
    switch (internetStatus) {
        case ReachableViaWiFi:
            netWorkState = NetWorkStateReachableViaWiFi;
            break;
            
        case ReachableViaWWAN:
            netWorkState = NetWorkStateReachableViaWwan;
            break;
            
        case NotReachable:
            netWorkState = NetWorkStateNotReachable;
            break;
        default:
            netWorkState = NetWorkStateUnknown;
            break;
    }
    
    self.netWorkState = netWorkState;
    
    if(lastNetWorkState != self.netWorkState)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:NetWorkStateChangedNotificationName object:nil];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (NSString *)wifiBSSID
{
    if(self.netWorkState != NetWorkStateReachableViaWiFi)
    {
        return nil;
    }
    return [self getWIFIBSSID];
}


- (NSString *)getWIFIBSSID
{
    NSString *BSSID = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        BSSID = info[@"BSSID"];
    }
    return BSSID;
}

- (BOOL)isWiFiOpend
{
    NSCountedSet * cset = [[NSCountedSet alloc] init];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}

@end
