//
//  MTBaseTabBarController.m
//  MTBaseDemo
//
//  Created by 嵇明新 on 2020/2/4.
//  Copyright © 2020 jmx. All rights reserved.
//

#import "MTBaseTabBarController.h"
#import "MTMainViewController.h"
#import "MTMineViewController.h"

@interface MTBaseTabBarController ()

@end

@implementation MTBaseTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置页面控制器
    [self setupViewControllers];
    
    [self setSelectedIndex:0];
}


#pragma mark - Method
- (void) setupViewControllers{
    
    // 需要在（setViewControllers:） 方法之前
    self.tabBarItemsAttributes = [self tabBarItemsAttributesForController];
    [self setViewControllers:[self viewControllers]];
    
}



- (NSArray *)viewControllers {
    
   MTMainViewController *mainVC = [[MTMainViewController alloc] init];
   UIViewController *firstNavigationController = [[MTBaseNavigationController alloc] initWithRootViewController:mainVC];

    MTMineViewController *mineVC = [[MTMineViewController alloc] init];
   UIViewController *secondNavigationController = [[MTBaseNavigationController alloc]initWithRootViewController:mineVC];
   NSArray *viewControllers = @[
                                firstNavigationController,
                                secondNavigationController,
                                ];
   return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
   NSDictionary *firstTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemImage : @"main_unsel",  /* NSString and UIImage are supported*/
                                                CYLTabBarItemSelectedImage : @"main_sel",  /* NSString and UIImage are supported*/
                                                };
   NSDictionary *secondTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我的",
                                                 CYLTabBarItemImage : @"mine_unsel",
                                                 CYLTabBarItemSelectedImage : @"mine_sel",
                                                 };
   

   NSArray *tabBarItemsAttributes = @[
                                      firstTabBarItemsAttributes,
                                      secondTabBarItemsAttributes,
                                      ];
   return tabBarItemsAttributes;
}




@end
