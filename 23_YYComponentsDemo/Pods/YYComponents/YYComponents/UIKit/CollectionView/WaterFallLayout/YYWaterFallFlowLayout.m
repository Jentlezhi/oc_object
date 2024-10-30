//
//  YYWaterFallFlowLayout.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/18.
//

#import "YYWaterFallFlowLayout.h"

@implementation YYWaterFallFlowLayoutConfig
- (instancetype)init {
    if (self = [super init]) {
        self.numberOfColumn = 2;
        self.columnMargin = 0.f;
        self.rowMargin = 0.f;
        self.itemEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}
@end

@interface YYWaterFallFlowLayout()

@property(nonatomic, strong) YYWaterFallFlowLayoutConfig *config;

@property(nonatomic, strong) NSMutableArray *attrsArr;

@property(nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation YYWaterFallFlowLayout

/**
 创建瀑布流
 @param configBlock     配置文件
 @return                layout
 */
+ (instancetype)layoutWithConfig:(void(^)(YYWaterFallFlowLayoutConfig *config))configBlock {
    YYWaterFallFlowLayout *layout = [self new];
    if (configBlock) {
        configBlock(layout.config);
    }
    return layout;
}

#pragma mark - LifeCycle
- (void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0.f;
    [self.attrsArr removeAllObjects];
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.config.numberOfColumn ; i ++) {
        [self.columnHeights addObject:@(self.config.itemEdgeInsets.top)];
    }
    if (self.collectionView.numberOfSections == 0) {
        return;
    }
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    // 设置布局属性的frame
    CGFloat cellW = (collectionViewW - self.config.itemEdgeInsets.left - self.config.itemEdgeInsets.right - self.config.collectionViewContentEdgeInsets.left - self.config.collectionViewContentEdgeInsets.right - (self.config.numberOfColumn - 1) * self.config.columnMargin) / MAX(self.config.numberOfColumn, 1);
    if (!self.config.heightForItemAtIndexPath) {return attrs;}
    CGFloat cellH = self.config.heightForItemAtIndexPath(self, indexPath.item, cellW);
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 1; i < self.config.numberOfColumn; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat cellX = self.config.itemEdgeInsets.left + destColumn * (cellW + self.config.columnMargin);
    CGFloat cellY = minColumnHeight;
    if (cellY != self.config.itemEdgeInsets.top) {
        cellY += self.config.rowMargin;
    }
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    // 更新最短那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    // 记录内容的高度 - 即最长那一列的高度
    CGFloat maxColumnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxColumnHeight) {
        self.contentHeight = maxColumnHeight;
    }
    return attrs;
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}
- (CGSize)collectionViewContentSize {
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 0; i < self.config.numberOfColumn; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, self.contentHeight + self.config.itemEdgeInsets.bottom);
}
#pragma mark -  Lazyload
- (YYWaterFallFlowLayoutConfig *)config {
    if (!_config) {
        _config = [YYWaterFallFlowLayoutConfig new];
    }
    return _config;
}
- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = @[].mutableCopy;
    }
    return _attrsArr;
}
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = @[].mutableCopy;
    }
    return _columnHeights;
}

@end
