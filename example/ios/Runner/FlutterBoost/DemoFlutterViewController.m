//
//  DemoFlutterViewController.m
//  Runner
//
//  Created by GuJitao on 2020/9/17.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "DemoFlutterViewController.h"
#import "WPNativeMessageSender.h"

@interface DemoFlutterViewController ()

@property(nonatomic,strong) WPNativeMessageSender *messageSender;

@end

@implementation DemoFlutterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _messageSender = [[WPNativeMessageSender alloc] initWithChannelName:@"from/flutter/page" messenger:self.binaryMessenger];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
