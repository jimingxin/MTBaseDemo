//
//  NSNull+SafeNull.m
//  MoonTime
//
//  Created by 嵇明新 on 2019/12/30.
//  Copyright © 2019 jimingxin@CloundWalk.cn. All rights reserved.
//

#import "NSNull+SafeNull.h"
#import <objc/message.h>

#define NSNullObjectsArr @[@"", @0, @{}, @[]]

@implementation NSNull (SafeNull)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *obj in NSNullObjectsArr) {
            signature = [obj methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
    
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    for (NSObject *objc in NSNullObjectsArr) {
        if ([objc respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:objc];
            return;
        }
    }
}

@end
