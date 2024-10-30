//
//  YYTagView.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTagViewConfig : NSObject
/// 内间距
@property(nonatomic, assign) UIEdgeInsets padding;
/// item水平间隔
@property(nonatomic, assign) CGFloat itemSpacingH;
/// item垂直间隔
@property(nonatomic, assign) CGFloat itemSpacingV;
/// 默认屏幕宽度
@property(nonatomic, assign) CGFloat preferredMaxLayoutWidth;

@end

@interface YYTagView : UIView

@property(nonatomic, strong, readonly) YYTagViewConfig *config;

/**
 创建标签视图
 @param configBlock         配置
 @param itemCountBlock      标签个数
 @param itemBuildBlock      标签内容
 @param didClickItemBlock   标签点击
 @return                    标签视图
 */
+ (instancetype)viewWithConfig:(void(^)(YYTagViewConfig *config))configBlock
                     itemCount:(NSInteger(^)(YYTagViewConfig *config))itemCountBlock
                     itemBuild:(UIView *(^)(NSInteger index))itemBuildBlock
                  didClickItem:(void(^)(YYTagViewConfig *config, NSInteger index))didClickItemBlock;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
