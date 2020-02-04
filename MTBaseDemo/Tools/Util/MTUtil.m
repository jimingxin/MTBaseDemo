//
//  MTUtil.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTUtil.h"

/// 用于UI更新
void didLayout(void(^layout)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (layout) {
            layout();
        }
    });
}

@implementation MTUtil

@end
