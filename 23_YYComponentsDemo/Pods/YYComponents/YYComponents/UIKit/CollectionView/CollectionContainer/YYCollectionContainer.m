//
//  YYCollectionContainer.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/8.
//

#import "YYCollectionContainer.h"
#import "Masonry.h"
#import "YYCollectionViewLeftAlignedLayout.h"
#import "YYWaterFallFlowLayout.h"

@implementation YYCollectionViewReusedModel

+ (instancetype)modelWithElementKind:(YYCollectionElementKind)elementKind
                       registerClass:(Class)registerClass
                     reuseIdentifier:(NSString *)reuseIdentifier {
    YYCollectionViewReusedModel *model = [self new];
    model.elementKind = elementKind;
    model.registerClass = registerClass;
    model.reuseIdentifier = reuseIdentifier;
    return model;
}

+ (instancetype)modelWithElementKind:(YYCollectionElementKind)elementKind
                       registerClass:(Class)registerClass {
    NSString *reuseIdentifier = NSStringFromClass(registerClass);
    return [self modelWithElementKind:elementKind registerClass:registerClass reuseIdentifier:reuseIdentifier];
}

@end

@implementation YYCollectionContainerConfig
- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = YES;
        self.pagingEnabled = NO;
        self.minimumLineSpacing = 0.f;
        self.estimatedItemSize = CGSizeMake(50.f, 50.f);
        self.itemSize = CGSizeMake(0.1f, 0.1f);
    }
    return self;
}
@end

@interface YYCollectionContainer()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) YYCollectionContainerConfig *config;

@property(nonatomic, strong) UICollectionViewLayout *layout;

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@interface YYCollectionContainerCell : UICollectionViewCell

@end

@implementation YYCollectionContainerCell

@end


@implementation YYCollectionContainer
#pragma mark - Lifecycle
/**
 创建格子
 @param configBlock     配置文件
 @return                格子
 */
+ (instancetype)containerWithConfig:(void(^)(YYCollectionContainerConfig *config))configBlock {
    YYCollectionContainer *container = [self new];
    if (configBlock) {
        configBlock(container.config);
    }
    [container configs];
    [container setupTableView];
    return container;
}
- (void)configs {
    self.backgroundColor = self.config.backgroundColor;
}
- (void)setupTableView {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark - Methods
/**
 获取内容尺寸
 */
- (CGSize)contentSize {
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    return self.collectionView.contentSize;
}
/**
 刷新表格
 */
- (void)reloadData {
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.config.numberOfSectionsInCollectionView) {
        return self.config.numberOfSectionsInCollectionView(collectionView);
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.config.numberOfItemsInSection) {
        return self.config.numberOfItemsInSection(collectionView, section);
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.cellForItemAtIndexPath) {
        UICollectionViewCell *cell = self.config.cellForItemAtIndexPath(collectionView, indexPath);
        if (cell) {
            return cell;
        }
        return [self defaultCellWithCollectionView:collectionView indexPath:indexPath];
    }
    return [self defaultCellWithCollectionView:collectionView indexPath:indexPath];
}
- (UICollectionViewCell *)defaultCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYCOMPONENTS_COLLECTION_VIEW_CELL_DEFAULT_IDENTIFIER" forIndexPath:indexPath];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.sizeForItemAtIndexPath) {
        return self.config.sizeForItemAtIndexPath(collectionView, collectionViewLayout, indexPath);
    }
    return self.config.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.config.insetForSectionAtIndex) {
        return self.config.insetForSectionAtIndex(collectionView, collectionViewLayout, section);
    }
    return self.config.sectionInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.config.minimumLineSpacingForSectionAtIndex) {
        return self.config.minimumLineSpacingForSectionAtIndex(collectionView, collectionViewLayout, section);
    }
    return self.config.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.config.minimumInteritemSpacingForSectionAtIndex) {
        return self.config.minimumInteritemSpacingForSectionAtIndex(collectionView, collectionViewLayout, section);
    }
    return self.config.minimumItemSpacing;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.config.viewForSupplementaryElementOfKind) {
        UICollectionReusableView *reusableView = self.config.viewForSupplementaryElementOfKind(collectionView, kind, indexPath);
        if (reusableView) {
            return reusableView;
        }
        return [UICollectionReusableView new];
    }
    return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.config.referenceSizeForHeaderInSection) {
        return self.config.referenceSizeForHeaderInSection(collectionView, collectionViewLayout, section);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.config.referenceSizeForFooterInSection) {
        return self.config.referenceSizeForFooterInSection(collectionView, collectionViewLayout, section);
    }
    return CGSizeZero;
}

