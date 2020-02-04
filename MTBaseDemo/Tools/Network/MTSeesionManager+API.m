//
//  MTSeesionManager+API.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTSeesionManager+API.h"


@implementation MTSeesionManager (API)


/**
 测试网络请求
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionTask 对象
 */
- (NSURLSessionTask *) requestForGetBaiDu:(NSDictionary *) params withSuccess:(void(^)(MTResponseModel *responseModel))success withFailure:(void(^)(NSError *error))failure{
    
    NSString *url = [NSString stringWithFormat:@"https://www.moontime.cn/moon-backend/album/user/sendVerifyCode"];
    
    
    return [self mt_requestWithParameters:@{} methond:MTNetMethod_GET relativeURL:url networkType:MTBaseNetTypeDefault responseClass:MTResponseModel.class success:^(id  _Nonnull responseModel) {
        MTLog(@"网络请求成功");
    } failure:^(NSError * _Nonnull error) {
        MTLog(@"网络请求失败");
    }];
    
}


@end
