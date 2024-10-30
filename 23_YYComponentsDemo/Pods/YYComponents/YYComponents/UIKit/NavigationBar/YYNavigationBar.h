//
//  YYNavigationView.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/9/2.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YYNavigationBarLeftBtnType) {
    YYNavigationBarLeftBtnTypeBack,
    YYNavigationBarLeftBtnTypeClose,
};

NS_ASSUME_NONNULL_BEGIN

@interface YYNavigationBarConfig : NSObject

@property(nonatomic, assign) YYNavigationBarLeftBtnType leftBtnType;

@property(nonatomic, assign) BOOL showNavigation;

@property(nonatomic, assign) BOOL showLeftBtn;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIColor *leftBtnColor;

@property(nonatomic, assign) CGFloat leftBtnLeftMargin;

@property(nonatomic, assign) CGFloat leftBtnWidth;

@property(nonatomic, assign) BOOL showBottomLine;

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, strong) UIColor *bottomLineColor;

@end

@interface YYNavigationBar : UIView

@property(nonatomic, strong, readonly) YYNavigationBarConfig *config;

/**
 构造方法
 @param title     标题
 */
+ (instancetype)mainviewNavigationBarWithTitle:(nullable NSString *)title;
/**
 构造方法
 @param title     标题
 */
+ (instancetype)subpageNavigationBarWithTitle:(nullable NSString *)title;
/**
 构造方法
 @param configBlock     配置
 */
+ (instancetype)navigationBarWithConfig:(nullable void(^)(YYNavigationBarConfig *config))configBlock;

// 左区域的点击
@property(nonatomic, copy) void(^leftViewClickCallback)(void);
// 中间区域的点击
@property(nonatomic, copy) void(^centerViewClickCallback)(void);
// 右区域的点击
@property(nonatomic, copy) void(^rightViewClickCallback)(void);
// 隐藏的布局回调
@property(nonatomic, copy) void(^needRelayoutCallback)(BOOL showNavigation);

/**
 添加中间区域的内容[标题区域]
 @param titleView   中间视图
 @param layout      中间视图的布局
 */
- (void)addCustomTitleView:(UIView *)titleView
                    layout:(nullable void(^)(UIView *titleView, UIView *superView))layout;
/**
 添加右边区域的内容[标题区域]
 @param rightView   右边视图
 @param layout      右边视图的布局
 */
- (void)addRightItemView:(UIView*)rightView
              layout:(nullable void(^)(UIView *titleView, UIView *superView))layout;

@end

NS_ASSUME_NONNULL_END