#pragma mark - Lazyload
- (YYCollectionContainerConfig *)config {
    if (!_config) {
        _config = [YYCollectionContainerConfig new];
    }
    return _config;
}
- (UICollectionViewLayout *)layout {
    if (!_layout) {
        if (self.config.layout) {
            _layout = self.config.layout;
        } else {///如果未提供layout，就使用默认的layout
            _layout = [self defaultLayout];
        }
    }
    return _layout;
}
/**
 默认的layout
 */
- (UICollectionViewLayout *)defaultLayout {
    UICollectionViewFlowLayout *layout;
    if (self.config.layoutType == YYCollectionViewAlignedLayoutLeft) {
        layout = [YYCollectionViewLeftAlignedLayout new];
        [(YYCollectionViewLeftAlignedLayout *)layout setItemMargin:self.config.minimumItemSpacing];
        layout.minimumLineSpacing = self.config.minimumLineSpacing;
        layout.estimatedItemSize = self.config.estimatedItemSize;
    }else if (self.config.layoutType == YYCollectionViewAlignedLayoutWaterFallLayout) {
        __weak typeof(self) weakSelf = self;
        layout = [YYWaterFallFlowLayout layoutWithConfig:^(YYWaterFallFlowLayoutConfig * _Nonnull config) {
            config.collectionViewContentEdgeInsets = weakSelf.config.contentEdgeInsets;
            config.numberOfColumn = MAX(weakSelf.config.waterFallFlowNumberOfColumn, 2);
            config.columnMargin = weakSelf.config.minimumLineSpacing;
            config.rowMargin = weakSelf.config.minimumItemSpacing;
            config.itemEdgeInsets = weakSelf.config.waterFallFlowItemEdgeInsets;
            config.heightForItemAtIndexPath = ^CGFloat(YYWaterFallFlowLayout * _Nonnull flowLayout, NSInteger indexPath, CGFloat itemWidth) {
                if (weakSelf.config.waterFallFlowHeightForItemAtIndexPath) {
                    return weakSelf.config.waterFallFlowHeightForItemAtIndexPath(indexPath, itemWidth);
                }
                return CGFLOAT_MIN;
            };
        }];
        ///流水布局，estimatedItemSize设置成CGSizeZero
        layout.estimatedItemSize = CGSizeZero;
    }
    else {
        layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = self.config.minimumLineSpacing;
        layout.minimumInteritemSpacing = self.config.minimumItemSpacing;
        layout.estimatedItemSize = self.config.estimatedItemSize;
    }
    layout.scrollDirection = self.config.scrollDirection;
    layout.sectionInset = UIEdgeInsetsZero;
    return layout;
}
#pragma mark - Lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        if (self.config.scrollDirection == UICollectionViewScrollDirectionVertical) {
            _collectionView.alwaysBounceVertical = self.config.alwaysBounceVertical;
        } else {
            _collectionView.alwaysBounceHorizontal = self.config.alwaysBounceHorizontal;
        }
        _collectionView.showsVerticalScrollIndicator = self.config.showsVerticalScrollIndicator;
        _collectionView.showsHorizontalScrollIndicator = self.config.showsHorizontalScrollIndicator;
        _collectionView.contentInset = self.config.contentEdgeInsets;
        _collectionView.pagingEnabled = self.config.pagingEnabled;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        NSArray <YYCollectionViewReusedModel*> *reusedInfos = self.config.reusedInfos;
        for (YYCollectionViewReusedModel *reuseInfo in reusedInfos) {
            if (reuseInfo.elementKind == YYCollectionElementKindCell) {
                [_collectionView registerClass:reuseInfo.registerClass forCellWithReuseIdentifier:reuseInfo.reuseIdentifier];
            }else if (reuseInfo.elementKind == YYCollectionElementKindSectionHeader) {
                [_collectionView registerClass:reuseInfo.registerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseInfo.reuseIdentifier];
            }else if (reuseInfo.elementKind == YYCollectionElementKindSectionFooter) {
                [_collectionView registerClass:reuseInfo.registerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseInfo.reuseIdentifier];
            }
        }
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end
