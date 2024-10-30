//
//  YYButton.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYButton : UIButton

/// 防抖动时间
@property(nonatomic, assign) NSTimeInterval eventInterval;
/// 扩大点击范围
@property(nonatomic, assign) UIEdgeInsets enlargedRect;
/// 是否显示正在加载动画
@property(nonatomic, assign) BOOL isLoading;
/// loading提示文字
@property(nonatomic, copy) NSString *loadingTip;
/// loading提示文字颜色[默认文字颜色]
@property(nonatomic, strong) UIColor *loadingTipColor;

@end

NS_ASSUME_NONNULL_END
