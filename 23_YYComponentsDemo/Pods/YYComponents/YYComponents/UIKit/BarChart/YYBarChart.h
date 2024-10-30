//
//  YYBarChart.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/12/19.
//

#import <UIKit/UIKit.h>

@class YYBarChartNode,YYBarChartConfig;

NS_ASSUME_NONNULL_BEGIN
//------------------------------YYBarChart-----------
@interface YYBarChart : UIView
/**
 初始化：默认设置
 @return            柱壮图对象
 */
+ (instancetype)defaultBarChart;

/**
 初始化
 @param configBlock           配置
 @return                      柱壮图对象
 */
+ (instancetype)barChartWithConfig:(nullable void(^)(YYBarChartConfig *config))configBlock;
/// 配置文件
@property(nonatomic, strong, readonly) YYBarChartConfig *config;
/// 点击回调
@property(nonatomic, copy) void(^barClickCallback)(YYBarChartNode *node, NSInteger index);
/**
 配置x y轴数据
 @param dataX      X轴数据源
 @param dataY      X轴数据源
 */
- (void)configDataX:(NSArray<YYBarChartNode *> *)dataX
              dataY:(NSArray<YYBarChartNode *> *)dataY;
/**
 自定义bar顶部内容
 @param configBlock      配置block，resuseviews是避免每次大量创建视图，节省一点点性能
 @discussion 用法：
 BOOL reuse = YES;
 [_barChart addBarTopViewWithConfig:^UIView * _Nonnull(YYBarChartNode * _Nonnull node, NSInteger index, NSInteger barCount, NSArray *resuseviews) {
     UILabel *label;
     if (reuse) {
         label = [resuseviews objectOrNilAtIndex:index];
     }
     if (label == nil) {
         label = [UILabel new];
         NSLog(@"创建第%ld个topview",index);
         label.font = [UIFont systemFontOfSize:10.f];
         label.textAlignment = NSTextAlignmentCenter;
         label.numberOfLines = 0;
     }
     label.text = @(node.value).yy_toString;
     return label;
 }];
 */
- (void)addBarTopViewWithConfig:(UIView *(^)(YYBarChartNode *node, NSInteger index, NSInteger barCount, NSArray *resuseviews))configBlock;
/**
 自定义bar底部内容
 @param configBlock      配置block，resuseviews是避免每次大量创建视图，节省一点点性能
 @discussion 用法：
 BOOL reuse = YES;
 [_barChart addBarBottomViewWithConfig:^UIView * _Nonnull(YYBarChartNode * _Nonnull node,NSInteger index, NSInteger barCount, NSArray *resuseviews) {
     UILabel *label;
     if (reuse) {
         label = [resuseviews objectOrNilAtIndex:index];
     }
     if (label == nil) {
         label = [UILabel new];
         NSLog(@"创建第%ld个bottomview",index);
         label.font = [UIFont systemFontOfSize:10.f];
         label.textAlignment = NSTextAlignmentCenter;
         label.numberOfLines = 0;
     }
     label.text = node.title;
     return label;
 }];
 */
- (void)addBarBottomViewWithConfig:(UIView *(^)(YYBarChartNode *node, NSInteger index, NSInteger barCount, NSArray *resuseviews))configBlock;
/**
 刷新数据
 */
- (void)reload;

@end

//------------------------------YYBarChartConfig-----------
@interface YYBarChartConfig : NSObject

/// 内边距
@property(nonatomic, assign) UIEdgeInsets padding;
/// x轴item宽度
@property(nonatomic, assign) CGFloat itemWidthX;
/// item间距
@property(nonatomic, assign) CGFloat itemSpacingX;
/// y轴item高度
@property(nonatomic, assign) CGFloat itemHeightY;
/// y轴分割线高度
@property(nonatomic, assign) CGFloat lineHeightY;
/// y轴分割线和标题的间距
@property(nonatomic, assign) CGFloat lineTitleSpacingY;
/// y轴分割线颜色
@property(nonatomic, strong) UIColor *lineColorY;
/// 是否支持回弹 默认：YES
@property(nonatomic, assign) BOOL bounces;
/// bar底部高度：外界根据实际高度设置
@property(nonatomic, assign) CGFloat barBottomHeight;

@end
//------------------------------YYBarChartNode-----------
@interface YYBarChartNode : NSObject

/// 标题
@property(nonatomic, copy) NSString *title;
/// 标题颜色
@property(nonatomic, strong) UIColor *titleColor;
/// 标题字体
@property(nonatomic, strong) UIFont *titleFont;
/// 值
@property(nonatomic, assign) CGFloat value;
/// 值颜色
@property(nonatomic, strong) UIColor *valueColor;
/// 条形柱颜色
@property(nonatomic, strong) UIColor *barColor;
/// 柱子高度
@property(nonatomic, assign, readonly) CGFloat barHeight;

@end

NS_ASSUME_NONNULL_END
