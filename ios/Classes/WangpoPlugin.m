#import "WangpoPlugin.h"

static NSMutableDictionary * _nativeMethodBuffer = nil;
static NSString* const WPKeyMethodName = @"methodName";
static NSString* const WPKeyMethodParams = @"methodParams";

@implementation WangpoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"wangpo"
            binaryMessenger:[registrar messenger]];
  WangpoPlugin* instance = [[WangpoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

+ (NSMutableDictionary *)nativeMethodBuffer {
    if (nil == _nativeMethodBuffer) {
        _nativeMethodBuffer = [[NSMutableDictionary alloc] init];
    }
    return _nativeMethodBuffer;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"callNativeMethod" isEqualToString:call.method]) {
        return [self processCallNativeMethod:call result:result];
    }
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}




/**
注册Native方法，可以被Flutter调用
method: 注册的方法名
callback: 执行的callback
*/
+(void)registerNativeCallbak:(NSString *)methodName callback:(WPNativeMethodCallback)callback {
    NSAssert(methodName.length > 0, @"Method name should not be nil in WangpoPlugin");
    NSMutableDictionary *buffer = [self nativeMethodBuffer];
    WPTarget *target = [buffer objectForKey:methodName];
    NSAssert(nil == target, @"duplicated method name %@",methodName);
    target = [[WPTarget alloc] init];
    target.methodName = methodName;
    target.nativeMethodCallback = callback;
    buffer[methodName] = target;
}

/**
 移除注册的Native方法，移除之后，不再被Flutter调用
 method:注册的方法名
 */
+(void)unregisterNativeCallback:(NSString *)methodName {
    NSAssert(methodName.length > 0, @"Method name should not be nil in WangpoPlugin");
    NSMutableDictionary *buffer = [self nativeMethodBuffer];
    WPTarget *target = [buffer objectForKey:methodName];
    if (nil == target) {
        return;
    }
    [buffer removeObjectForKey:methodName];
    
}

- (void)processCallNativeMethod:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *methodName = call.arguments[WPKeyMethodName];
    NSAssert(methodName.length > 0, @"Can not process nil method name");
    NSDictionary *methodParams = call.arguments[WPKeyMethodParams];
    NSMutableDictionary *buffer = [WangpoPlugin nativeMethodBuffer];
    WPTarget *target = [buffer objectForKey:methodName];
    if (nil == target) {
        NSAssert(NO, @"no method %@ is register",methodName);
        return;
    }
    NSDictionary *resultDict = target.nativeMethodCallback(methodParams);
    result(resultDict);
    return ;
}



@end
