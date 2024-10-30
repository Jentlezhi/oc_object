//
//  YYCollectionContainer.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YYCollectionViewAlignedLayout) {
    YYCollectionViewAlignedLayoutDefault,
    YYCollectionViewAlignedLayoutLeft,
    YYCollectionViewAlignedLayoutWaterFallLayout,
};

typedef NS_ENUM(NSUInteger, YYCollectionElementKind) {
    YYCollectionElementKindCell,
    YYCollectionElementKindSectionHeader,
    YYCollectionElementKindSectionFooter,
};

@interface YYCollectionViewReusedModel : NSObject

@property(nonatomic, assign) YYCollectionElementKind elementKind;

@property(nonatomic, strong) Class registerClass;

@property(nonatomic, copy) NSString *reuseIdentifier;

+ (instancetype)modelWithElementKind:(YYCollectionElementKind)elementKind
                       registerClass:(Class)registerClass
                     reuseIdentifier:(NSString *)reuseIdentifier;

+ (instancetype)modelWithElementKind:(YYCollectionElementKind)elementKind
                       registerClass:(Class)registerClass;

@end

@interface YYCollectionContainerConfig : NSObject

/// 默认UICollectionViewFlowLayout
@property(nonatomic, strong) UICollectionViewLayout *layout;
/// 如果自定义了layout，该属性失效
@property(nonatomic, assign) YYCollectionViewAlignedLayout layoutType;
/// 背景颜色
@property(nonatomic, strong) UIColor *backgroundColor;
/// 表格背景颜色
@property(nonatomic, strong) UIColor *collectionBackgroundColor;
/// 内间距
@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/// 不指定itemSize，内部会自动计算布局
@property(nonatomic, assign) CGSize itemSize;

@property(nonatomic, assign) CGSize estimatedItemSize;

@property(nonatomic, assign) BOOL alwaysBounceVertical;

@property(nonatomic, assign) BOOL alwaysBounceHorizontal;

@property(nonatomic, assign) BOOL showsVerticalScrollIndicator;

@property(nonatomic, assign) BOOL showsHorizontalScrollIndicator;

@property(nonatomic, assign) BOOL pagingEnabled;

@property(nonatomic, assign) CGFloat minimumLineSpacing;

@property(nonatomic, assign) CGFloat minimumItemSpacing;

@property(nonatomic, assign) UIEdgeInsets sectionInset;

@property(nonatomic, strong) NSArray <YYCollectionViewReusedModel*> *reusedInfos;

@property(nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property(nonatomic, copy) NSInteger (^numberOfSectionsInCollectionView)(UICollectionView *collectionView);

@property(nonatomic, copy) NSInteger (^numberOfItemsInSection)(UICollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) UICollectionViewCell *(^cellForItemAtIndexPath)(UICollectionView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) CGSize (^sizeForItemAtIndexPath)(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSIndexPath *indexPath);

@property(nonatomic, copy) CGFloat (^minimumLineSpacingForSectionAtIndex)(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSInteger section);

@property(nonatomic, copy) CGFloat (^minimumInteritemSpacingForSectionAtIndex)(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSInteger section);

@property(nonatomic, copy) UIEdgeInsets (^insetForSectionAtIndex)(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSInteger section);

@property(nonatomic, copy) UICollectionReusableView *(^viewForSupplementaryElementOfKind)(UICollectionView *collectionView, NSString *kind, NSIndexPath *indexPath);

@property(nonatomic, copy) CGSize (^referenceSizeForHeaderInSection)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);

@property(nonatomic, copy) CGSize (^referenceSizeForFooterInSection)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);


/// 瀑布流 列数>=2 默认：2
@property(nonatomic, assign) NSInteger waterFallFlowNumberOfColumn;
/// 瀑布流 item 内间距
@property(nonatomic, assign) UIEdgeInsets waterFallFlowItemEdgeInsets;
/// 瀑布流 heightForItemAtIndexPath
@property(nonatomic, copy) CGFloat (^waterFallFlowHeightForItemAtIndexPath)(NSInteger indexPath, CGFloat itemWidth);

@end

@interface YYCollectionContainer : UIView

@property(nonatomic, strong, readonly) UICollectionView *collectionView;

/**
 创建格子
 @param configBlock     配置文件
 @return                格子
 */
+ (instancetype)containerWithConfig:(void(^)(YYCollectionContainerConfig *config))configBlock;
/**
 获取内容尺寸
 */
- (CGSize)contentSize;
/**
 刷新表格
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
