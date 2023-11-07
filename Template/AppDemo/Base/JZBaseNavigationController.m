//
//  JZBaseNavigationController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZBaseNavigationController.h"

@interface JZBaseNavigationController ()

@property(nonatomic, strong) NSHashTable *table;

@end

@implementation JZBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [NSHashTable weakObjectsHashTable];
    if (@available(iOS 15.0, *)){
           UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
           appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
           self.navigationBar.scrollEdgeAppearance = appearance;
       }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *desc = [super popViewControllerAnimated:animated];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (desc != nil) {
//            NSLog(@"%@未被释放",[desc class]);
//        }
//    });
    
    return desc;
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    
    return [super popToRootViewControllerAnimated:animated];
}

@end
