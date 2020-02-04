//
//  MTBaseViewController.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTBaseViewController.h"

@interface MTBaseViewController ()

// 返回按钮触发事件
@property (nonatomic, strong) RACSubject  *subject_back;

@end

@implementation MTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    [self setupConstraint];
    
    [self setupEvent];
}


#pragma mark - 下面三个方法需要重写
- (void) setupUI{
    self.view.backgroundColor = UIColor.whiteColor;
}


- (void)setupEvent{}


// 设置约束布局
- (void) setupConstraint{}


#pragma mark - 设置返回按钮

/// 设置返回按钮
- (void) setNavigationBarBackButton{
    UIButton *left_bar = [self getNavigationBarBackButton];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:left_bar];
    self.navigationItem.leftBarButtonItems = @[leftItem];
}


/// 自定义返回按钮
- (UIButton *) getNavigationBarBackButton{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    MTWeakSelf(weakself)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself.subject_back sendNext:@(YES)];
    }];
    [btn sizeToFit];
    return btn;
}

// 返回返回按钮的触发事件
- (RACSubject *) getBackSubject{
    return self.subject_back;
}

#pragma mark - 懒加载

- (RACSubject *)subject_back{
    
    if (_subject_back) {
        _subject_back = [RACSubject subject];
    }
    return _subject_back;
    
}
@end
