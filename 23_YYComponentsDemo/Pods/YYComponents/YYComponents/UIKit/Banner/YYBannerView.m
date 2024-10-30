//
//  YYBannerView.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2020/10/21.
//  底层逻辑：CollectionView，0和最大值修改偏移量

#import "YYBannerView.h"
#import <Masonry/Masonry.h>

///=============================================================================
/// YYBannerConfig
///=============================================================================
#pragma mark - 类YYBannerConfig
@implementation YYBannerConfig
- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = YYBannerScrollDirectionHorizontal;
        self.defaultIndex = 0;
        self.autoScroll = YES;
        self.autoScrollTimeInterval = 3.f;
        self.scrollGestureEnable = YES;
        self.inFiniteLoop = YES;
    }
    return self;
}

@end
///=============================================================================
/// YYBannerItemCollectionViewCell
///=============================================================================
#pragma mark - 类YYBannerItemCollectionViewCell
@interface YYBannerItemCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) UIView *(^contentForItemAtIndex)(NSInteger index, UIView *superView);
@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property(nonatomic, strong) UIColor *backgroundColor;
@end

@implementation YYBannerItemCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupviews];
    }
    return self;
}

- (void)setupviews{
    
}
#pragma mark - Setter && Getter
- (void)setContentForItemAtIndex:(UIView *(^)(NSInteger, UIView *))contentForItemAtIndex {
    _contentForItemAtIndex = contentForItemAtIndex;
    if (!contentForItemAtIndex){ return; }
    UIView *contentView = contentForItemAtIndex(self.index, self.contentView);
    if (contentView == nil) { return; }
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(self.contentEdgeInsets);
    }];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.contentView.backgroundColor = backgroundColor;
}
@end
///=============================================================================
/// YYBannerItemCollectionViewCell
///=============================================================================
#pragma mark - 类YYBannerItemCollectionViewCell
@interface YYBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) YYBannerConfig *config;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, assign) NSInteger currentPage;
@end

@implementation YYBannerView

/**
 初始化
 @param config      配置文件
 */
+ (instancetype)bannerWithConfig:(void(^)(YYBannerConfig *config))config {
    YYBannerView *banner = [YYBannerView new];
    if (config) {
        config(banner.config);
    }
    [banner baseConfig];
    [banner setupviews];
    return banner;
}
#pragma mark - Methods
- (void)baseConfig {
    if (self.config.scrollDirection == YYBannerScrollDirectionVertical) {
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    [self cancelCollectionViewGestureEnableIfNeed];
}
- (void)startTimerIfNeed {
    ///如果设置为自动滚动，则开启定时器
    if (self.config.autoScroll && self.config.inFiniteLoop && self.dataSource.count > 1) {
        [self startTimer];
    }
}
- (void)setupviews {
    [self addSubview:self.collectionView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.flowLayout.itemSize = self.bounds.size;
    self.collectionView.frame = self.bounds;
}
#pragma mark - Init Menthod
- (void)startTimer {
    [self stopTimer];
    NSTimeInterval timeInterval = self.config.autoScrollTimeInterval + 0.25f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc{
    _collectionView.delegate = nil;
    _collectionView = nil;
}

#pragma mark - Setter Menthod
- (void)setDataSource:(NSArray *)dataSource {
    if (!dataSource || dataSource.count == 0) {
        return;
    }
    _dataSource = dataSource;
    [self startTimerIfNeed];
    self.collectionView.scrollEnabled = dataSource.count > 1;
    [self initCollectionViewDefaultPosition];
}
/**
 初始化collectionView的初始位置
 */
- (void)initCollectionViewDefaultPosition {
    BOOL inFiniteLoop = self.config.inFiniteLoop;
    NSInteger dataSourceCount = self.dataSource.count;
    NSInteger defaultIndex = self.config.defaultIndex;
    if (inFiniteLoop && dataSourceCount > 1 && defaultIndex <= dataSourceCount - 1) {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView reloadData];
        } completion:^(BOOL finished) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:defaultIndex + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }];
    } else {
        if (inFiniteLoop) {
            [self.collectionView performBatchUpdates:^{
                [self.collectionView reloadData];
            } completion:^(BOOL finished) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            }];
        }else if (defaultIndex > 0 && defaultIndex < dataSourceCount) {
            [self.collectionView performBatchUpdates:^{
                [self.collectionView reloadData];
            } completion:^(BOOL finished) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:defaultIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            }];
        } else {
            [self.collectionView reloadData];
        }
    }
}
/**
 移除collectionView的手势
 */
- (void)cancelCollectionViewGestureEnableIfNeed {
    if (self.config.scrollGestureEnable){ return; }
    self.collectionView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.collectionView removeGestureRecognizer:gesture];
        }
    }
}
#pragma mark - Private Menthod
- (void)autoNextPage {
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex = currentIndex + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}
- (NSInteger)currentIndex {
    if (self.collectionView.bounds.size.width == 0 || self.collectionView.bounds.size.height == 0) {
        return 0;
    }
    NSInteger index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    } else {
        index = (self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5) / self.flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

- (NSInteger)dataSourceIndexForCurrentIndex:(NSInteger)index{
    NSInteger dataIndex = 0;
    if (self.config.inFiniteLoop && self.dataSource.count > 1) {
        if (index == 0) {
            dataIndex = self.dataSource.count - 1;
        }else if (index == self.dataSource.count + 1){
            dataIndex = 0;
        }else{
            dataIndex = index - 1;
        }
    }else{
        dataIndex = index;
    }
    return dataIndex;
}
#pragma mark - Public Methods
- (void)setContentForItemAtIndex:(UIView * _Nonnull (^)(NSInteger, UIView * _Nonnull))contentForItemAtIndex {
    _contentForItemAtIndex = contentForItemAtIndex;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.config.inFiniteLoop && self.dataSource.count > 1) {
        return self.dataSource.count + 2;
    }else{
        return self.dataSource.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYBannerItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYBannerItemCollectionViewCell" forIndexPath:indexPath];
    cell.contentEdgeInsets = self.config.contentEdgeInsets;
    cell.backgroundColor = self.config.backgroundColor;
    NSInteger currentIndex = [self dataSourceIndexForCurrentIndex:indexPath.item];
    cell.index = currentIndex;
    cell.contentForItemAtIndex = self.contentForItemAtIndex;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentIndex = [self dataSourceIndexForCurrentIndex:indexPath.item];
    !self.didClickItemAtIndex?:self.didClickItemAtIndex(currentIndex);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = MAX([self currentIndex] - 1, 0);
    if (index > self.dataSource.count - 1) {
        index = self.dataSource.count - 1;
    }
    if (self.currentPage != index) {
        self.currentPage = index;
        !self.currentPageCallback?:self.currentPageCallback(self.currentPage);
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimerIfNeed];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger currentIndex = [self currentIndex];
    if (self.config.inFiniteLoop && self.dataSource.count > 1) {
        if (currentIndex == 0) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else if (currentIndex == self.dataSource.count + 1){
           [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}
#pragma mark - Lazy load
- (YYBannerConfig *)config {
    if (!_config){
        _config = [YYBannerConfig new];
    }
    return _config;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[YYBannerItemCollectionViewCell class] forCellWithReuseIdentifier:@"YYBannerItemCollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end

