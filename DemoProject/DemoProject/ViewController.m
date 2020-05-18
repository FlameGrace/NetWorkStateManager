//
//  ViewController.m
//  DemoProject
//
//  Created by Flame Grace on 2019/12/20.
//  Copyright © 2019 Flame Grace. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NSObject+FGObserverNetWorkState.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"A";
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 44)];
    [btn setTitle:@"oberve notification" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(obervenotification) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 200, 44)];
        [btn setTitle:@"disoberve notification" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(disobervenotification) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 200, 44)];
        [btn setTitle:@"Push To Next VC" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)obervenotification{
    [self observeNotification_ForNetWorkState_fg];
}

- (void)disobervenotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)netWorkStateLost_fg{
    NSLog(@"netWorkStateLost");
}

- (void)netWorkStateReConnect_fg{
    NSLog(@"netWorkStateReConnect");
}

- (void)pushToNextVC{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"B";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
