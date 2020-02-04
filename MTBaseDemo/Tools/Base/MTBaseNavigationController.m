//
//  MTBaseNavigationController.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTBaseNavigationController.h"

@interface MTBaseNavigationController ()

@end

@implementation MTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

/**
 防止页面不响应

 @param gestureRecognizer 手势操作
 @return Bool值
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    
    return YES;
    

}


//重写push后返回按钮的文字,文字可以为空字符串.
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count == 1) {
        
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    
    }
    //修改返回文字
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >=1) {
        
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
   
   
   UIViewController *viewVC = [super popViewControllerAnimated:animated];
   
    if (self.viewControllers.count == 1) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return viewVC;
}
-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *vcs = [super popToRootViewControllerAnimated:animated];
    
    return vcs;
}



-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
}

-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}


@end
