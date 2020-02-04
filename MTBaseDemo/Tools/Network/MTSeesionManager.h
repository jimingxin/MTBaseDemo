//
//  MTSeesionManager.h
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MTNetMethod) {
    MTNetMethod_GET,
    MTNetMethod_POST,
};

typedef NS_ENUM(NSUInteger, MTBaseNetType) {
    MTBaseNetTypeDefault,
};


@interface MTSeesionManager : AFHTTPSessionManager

/// 单例
+(instancetype) shareInstance;

/// 监听网络的状态
/// @param block 网络状态的回调
+ (void)monitoringNetworkState:(void (^)(NSInteger))block;

#pragma mark - 网络相关请求

/**
 Post统一请求接口
 
 @param srcparas 请求参数
 @param relativeURL 网络请求接口
 @param netMethod  请求的网络类型 get post
 @param networkType 请求的类型
 @param responCls 需要转的模型类
 @param success 请求成功回调Block
 @param failure 请求失败回调Block
 @return NSURLSessionDataTask 实例
 */
- (NSURLSessionDataTask *)mt_requestWithParameters:(NSDictionary *)srcparas methond:(MTNetMethod) netMethod relativeURL:(NSString *)relativeURL networkType:(MTBaseNetType)networkType responseClass:(Class)responCls success:(void (^)(id responseModel))success failure:(void (^)(NSError *error))failure ;

@end

NS_ASSUME_NONNULL_END
