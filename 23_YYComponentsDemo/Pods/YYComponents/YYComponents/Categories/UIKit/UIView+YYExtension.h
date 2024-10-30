//
//  UIView+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YYLayoutSubviewsDirection) {
    YYLayoutSubviewsHorizontal = 0,
    YYLayoutSubviewsVertical,
};

NS_ASSUME_NONNULL_BEGIN

@interface YYViewConfig : NSObject

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, assign) CGFloat cornerRaduis;

@property(nonatomic, assign) CGFloat borderWidth;

@property(nonatomic, strong) UIColor *borderColor;

@property(nonatomic, assign) BOOL hidden;

@end

@interface UIView (YYExtension)
/**
 移除所有子视图
 */
- (void)yy_removeAllSubviews;
/**
 快速创建view
 @param configBlock          配置描述
 @return                     view
 */
+ (instancetype)yy_viewWithConfig:(void(^)(YYViewConfig *config))configBlock;
/**
 添加点击事件
 @param tapBlock     点击动作
 */
- (void)yy_addTapAction:(void(^)(void))tapBlock;
/**
 布局子视图
 @param direction      布局方向
 @param itemNumber     数量
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_addSubviewsWithDirection:(YYLayoutSubviewsDirection)direction
                         itemNumber:(NSInteger)itemNumber
                     itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                        itemSpacing:(CGFloat)itemSpacing
                          itemBuild:(nonnull UIView* (^)(NSInteger index))itemBuild;

/**
 类名标识符
 */
@property(nonatomic, strong, class, readonly) NSString *yy_classIdentifier;

/**
 设置指定方向圆角
 @param size         尺寸
 @param corners      方向
 @param cornerRadii  圆角
 */
- (void)yy_setCornerWithSize:(CGSize)size
            byRoundingCorners:(UIRectCorner)corners
                  cornerRadii:(CGSize)cornerRadii;
/**
 生成一个和该对象特征一样的对象，仅限YYViewConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy;
/**
 生成一个和该对象特征一样的对象，仅限YYViewConfig中的属性
 @param configBlock      配置block
 @return                 新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYViewConfig *config))configBlock;
/**
 添加网格视图
 @param itemNumber       格子数量
 @param numberOfColumns  每行显示个数
 @param contentInsets    内边距
 @param itemSpacingH     格子水平方向间距
 @param itemSpacingV     格子垂直方向间距
 @param itemBuild        格子内容
 */
- (void)yy_addGridSubviewsWithItemNumber:(NSUInteger)itemNumber
                         numberOfColumns:(NSUInteger)numberOfColumns
                          contentInsets:(UIEdgeInsets)contentInsets
                            itemSpacingH:(CGFloat)itemSpacingH
                            itemSpacingV:(CGFloat)itemSpacingV
                               itemBuild:(nonnull UIView* (^)(NSInteger index))itemBuild;
/**
 平分布局[保证视图的宽高已知]
 @param direction      布局方向
 @param itemNumber     数量
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_distributeSubViewsWithDirection:(YYLayoutSubviewsDirection)direction
                                itemNumber:(NSInteger)itemNumber
                            itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                               itemSpacing:(CGFloat)itemSpacing
                                 itemBuild:(nonnull UIView * (^)(NSInteger index))itemBuild;
/**
 平分布局[保证视图的宽高已知]，支持设置item权重
 @param direction      布局方向
 @param itemWeights    子视图所占的权重
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_distributeSubViewsWithDirection:(YYLayoutSubviewsDirection)direction
                               itemWeights:(NSArray <NSNumber*> *)itemWeights
                            itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                               itemSpacing:(CGFloat)itemSpacing
                                 itemBuild:(nonnull UIView * (^)(NSInteger index))itemBuild;

@end

NS_ASSUME_NONNULL_END
