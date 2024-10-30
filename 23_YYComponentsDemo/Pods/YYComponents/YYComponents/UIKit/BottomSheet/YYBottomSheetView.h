//
//  YYBottomSheetView.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2022/10/17.
//  Copyright © 2022 GitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBottomSheetConfig : NSObject

/// 最大高度[默认：屏幕的高度 * 0.8f，该值不得超过屏幕高度的80%，通常不用配置]
@property(nonatomic, assign) CGFloat maxHeight;
/// 背景颜色
@property(nonatomic, strong) UIColor *backgroundColor;
/// 是否显示默认关闭按钮
@property(nonatomic, assign) BOOL showCloseButton;
/// 标题间距
@property(nonatomic, assign) UIEdgeInsets titleViewInsets;
/// 关闭按钮上边间距
@property(nonatomic, assign) CGFloat closeBtnTopMargin;
/// 关闭按钮右边间距
@property(nonatomic, assign) CGFloat closeBtnRightMargin;
/// 关闭按钮宽度
@property(nonatomic, assign) CGFloat closeBtnWidth;
/// 内容间距
@property(nonatomic, assign) UIEdgeInsets contentInsets;
/// 当前视图是否展示
@property(nonatomic, assign, readonly) BOOL isShow;
/// 是否支持拖拽[默认：YES]
@property(nonatomic, assign) BOOL supportDrag;
/// 设置向下拖拽触发关闭的距离[默认：50.f]
@property(nonatomic, assign) CGFloat dragCloseOffset;

@end

@interface YYBottomSheetView : UIView
/**
 初始化方法
 @return                 对象
 */
+ (instancetype)bottomSheet;
/**
 初始化方法
 @param configBlock      配置
 @return                 对象
 */
+ (instancetype)bottomSheetWithConfig:(void(^__nullable)(YYBottomSheetConfig *config))configBlock;
/// 适配器
@property(nonatomic, strong, readonly) YYBottomSheetConfig *config;
/// 关闭按钮
@property(nonatomic, strong, readonly) UIButton *closeBtn;
/// 展示动画结束
@property(copy, nonatomic) void(^showAnimationFinish)(void);
/// 消失动画结束
@property(copy, nonatomic) void(^dismissAnimationFinish)(void);
/**
 弹出内容[加在Kwindow上]
 */
- (void)showAlertView;
/**
 弹出内容，指定父视图
 */
- (void)showAlertViewOnView:(UIView * _Nullable)superView;
/**
 添加标题视图
 @param titleView         标题视图
 @param titleViewLayoutBlock   标题视图布局
 */
- (void)addTitleView:(nonnull UIView *)titleView
     titleViewLayout:(void(^__nonnull)(UIView *superView, UIView *titleView))titleViewLayoutBlock;
/**
 添加顶部视图
 @param topView         顶部视图
 @param topViewLayoutBlock   顶部视图布局
 */
- (void)addTopView:(nonnull UIView *)topView
     topViewLayout:(void(^__nonnull)(UIView *superView, UIView *topView))topViewLayoutBlock;
/**
 添加内容视图[内容超过指定高度（maxHeight）可滚动]
 @param contentView               内容视图
 @param contentViewLayoutBlock    内容视图布局
 */
- (void)addContentView:(nonnull UIView *)contentView
     contentViewLayout:(void(^__nonnull)(UIView *superView, UIView *contentView))contentViewLayoutBlock;
/**
 添加底部视图
 @param bottomView       底部视图
 @param bottomViewLayout 底部视图布局
 */
- (void)addBottomView:(nonnull UIView *)bottomView
     bottomViewLayout:(void(^__nonnull)(UIView *superView, UIView *bottomView))bottomViewLayout;
/**
 关闭
 */
- (void)close;

@end

NS_ASSUME_NONNULL_END
