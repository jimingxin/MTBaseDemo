//
//  MTBaseViewController.h
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;
NS_ASSUME_NONNULL_BEGIN

@interface MTBaseViewController : UIViewController


// 设置布局
- (void) setupUI;

// 设置相关事件处理
- (void) setupEvent;

// 设置约束布局
- (void) setupConstraint;

/// 自定义返回按钮 子类可以重写，不需要super调用
- (UIButton *) getNavigationBarBackButton;

// 返回返回按钮的触发事件
- (RACSubject *) getBackSubject;

@end

NS_ASSUME_NONNULL_END
