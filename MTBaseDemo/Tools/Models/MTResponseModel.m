//
//  MTResponseModel.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTResponseModel.h"

@implementation MTResponseModel


+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"code"]) {
        return YES;
    }else if ([propertyName isEqualToString:@"msg"]){
        return YES;
    }else if([propertyName isEqualToString:@"results"]){
        return YES;
    }
    return NO;
}


+ (JSONKeyMapper *)keyMapper{
    NSMutableDictionary *kmp = [NSMutableDictionary dictionary];
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:kmp];
    
}

@end
