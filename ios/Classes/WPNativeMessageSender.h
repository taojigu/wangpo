//
//  WPNativeMessageSender.h
//  flutter_boost
//
//  Created by GuJitao on 2020/9/22.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

typedef void(^WPFlutterMethodResultBock)(id _Nullable );

NS_ASSUME_NONNULL_BEGIN

/**
 Native调用Flutter的的方法类
 */
@interface WPNativeMessageSender : NSObject

/**
 构造方法
 channelName: 消息通道名称，在dart端需要注册相同的channelName
 */
- (instancetype)initWithChannelName:(NSString *)channelName messenger:(NSObject<FlutterBinaryMessenger> *)messenger;


/**
 调用Flutter端定义的方法
 methodName：方法名，需要在Dart端区分处理
 param: 方法参数
 resultBlock： Dart方法返回的结果调用
 */
- (void)invokeFlutterMethod:(NSString *)methodName params:(NSDictionary *)params resultBlock:(WPFlutterMethodResultBock)resultBlock;

@end

NS_ASSUME_NONNULL_END
