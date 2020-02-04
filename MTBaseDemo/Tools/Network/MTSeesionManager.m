//
//  MTSeesionManager.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTSeesionManager.h"



static MTSeesionManager *_instance;

@implementation MTSeesionManager


/// 监听网络的状态
/// @param block 网络状态的回调
+ (void)monitoringNetworkState:(void (^)(NSInteger))block{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                MTLog(@"[网络状态切换]--未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                MTLog(@"[网络状态切换]--无法联网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                MTLog(@"[网络状态切换]--当前使用的是2g/3g/4g网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                MTLog(@"[网络状态切换]--当前在WIFI网络下");
            }
                
        }
        block(status);
    }];
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MTSeesionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
        _instance.responseSerializer =  [AFJSONResponseSerializer serializer];
        _instance.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
        _instance.requestSerializer.timeoutInterval = 60;
    });
    return _instance;
}

+(NSString *) baseURL{
    return @"";
}


#pragma mark - 统一Post和Get请求
/**
 封装网络请求，统一处理token过期，跳转到登录页面
 
 @param URLString 请求的URL
 @param parameters 请求的参数
 @param uploadProgress 上传的进度
 @param success 成功的回调
 @param failure 失败的回调
 @return NSURLSessionDataTask对象
 */
- (NSURLSessionDataTask *)MT_GET:(NSString *)URLString
                      parameters:(id)parameters
                        progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    
    
    NSURLSessionDataTask *task = [self GET:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = (NSDictionary *) responseObject;
        
        success(task,dataDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 登录请求的参数和
        if (failure) {
            failure(task,error);
        }
        
    }];
    
    return task;
}

/**
 封装网络请求，统一处理token过期，跳转到登录页面
 
 @param URLString 请求的URL
 @param parameters 请求的参数
 @param uploadProgress 上传的进度
 @param success 成功的回调
 @param failure 失败的回调
 @return NSURLSessionDataTask对象
 */
- (NSURLSessionDataTask *)MT_POST:(NSString *)URLString
                       parameters:(id)parameters
                         progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                          success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    
    
    NSURLSessionDataTask *task = [self POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = (NSDictionary *) responseObject;
        
        success(task,dataDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 登录请求的参数和
        if (failure) {
            failure(task,error);
        }
    }];
    return task;
}



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
- (NSURLSessionDataTask *)mt_requestWithParameters:(NSDictionary *)srcparas methond:(MTNetMethod) netMethod relativeURL:(NSString *)relativeURL networkType:(MTBaseNetType)networkType responseClass:(Class)responCls success:(void (^)(id responseModel))success failure:(void (^)(NSError *error))failure {
    
    // 完成后的回调
    void(^successBlock)(NSURLSessionDataTask * _Nonnull,id  _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSDictionary *responseDictionary = [self mt_calibratedInfoFrom:networkType rawDict:responseObject];
        
        NSError *error = nil;
        
        NSObject *list = [(JSONModel *)[responCls alloc] initWithDictionary:responseDictionary error:&error];
        
        if (error == nil) {
            if ([list isKindOfClass:[MTResponseModel class]]) {
                MTResponseModel *respnseModel = (MTResponseModel *)list;
                if ([respnseModel.code intValue] == 0) {
                    if (success){
                        success(list); // 远程数据解析成功, 回到主线程
                    }
                }else{
                    NSError *error = [NSError errorWithDomain:MT_ErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:respnseModel.msg?:@"操作失败"}];
                    if (failure) {
                        failure(error);
                    }
                }
            }else{
                if (success){
                    success(list); // 远程数据解析成功, 回到主线程
                }
            }
            
        }else{
            
            if (failure) {
                failure(error);
            }
        }
    };
    
    // 失败后的回调
    void (^failureBlock)(NSURLSessionDataTask * , NSError *) = ^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error){
        // 登录请求的参数和
        if (failure) {
            failure(error);
            
        }
    };
    
    // 根据请求类型使用不同的请求方法
    NSURLSessionDataTask *task =  nil;
    
    if (networkType == MTNetMethod_GET) {
        task = [self MT_GET:relativeURL parameters:srcparas progress:^(NSProgress * _Nonnull uploadProgress) {} success:successBlock failure:failureBlock];
    }else{
        task = [self MT_POST:relativeURL parameters:srcparas progress:^(NSProgress * _Nonnull uploadProgress) {} success:successBlock failure:failureBlock];
        
    }
    
    return task;
}


#pragma mark - 处理请求返回的参数
/*! 顺利转化为model, 需要统一字典的格式 */
- (NSDictionary *)mt_calibratedInfoFrom:(MTBaseNetType) netType rawDict:(NSDictionary *)rawDict{
    
    NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] initWithDictionary:rawDict];
    
    return responseDictionary;
}


@end
