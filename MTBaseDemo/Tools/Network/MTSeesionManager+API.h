//
//  MTSeesionManager+API.h
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//


#import "MTSeesionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTSeesionManager (API)


/**
 测试网络请求
 
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return NSURLSessionTask 对象
 */
- (NSURLSessionTask *) requestForGetBaiDu:(NSDictionary *) params withSuccess:(void(^)(MTResponseModel *responseModel))success withFailure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
