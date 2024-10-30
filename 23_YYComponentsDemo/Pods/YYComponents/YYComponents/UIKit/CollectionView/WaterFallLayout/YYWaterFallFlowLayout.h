//
//  YYWaterFallFlowLayout.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YYWaterFallFlowLayout;

@interface YYWaterFallFlowLayoutConfig : NSObject

/// 列数 默认：2
@property(nonatomic, assign) NSInteger numberOfColumn;
/// 列间距 默认0
@property(nonatomic, assign) CGFloat columnMargin;
/// 行间距 默认0
@property(nonatomic, assign) CGFloat rowMargin;
/// item内边距 默认
@property(nonatomic, assign) UIEdgeInsets itemEdgeInsets;
/// collectionView内间距
@property(nonatomic, assign) UIEdgeInsets collectionViewContentEdgeInsets;
/// heightForItemAtIndexPath
@property(nonatomic, copy) CGFloat (^heightForItemAtIndexPath)(YYWaterFallFlowLayout *flowLayout, NSInteger indexPath, CGFloat itemWidth);

@end

@interface YYWaterFallFlowLayout : UICollectionViewFlowLayout

/**
 创建瀑布流
 @param configBlock     配置文件
 @return                layout
 */
+ (instancetype)layoutWithConfig:(void(^)(YYWaterFallFlowLayoutConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
