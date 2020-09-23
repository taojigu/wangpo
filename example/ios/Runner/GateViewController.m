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
#import "DemoFLBFlutterViewContainer.h"

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
    
    DemoFLBFlutterViewContainer *dflbvc = [[DemoFLBFlutterViewContainer alloc] init];
    [dflbvc setName:@"receive/native/method/page" params:@{}];
    [self.navigationController pushViewController:dflbvc animated:YES];
    
}


-(IBAction)pushPassNativeBlockPage:(id)sender {
    FLBFlutterViewContainer *fbvc = [[FLBFlutterViewContainer alloc] init];
    
    int (^block1)(int) = ^(int value){
        return 0;
    };
    
    NSString *(^ block2)(NSDictionary *) = ^(id params) {
        return @"hello";
    };
    
    NSString* blockID1 = [self blockID:block2];
    
    
    //定义官方的block回调
    //全局变量或者说当前的类内的block管理工具
    //生成自定义的block identier

    [fbvc setName:@"pass/native/block/page" params:@{
        
    }];
    [self.navigationController pushViewController:fbvc animated:YES];
    
}

- (NSString *)blockID:(id(^)(id))block{
    return @"hello";
}


-(void)registerNativeCallback {
    
    __weak typeof(self) weakSelf = self;
    
    [WangpoPlugin registerNativeCallbak:@"refresh/gate/page" callback:^(NSObject * _Nullable param, FlutterResult  _Nonnull flutterResult) {
        NSDictionary *dict = (NSDictionary *)param;
        [weakSelf refreshUI:dict];
        NSDictionary *resultMap = @{
            @"demoResult":@"RefershFinished"
        };
        flutterResult(resultMap);
        return ;
    }];

}


- (void)refreshUI:(NSDictionary *)param {
    NSLog(@"The refresh param is %@",param);
}

-(void)unremoveNaiveCallback {
    [WangpoPlugin unregisterNativeCallback:@"refresh/gate/page"];
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
