//
//  JZUIKitExtension.m
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZTagLabel : UIView

/// 内容
@property(nonatomic, copy) NSString *text;
/// 字体
@property(nonatomic, strong) UIFont *textFont;
/// 字体颜色
@property(nonatomic, strong) UIColor *textColor;
/// 背景颜色
@property(nonatomic, strong) UIColor *textBackgroundColor;
/// 圆角
@property(nonatomic, assign) CGFloat cornerRadius;
/// 内容间距
@property(nonatomic, assign) UIEdgeInsets contentInsets;

/**
 标签初始化
 @param text                     内容
 @param textFont                 字体
 @param textBackgroundColor      背景颜色
 @param cornerRadius             圆角
 @param contentInsets            内边距
 @return 标签
 */
+ (instancetype)labelWithText:(NSString *)text
                                textFont:(UIFont *)textFont
                     textBackgroundColor:(UIColor *)textBackgroundColor
                 cornerRadius:(CGFloat)cornerRadius
                contentInsets:(UIEdgeInsets)contentInsets;

@end

NS_ASSUME_NONNULL_END
