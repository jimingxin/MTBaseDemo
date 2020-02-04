//
//  MTResponseModel.h
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTResponseModel : JSONModel

@property (nonatomic, copy) NSString  *code;

@property (nonatomic, copy) NSString  *msg;

@property (nonatomic, copy) NSMutableArray  *results;


@end

NS_ASSUME_NONNULL_END
