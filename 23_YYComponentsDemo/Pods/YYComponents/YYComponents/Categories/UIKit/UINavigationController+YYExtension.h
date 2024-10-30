//
//  UINavigationController+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (YYExtension)
/**
 移除指定的控制器
 @param controllerName    待移除的控制器名称
 */
- (void)removeViewControllerWithControllerName:(nonnull NSString *)controllerName;
/**
 移除指定的控制器
 @param viewController    待移除的控制器
 @return                  已移除的控制器
 */
- (UIViewController *)removeViewController:(nonnull UIViewController *)viewController;

/**
 移除指定的控制器
 @param viewController    待移除的控制器
 @param animated          显示动画
 @return                  已移除的控制器
 */
- (UIViewController *)removeViewController:(nonnull UIViewController *)viewController
                                  animated:(BOOL)animated;

/**
 移除导航控制器的子控制器
 @param classNames      子控制器类名
 */
- (void)removeViewControllersWithClassNames:(nonnull NSArray <NSString*> *)classNames;
/**
 移除导航控制器的子控制器
 @param classNames      子控制器类名
 @param reverse         逆向移除-从后往前遍历
 */
- (void)removeViewControllersWithClassNames:(nonnull NSArray <NSString*> *)classNames
                                    reverse:(BOOL)reverse;

@end

NS_ASSUME_NONNULL_END
