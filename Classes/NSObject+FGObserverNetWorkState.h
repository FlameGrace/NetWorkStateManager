//
//  NSObject+LMVobserverNetWorkState.h
//  leapmotor
//
//  Created by 李嘉军 on 2017/7/19.
//  Copyright © 2017年 Leapmotor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+FGObserverNetWorkState.h"

@interface NSObject (FGObserverNetWorkState)

- (void)observeNotification_ForNetWorkState_fg;

- (void)netWorkStateChanged_fg:(NSNotification *)notification;

- (void)netWorkStateLost_fg;

- (void)netWorkStateReConnect_fg;

- (BOOL)netWorkStateCanReachable_fg;

@end
