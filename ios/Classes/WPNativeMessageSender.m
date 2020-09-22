//
//  WPNativeMessageSender.m
//  flutter_boost
//
//  Created by GuJitao on 2020/9/22.
//

#import "WPNativeMessageSender.h"
#import <Flutter/Flutter.h>

@interface WPNativeMessageSender ()

@property (nonatomic,copy) NSString *channelName;
@property (nonatomic,strong) FlutterBasicMessageChannel *messageChannel;


@end

@implementation WPNativeMessageSender

- (instancetype)initWithChannelName:(NSString *)channelName messenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    _messageChannel = [FlutterBasicMessageChannel messageChannelWithName:channelName binaryMessenger:messenger];
    return self;
}

- (void)invokeFlutterMethod:(NSString *)methodName params:(NSDictionary *)params resultBlock:(WPFlutterMethodResultBock)resultBlock{
    
    NSDictionary * messgeDict = [self messageDict:methodName param:params];
    
    [self.messageChannel sendMessage:messgeDict reply:^(id  _Nullable reply) {
        if (nil != resultBlock) {
            resultBlock(reply);
        }
    }];
    
}

- (NSDictionary *)messageDict:(NSString *)methodName param:(NSDictionary *)param {
    return @{
        @"methodName":methodName,
        @"methodParam":param
    };
}




@end
