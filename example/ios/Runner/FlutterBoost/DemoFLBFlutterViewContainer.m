//
//  DemoFLBFlutterViewContainer.m
//  Runner
//
//  Created by GuJitao on 2020/9/22.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "DemoFLBFlutterViewContainer.h"
#import "WPNativeMessageSender.h"

@interface DemoFLBFlutterViewContainer ()

@property(nonatomic,strong) WPNativeMessageSender *messageSender;
@property(nonatomic,assign) NSInteger currentProgress;

@end

@implementation DemoFLBFlutterViewContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        _messageSender = [[WPNativeMessageSender alloc] initWithChannelName:@"from/demo/flutter/boost/page" messenger:self.binaryMessenger];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItems];
    // Do any additional setup after loading the view.
}

- (void)initNavigationItems{
    UIBarButtonItem * increaseButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(increaseFlutterPage)];
    UIBarButtonItem *decreaseButton = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(decreaseFlutterPage)];
    self.navigationItem.rightBarButtonItems = @[increaseButton,decreaseButton];
}

- (void)increaseFlutterPage {
    
    NSDictionary *param = @{
        @"progress":@(self.currentProgress ++)
    };
    
    [self.messageSender invokeFlutterMethod:@"increase" params:param resultBlock:^(id _Nullable result) {
        NSLog(@"increase result is %@",result);
    }];
    
}

- (void)decreaseFlutterPage {
    NSDictionary *param = @{
        @"progress":@(self.currentProgress--)
    };
    [self.messageSender invokeFlutterMethod:@"decrease" params:param resultBlock:^(id _Nullable result) {
           NSLog(@"decrease result is %@",result);
    }];
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
