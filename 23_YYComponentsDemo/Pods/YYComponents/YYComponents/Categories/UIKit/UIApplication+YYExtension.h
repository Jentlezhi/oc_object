//
//  UIApplication+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/09/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (YYExtension)

/**
 获取当前窗口控制器
 */
+ (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
