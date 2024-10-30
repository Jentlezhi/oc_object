//
//  UIApplication+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/09/10.
//

#import "UIApplication+YYExtension.h"

@implementation UIApplication (YYExtension)

/**
 获取当前窗口控制器
 */
+ (UIViewController *)currentViewController {
    return [self _findCurrentViewControllerFrom:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController *)_findCurrentViewControllerFrom:(UIViewController *)fromVC {
    UIViewController *currentVC;
    if ([fromVC presentedViewController]) {
        UIViewController *nextRootVC = [fromVC presentedViewController];
        currentVC = [self _findCurrentViewControllerFrom:nextRootVC];
    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *nextRootVC = [(UITabBarController *)fromVC selectedViewController];
        currentVC = [self _findCurrentViewControllerFrom:nextRootVC];
    } else if ([fromVC isKindOfClass:[UINavigationController class]]) {
        UIViewController *nextRootVC = [(UINavigationController *)fromVC visibleViewController];
        currentVC = [self _findCurrentViewControllerFrom:nextRootVC];
    } else {
        currentVC = fromVC;
    }
    return currentVC;
}
+ (UIViewController *)controllerForCurrentView:(nonnull UIView*)currentView {
    
    
    return nil;
}

@end
