//
//  YYLayout.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/09/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///=============================================================================
/// YYLayout: 设置屏幕radio，通常不用设置，默认为1.f。
/// 举例子：
/// [view1 yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
///     make.width.height.yy_equalTo(80.f);
/// }];
/// width、height宽高=80.f*radio
///=============================================================================
@interface YYLayout : NSObject

/// 布局比例[默认：1.f]
@property(nonatomic, assign, class) CGFloat radio;

@end

///=============================================================================
/// YYLayoutToItem: NSLayoutConstraint, To item
///=============================================================================

@class YYLayoutConstraint;

@interface YYLayoutToItem : NSObject

@property(nonatomic, strong) UIView *toItem;

@property(nonatomic, assign) NSLayoutAttribute toItemAttribute;

@property(nonatomic, copy) NSString *otherLayoutConstraint;

+ (instancetype)itemWithItem:(UIView *)item
                   attribute:(NSLayoutAttribute)attribute;

@end

///=============================================================================
/// YYLayoutMaker: 约束对象，处理布局约束，内部调用iOS自动布局NSLayoutConstraint。
///=============================================================================

@interface YYLayoutMaker : NSObject

///=============================================================================
/// 约束属性
///=============================================================================

@property(nonatomic, strong, readonly) YYLayoutMaker *top;
@property(nonatomic, strong, readonly) YYLayoutMaker *bottom;
@property(nonatomic, strong, readonly) YYLayoutMaker *left;
@property(nonatomic, strong, readonly) YYLayoutMaker *right;
@property(nonatomic, strong, readonly) YYLayoutMaker *width;
@property(nonatomic, strong, readonly) YYLayoutMaker *height;
@property(nonatomic, strong, readonly) YYLayoutMaker *centerX;
@property(nonatomic, strong, readonly) YYLayoutMaker *centerY;
@property(nonatomic, strong, readonly) YYLayoutMaker *center;
@property(nonatomic, strong, readonly) YYLayoutMaker *widthAndHeight;
@property(nonatomic, strong, readonly) YYLayoutMaker *size;

///=============================================================================
/// 参考对象
///=============================================================================
@property(nonatomic, copy, readonly) YYLayoutMaker *(^equalTo)(id attr);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^equalToSuperview)(void);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^lessThenOrEqualTo)(id attr);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^lessThenOrEqualToSuperview)(void);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^greaterThenOrEqualTo)(id attr);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^greaterThenOrEqualToSuperview)(void);
@property(nonatomic, copy, readonly) void (^yy_equalTo)(CGFloat offset);
@property(nonatomic, copy, readonly) void (^yy_lessThenOrEqualTo)(CGFloat offset);
@property(nonatomic, copy, readonly) void (^yy_greaterThenOrEqualTo)(CGFloat offset);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^offset)(CGFloat offset);
@property(nonatomic, copy, readonly) YYLayoutMaker *(^multipliedBy)(CGFloat multiplier);

/**
 对所有保存的布局对象布局
 */
- (void)makeLayout;
/**
 更新约束
 */
- (void)updateLayoutWithOldLayoutConstraints:(NSArray <YYLayoutConstraint*> *)oldLayoutConstraints
                  oldOriginLayoutConstraints:(NSArray <NSLayoutConstraint*> *)oldOriginLayoutConstraints
                               oldAttributes:(NSArray <NSNumber*>*)oldAttributes;

@end

///=============================================================================
/// UIView (YYLayout): 给view拓展属性，提高了使用容易度和代码的可阅读程度。
///=============================================================================

@interface UIView (YYLayout)

@property(nonatomic, assign, readonly) YYLayoutToItem *yy_top;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_bottom;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_left;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_right;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_width;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_height;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_centerX;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_centerY;
@property(nonatomic, assign, readonly) YYLayoutToItem *yy_center;

///=============================================================================
/// [view yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
///    make.width.height.yy_equalTo(80.f);
///    make.top.equalTo(self.view.yy_top).offset(100.f);
///    make.left.equalTo(self.view.yy_left).offset(20.f);
/// }];
/// 布局view:宽高均为80.f，顶部距离父视图100.f，左边距离父视图20.f
///=============================================================================
/**
 封装NSLayoutConstraint
 @param layout      布局block
 */
- (void)yy_makeLayout:(void(^)(YYLayoutMaker * _Nonnull make))layout;


/**
 重新约束，如果之前设置过约束则会移除约束
 @param layout      布局block
 */
- (void)yy_remakeLayout:(void (^)(YYLayoutMaker * _Nonnull make))layout;
/**
 更新约束
 @param layout      布局block
 */
- (void)yy_updateLayout:(void (^)(YYLayoutMaker * _Nonnull make))layout;
/**
 移除某个属性的约束
 @param attribute      约束属性
 */
- (void)yy_removeConstraint:(NSLayoutAttribute)attribute;
/**
 移除某些属性的约束
 @param attributes      约束属性数组
 */
- (void)yy_removeConstraints:(NSArray *)attributes;

@end

NS_ASSUME_NONNULL_END

