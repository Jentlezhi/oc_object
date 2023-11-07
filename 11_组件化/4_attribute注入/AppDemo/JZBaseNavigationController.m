//
//  JZBaseNavigationController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZBaseNavigationController.h"

@interface JZBaseNavigationController ()

@end

@implementation JZBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 15.0, *)){
           UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
           appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
           self.navigationBar.scrollEdgeAppearance = appearance;
       }
}

@end
