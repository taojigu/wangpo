//
//  WPTarget.h
//  用来承担注册的Native 被调用callback的载体
//
//  Created by GuJitao on 2020/9/21.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

//Native 定义的方法类型
typedef void (^WPNativeMethodCallback)(NSObject* _Nullable param,FlutterResult _Nonnull flutterResult);


NS_ASSUME_NONNULL_BEGIN

@interface WPTarget : NSObject

@property(nonatomic,copy) NSString *methodName;
@property(nonatomic,copy) WPNativeMethodCallback nativeMethodCallback;

@end

NS_ASSUME_NONNULL_END



