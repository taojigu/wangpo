#import <Flutter/Flutter.h>
#import "WPTarget.h"


@interface WangpoPlugin : NSObject<FlutterPlugin>


/**
注册Native方法，可以被Flutter调用
method: 注册的方法名
callback: 执行的callback
*/
+(void)registerNativeCallbak:(NSString *)methodName callback:(WPNativeMethodCallback)callback;

/**
 移除注册的Native方法，移除之后，不再被Flutter调用
 method:注册的方法名
 */
+(void)removeNativeCallback:(NSString *)methodName;


@end
