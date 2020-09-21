//
//  GateViewController.m
//  Runner
//
//  Created by GuJitao on 2020/9/17.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "GateViewController.h"
#import "FlutterBoost.h"
#import "WangpoPlugin.h"

@interface GateViewController ()

@end

@implementation GateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNativeCallback];
}

- (void)dealloc {
    [self unremoveNaiveCallback];
}


-(IBAction)pushCallNativeMethodPage:(id)sender {
    [FlutterBoostPlugin open:@"call/native/method/page" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
    
}

-(IBAction)pushReceiveNativeMethodPage:(id)sender {
    [FlutterBoostPlugin open:@"receive/native/method/page" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
    
}


-(IBAction)pushPassNativeBlockPage:(id)sender {
    [FlutterBoostPlugin open:@"pass/native/block/page" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
    }];
    
}


-(void)registerNativeCallback {
    
    __weak typeof(self) weakSelf = self;
    [WangpoPlugin registerNativeCallbak:@"refresh/gate/page" callback:^NSDictionary *(NSDictionary *param) {
        [weakSelf refreshUI:param];
        return @{
            @"demoResult":@"RefershFinished"
        };
    }];
    
}


- (void)refreshUI:(NSDictionary *)param {
    NSLog(@"The refresh param is %@",param);
}

-(void)unremoveNaiveCallback {
    [WangpoPlugin removeNativeCallback:@"refresh/gate/page"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
