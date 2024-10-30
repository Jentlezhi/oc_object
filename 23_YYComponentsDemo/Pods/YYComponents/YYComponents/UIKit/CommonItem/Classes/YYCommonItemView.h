//
//  YYCommonItemView.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCommonItemViewConfig : NSObject
/// 自动布局默认YES
@property(nonatomic, assign) BOOL autoLayout;
/// 内容高度[autoLayout为NO的时候有效]
@property(nonatomic, assign) CGFloat contentHeight;
/// 颜色
@property(nonatomic, strong) UIColor *backgroundColor;
/// 卡片间距
@property(nonatomic, assign) UIEdgeInsets cardEdgeInsets;
/// 卡片颜色
@property(nonatomic, strong) UIColor *cardBackgroundColor;
/// 卡片圆角
@property(nonatomic, assign) CGFloat cardCornerRadius;
/// 内容间距
@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/// 标题宽度【默认0，根据内容自动布局】
@property(nonatomic, assign) CGFloat titleWidth;
/// 标题字体
@property(nonatomic, strong) UIFont *titleFont;
/// 标题颜色
@property(nonatomic, strong) UIColor *titleColor;
/// 标题内容
@property(nonatomic, copy) NSString *title;
/// 内容字体
@property(nonatomic, strong) UIFont *contentFont;
/// 内容左间距
@property(nonatomic, assign) CGFloat contentLeftMargin;
/// 内容右间距
@property(nonatomic, assign) CGFloat contentRightMargin;
/// 内容颜色
@property(nonatomic, strong) UIColor *contentColor;
/// 内容
@property(nonatomic, copy) NSString *content;
/// 内容显示行数
@property(nonatomic, assign) NSInteger contentNumberOfLines;
/// 内容距title偏移量[仅在contentNumberOfLines!=1的有效]
@property(nonatomic, assign) CGFloat contentOffsetTop;
/// 内容对齐方式
@property(nonatomic, assign) NSTextAlignment contentTextAlignment;
/// 占位字体
@property(nonatomic, strong) UIFont *placeHolderFont;
/// 占位颜色
@property(nonatomic, strong) UIColor *placeHolderColor;
/// 占位
@property(nonatomic, copy) NSString *placeHolder;
/// 显示右icon
@property(nonatomic, assign) BOOL showRightIcon;
/// 右icon
@property(nonatomic, strong) UIImage *rightIcon;
/// 右iconSize
@property(nonatomic, assign) CGSize rightIconSize;

@end

@interface YYCommonItemView : UIView
/**
 创建item
 @param configBlock     配置参数
 @param clickBlock      点击回调
 @return                item实例
 */
+ (instancetype)itemWithConfig:(nullable void(^)(YYCommonItemViewConfig *config))configBlock
                         click:(nullable void(^)(void))clickBlock;

/**
 内容
 */
@property(nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
