//
//  UINavigationController+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UINavigationController+YYExtension.h"

@implementation UINavigationController (YYExtension)

/**
 移除指定的控制器
 @param controllerName    待移除的控制器名称
 */
- (void)removeViewControllerWithControllerName:(nonnull NSString *)controllerName {
    if (controllerName == nil || controllerName.length == 0){return;}
    return [self removeViewControllersWithClassNames:@[controllerName]];
}
/**
 移除指定的控制器
 @param viewController    待移除的控制器
 @return                  已移除的控制器
 */
- (UIViewController *)removeViewController:(nonnull UIViewController *)viewController {
    return [self removeViewController:viewController animated:NO];
}
/**
 移除指定的控制器
 @param viewController    待移除的控制器
 @param animated          显示动画
 @return                  已移除的控制器
 */
- (UIViewController *)removeViewController:(nonnull UIViewController *)viewController
                                  animated:(BOOL)animated {
    if (!viewController){return nil;}
    if ([self.viewControllers containsObject:viewController]) {
        return [self popViewControllerAnimated:animated];
    }
    return nil;
}
/**
 移除导航控制器的子控制器
 @param classNames      子控制器类名
 */
- (void)removeViewControllersWithClassNames:(nonnull NSArray <NSString*> *)classNames {
    [self removeViewControllersWithClassNames:classNames reverse:YES];
}
/**
 移除导航控制器的子控制器
 @param classNames      子控制器类名
 @param reverse         逆向移除-从后往前遍历
 */
- (void)removeViewControllersWithClassNames:(nonnull NSArray <NSString*> *)classNames
                                    reverse:(BOOL)reverse {
    if (classNames == nil || classNames.count == 0){return;}
    NSMutableArray *clses = @[].mutableCopy;
    for (NSString *className in classNames) {
        Class cls = NSClassFromString(className);
        if (!cls) {continue;}
        [clses addObject:cls];
    }
    NSMutableArray *vcTemArray = self.viewControllers.mutableCopy;
    if (reverse) {
        vcTemArray = [[vcTemArray reverseObjectEnumerator] allObjects].mutableCopy;
    }
    NSMutableArray *removedArray = @[].mutableCopy;
    for (UIViewController *vc in vcTemArray) {
        if ([clses containsObject:[vc class]]) {
            [removedArray addObject:vc];
            [clses removeObject:[vc class]];
        }
        ///所有的类已移除，结束循环
        if (clses.count == 0) {
            break;
        }
    }
    if (removedArray.count > 0) {
        [vcTemArray removeObjectsInArray:removedArray];
    }
    if (reverse) {
        vcTemArray = [[vcTemArray reverseObjectEnumerator] allObjects].mutableCopy;
    }
    ///重置viewControllers
    self.viewControllers = vcTemArray.copy;
}

@end
