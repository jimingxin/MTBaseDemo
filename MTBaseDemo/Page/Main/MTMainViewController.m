//
//  MTMainViewController.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTMainViewController.h"

@interface MTMainViewController ()

@property (nonatomic, strong) UIButton  *btn_center;

@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)setupUI{
    
    self.title = @"首页";
    
    [self.view addSubview:self.btn_center];
    
}

- (void)setupEvent{
    
    MTWeakSelf(weakself)
    // 按钮返回事件
    RACSubject *subject_back = [self getBackSubject];
    [subject_back subscribeNext:^(id  _Nullable x) {
        // 返回按钮触发
        MTLog(@"返回按钮触发");
    }];
    
    // 网络请求
    [[MTSeesionManager shareInstance] requestForGetBaiDu:nil withSuccess:^(MTResponseModel * _Nonnull responseModel) {
        
    } withFailure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupConstraint{
    MTWeakSelf(weakself)
    [_btn_center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 56));
        make.centerX.mas_equalTo(weakself.view.mas_centerX);
        make.centerY.mas_equalTo(weakself.view.mas_centerY);
    }];
    
    didLayout(^{
        weakself.btn_center.conrnerCorner(UIRectCornerAllCorners).conrnerRadius(28.f).showVisual();
    });
}

#pragma mark - 懒加载
-(UIButton *)btn_center{
    
    if (_btn_center == nil) {
        _btn_center = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"点击" forState:UIControlStateNormal];
            [btn setBackgroundColor:MT_ColorRGBA(23, 25, 133, 1)];
            MTWeakSelf(weakself)
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                MTLog(@"点击了按钮")
                UIViewController *vc = [[NSClassFromString(@"MTTestViewController") alloc]  init];
                
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
            btn;
        });
    }
    return _btn_center;
    
}

@end
