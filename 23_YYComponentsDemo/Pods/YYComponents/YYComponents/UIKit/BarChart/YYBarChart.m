//
//  YYBarChart.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/12/19.
//

#import "YYBarChart.h"
#import <Masonry/Masonry.h>
#import <YYComponents/UIView+YYExtension.h>
#import <YYComponents/UIColor+YYExtension.h>

//------------------------------YYBarChartBarCell-----------
@interface YYBarChartBarCell : UICollectionViewCell
/// bar宽度
@property(nonatomic, assign, class) CGFloat barWidth;
/// item间距
@property(nonatomic, assign, class) CGFloat spacing;
/// bar底部间距
@property(nonatomic, assign, class) CGFloat barContentBottom;
/// 顶部
@property(nonatomic, strong) UIView *topView;
/// 中间
@property(nonatomic, strong) UIView *barView;
/// 底部
@property(nonatomic, strong) UIView *bottomView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 模型
@property(nonatomic, strong) YYBarChartNode *node;
/// 索引
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, copy) UIView *(^customTopviewBlock)(YYBarChartNode *node, NSInteger index);
@property(nonatomic, copy) UIView *(^customBottomviewBlock)(YYBarChartNode *node, NSInteger index);

@end

static CGFloat _barWidth;
static CGFloat _spacing;
static CGFloat _barContentBottom;

@implementation YYBarChartBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.contentView.backgroundColor = UIColor.yy_randomColor;
        [self setupviews];
    }
    return self;
}

- (void)setupviews {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.barView.mas_top);
    }];
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(YYBarChartBarCell.barWidth);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(YYBarChartBarCell.barContentBottom);
    }];
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.clipsToBounds = YES;
//        _topView.backgroundColor = UIColor.yy_randomColor;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}
- (UIView *)barView {
    if (!_barView) {
        _barView = [UIView new];
//        _barView.backgroundColor = UIColor.yy_randomColor;
        [self.contentView addSubview:_barView];
    }
    return _barView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.clipsToBounds = YES;
//        _bottomView.backgroundColor = UIColor.yy_randomColor;
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}
+ (void)setBarWidth:(CGFloat)barWidth {
    _barWidth = barWidth;
}
+ (CGFloat)barWidth {
    return _barWidth;
}
+ (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
}
+ (CGFloat)spacing {
    return _spacing;
}
+ (void)setBarContentBottom:(CGFloat)barContentBottom {
    _barContentBottom = barContentBottom;
}
+ (CGFloat)barContentBottom {
    return _barContentBottom;
}
- (void)setCustomTopviewBlock:(UIView *(^)(YYBarChartNode *node, NSInteger index))customTopviewBlock {
    _customTopviewBlock = customTopviewBlock;
    if (customTopviewBlock == nil){return;}
    UIView *customTopView = customTopviewBlock(self.node, self.index);
    if (customTopView) {
        [self.topView yy_removeAllSubviews];
        [self.topView addSubview:customTopView];
        [customTopView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.topView);
        }];
    }
}
- (void)setCustomBottomviewBlock:(UIView *(^)(YYBarChartNode *node, NSInteger index))customBottomviewBlock {
    _customTopviewBlock = customBottomviewBlock;
    if (customBottomviewBlock == nil){return;}
    UIView *customBottomView = customBottomviewBlock(self.node, self.index);
    if (customBottomView) {
        [self.bottomView yy_removeAllSubviews];
        [self.bottomView addSubview:customBottomView];
        [customBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.bottomView);
            make.bottom.lessThanOrEqualTo(self.bottomView);
        }];
    }
}
- (void)setNode:(YYBarChartNode *)node {
    _node = node;
    self.titleLabel.text = [@(node.value) stringValue];
    self.titleLabel.textColor = node.titleColor;
    self.titleLabel.font = node.titleFont;
    self.barView.backgroundColor = node.barColor;
    [self.barView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(node.barHeight);
    }];
    [self.contentView updateConstraintsIfNeeded];
}
@end

//------------------------------YYBarChartYView-----------
@interface YYBarChartYView : UIView

@property(nonatomic, assign, class) CGFloat titleMaxWidth;
@property(nonatomic, assign, class) CGFloat titleViewHeight;
@property(nonatomic, assign, class) CGFloat lineHeight;
@property(nonatomic, strong, class) UIColor *lineColor;
@property(nonatomic, assign, class) CGFloat lineTitleSpacingY;
@property(nonatomic, strong) UIView *titleBgView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, strong) YYBarChartNode *node;

@end

@implementation YYBarChartYView

static CGFloat _titleMaxWidth = 30;
static CGFloat _titleViewHeight = 8;
static CGFloat _lineHeight = 0.5f;
static UIColor *_lineColor;
static CGFloat _lineTitleSpacingY = 10;

+ (void)setTitleMaxWidth:(CGFloat)titleMaxWidth {
    _titleMaxWidth = titleMaxWidth;
}

+ (CGFloat)titleMaxWidth {
    return _titleMaxWidth;
}
+ (void)setTitleViewHeight:(CGFloat)titleViewHeight {
    _titleViewHeight = titleViewHeight;
}
+ (CGFloat)titleViewHeight {
    return _titleViewHeight;
}
+ (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
}
+ (CGFloat)lineHeight {
    return _lineHeight;
}
+ (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}
+ (UIColor *)lineColor {
    return _lineColor;
}
+ (void)setLineTitleSpacingY:(CGFloat)lineTitleSpacingY {
    _lineTitleSpacingY = lineTitleSpacingY;
}
+ (CGFloat)lineTitleSpacingY {
    return _lineTitleSpacingY;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupviews];
    }
    return self;
}
- (void)setupviews {
    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(YYBarChartYView.titleMaxWidth);
        make.height.mas_equalTo(YYBarChartYView.titleViewHeight);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self);
        make.left.equalTo(self.titleBgView.mas_right).offset(YYBarChartYView.lineTitleSpacingY);
        make.height.mas_equalTo(YYBarChartYView.lineHeight);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleBgView);
    }];
}
#pragma mark - Lazyload
- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = [UIView new];
        [self addSubview:_titleBgView];
    }
    return _titleBgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self.titleBgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        [self addSubview:_lineView];
    }
    return _lineView;
}
#pragma mark - Setter
- (void)setNode:(YYBarChartNode *)node {
    _node = node;
    self.titleLabel.text = node.title;
    self.titleLabel.textColor = node.titleColor;
    self.titleLabel.font = node.titleFont;
}

@end
//------------------------------YYBarChart-----------
@interface YYBarChart()<UICollectionViewDataSource, UICollectionViewDelegate>
/// 配置文件
@property(nonatomic, strong) YYBarChartConfig *config;
/// 内容视图
@property(nonatomic, strong) UIView *contentView;
/// y轴内容
@property(nonatomic, strong) UIView *contentViewY;
/// x轴内容
@property(nonatomic, strong) UIView *contentViewX;
/// 柱状图内容
@property(nonatomic, strong) UICollectionView *collectionView;
/// 柱状图内容左间距
@property(nonatomic, assign) CGFloat contentYLeftMargin;
/// X轴数据
@property(nonatomic, strong) NSArray <YYBarChartNode*> *dataX;
/// Y轴数据
@property(nonatomic, strong) NSArray <YYBarChartNode*> *dataY;
/// bar顶部内容
@property(nonatomic, copy) UIView *(^customTopviewBlock)(YYBarChartNode *node, NSInteger index);
/// 顶部复用视图
@property(nonatomic, strong) NSMutableArray *topResuseviews;
/// bar底部内容
@property(nonatomic, copy) UIView *(^customBottomviewBlock)(YYBarChartNode *node, NSInteger index);
/// 底部复用视图
@property(nonatomic, strong) NSMutableArray *bottomResuseviews;
@end

@implementation YYBarChart

+ (instancetype)defaultBarChart {
    return [self barChartWithConfig:nil];
}

+ (instancetype)barChartWithConfig:(nullable void(^)(YYBarChartConfig *config))configBlock {
    YYBarChart *chart = [YYBarChart new];
    if (configBlock) {
        configBlock(chart.config);
    }
    [chart configs];
    [chart setupviews];
    return chart;
}
/**
 自定义bar顶部内容
 @param configBlock      配置block，resuseviews是避免每次大量创建视图，节省一点点性能
 */
- (void)addBarTopViewWithConfig:(UIView *(^)(YYBarChartNode *node, NSInteger index, NSInteger barCount, NSArray *resuseviews))configBlock {
    if (configBlock) {
        __weak typeof(self) weakSelf = self;
        self.customTopviewBlock = ^UIView *(YYBarChartNode *node, NSInteger index) {
            UIView *view = configBlock(node, index, weakSelf.dataX.count, weakSelf.topResuseviews.copy);
            if (view != nil && ![weakSelf.topResuseviews containsObject:view]) {
                [weakSelf.topResuseviews addObject:view];
            }
            return view;
        };
    }
//    self.customTopviewBlock = configBlock;
}
/**
 自定义bar底部内容
 @param configBlock      配置block
 */
- (void)addBarBottomViewWithConfig:(UIView *(^)(YYBarChartNode *node, NSInteger index, NSInteger barCount, NSArray *resuseviews))configBlock {
    if (configBlock) {
        __weak typeof(self) weakSelf = self;
        self.customBottomviewBlock = ^UIView *(YYBarChartNode *node, NSInteger index) {
            UIView *view = configBlock(node, index, weakSelf.dataX.count, weakSelf.bottomResuseviews.copy);
            if (view != nil && ![weakSelf.bottomResuseviews containsObject:view]) {
                [weakSelf.bottomResuseviews addObject:view];
            }
            return view;
        };
    }
//    self.customBottomviewBlock = configBlock;
}
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)configs {
    self.collectionView.bounces = self.config.bounces;
}
- (void)setupviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.config.padding);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentViewX);
    }];
}
- (void)updateContentViewX {
    [self.contentViewX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0.f, self.contentYLeftMargin, 0.f, 0.f));
    }];
}
#pragma mark - Lazy load
- (YYBarChartConfig *)config {
    if (!_config) {
        _config = [YYBarChartConfig new];
    }
    return _config;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
//        _contentView.backgroundColor = UIColor.yy_randomColor.yy_setAlpha(0.5);
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (UIView *)contentViewY {
    if (!_contentViewY) {
        _contentViewY = [UIView new];
//        _contentViewY.backgroundColor = UIColor.yy_randomColor.yy_setAlpha(0.5);
        [self.contentView addSubview:_contentViewY];
    }
    return _contentViewY;
}
- (UIView *)contentViewX {
    if (!_contentViewX) {
        _contentViewX = [UIView new];
//        _contentViewX.backgroundColor = UIColor.yy_randomColor.yy_setAlpha(0.5);
        [self.contentView addSubview:_contentViewX];
    }
    return _contentViewX;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.clearColor;
        [_collectionView registerClass:[YYBarChartBarCell class] forCellWithReuseIdentifier:YYBarChartBarCell.yy_classIdentifier];
        [self.contentViewX addSubview:_collectionView];
    }
    return _collectionView;
}
- (NSMutableArray *)topResuseviews {
    if (!_topResuseviews) {
        _topResuseviews = @[].mutableCopy;
    }
    return _topResuseviews;
}
- (NSMutableArray *)bottomResuseviews {
    if (!_bottomResuseviews) {
        _bottomResuseviews = @[].mutableCopy;
    }
    return _bottomResuseviews;
}
/**
 刷新数据
 */
- (void)reload {
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataX.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYBarChartNode *node = self.dataX[indexPath.item];
    YYBarChartBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YYBarChartBarCell.yy_classIdentifier forIndexPath:indexPath];
    cell.index = indexPath.item;
    cell.node = node;
    cell.customTopviewBlock = self.customTopviewBlock;
    cell.customBottomviewBlock = self.customBottomviewBlock;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YYBarChartNode *node = self.dataX[indexPath.item];
    !self.barClickCallback?:self.barClickCallback(node, indexPath.item);
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = self.config.itemWidthX + self.config.itemSpacingX;
    return CGSizeMake(itemWidth, self.contentViewX.frame.size.height);
}
#pragma mark - Methods
- (void)updateTitlesYWithData:(NSArray<YYBarChartNode *> *)data {
    ///算出最大的值
    NSString *maxTitle = [[[data valueForKeyPath:@"title"] valueForKeyPath:@"@max.integerValue"] stringValue];
    CGFloat maxFontPointSize = [[[data valueForKeyPath:@"titleFont"] valueForKeyPath:@"@max.pointSize"] floatValue];
    CGFloat maxWidth = [self widthForString:maxTitle font:[UIFont systemFontOfSize:maxFontPointSize]] + 2.f;
    CGFloat textHeight = [[[data valueForKeyPath:@"titleFont"] valueForKeyPath:@"@max.lineHeight"] floatValue] + 0.5f;
    YYBarChartYView.lineColor = self.config.lineColorY;
    YYBarChartYView.lineHeight = self.config.lineHeightY;
    YYBarChartYView.titleViewHeight = textHeight;
    YYBarChartYView.titleMaxWidth = maxWidth;
    self.contentYLeftMargin = maxWidth + self.config.lineTitleSpacingY;
//    YYBarChartBarCell.barContentBottom = textHeight + textHeight * 0.5;
    YYBarChartBarCell.barContentBottom = self.config.barBottomHeight;
    [self.contentViewY.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat itemSpaceing = self.config.itemHeightY - YYBarChartYView.titleViewHeight;
    __weak typeof(self) weakSelf = self;
    CGFloat contentViewYBottomMargin = self.config.barBottomHeight - YYBarChartYView.titleViewHeight*0.5f;
    [self.contentViewY mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(YYBarChartYView.titleViewHeight, 0.f, contentViewYBottomMargin, 0.f));
    }];
    [self.contentView bringSubviewToFront:self.contentViewX];
    [self.contentViewY yy_addSubviewsWithDirection:YYLayoutSubviewsVertical itemNumber:data.count itemEdgeInsets:UIEdgeInsetsZero itemSpacing:itemSpaceing itemBuild:^UIView * _Nonnull(NSInteger index) {
        YYBarChartYView *vView = [YYBarChartYView new];
        vView.lineView.backgroundColor = weakSelf.config.lineColorY;
        vView.node = data[index];
        return vView;
    }];
}
- (CGFloat)widthForString:(NSString *)content font:(UIFont*)font {
    return [content sizeWithAttributes:@{NSFontAttributeName: font}].width;
}
- (void)updateTitlesXWithData:(NSArray<YYBarChartNode *> *)data {
    [self updateContentViewX];
    YYBarChartBarCell.barWidth = self.config.itemWidthX;
    YYBarChartBarCell.spacing = self.config.itemSpacingX;
    ///计算柱子高度
    CGFloat yTotalHeight = (self.dataY.count - 1) * self.config.itemHeightY;
    CGFloat minValue = [[[self.dataY valueForKeyPath:@"value"] valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat maxValue = [[[self.dataY valueForKeyPath:@"value"] valueForKeyPath:@"@max.floatValue"] floatValue];
    if (maxValue - minValue > 0) {
        CGFloat preHeight = yTotalHeight/(maxValue - minValue);
        for (YYBarChartNode *node in self.dataX) {
            CGFloat height = (node.value - minValue)*preHeight;
            height = MAX(height, 0);
            [node setValue:@(height) forKey:@"barHeight"];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - Setter
/**
 配置x y轴数据
 @param dataX      X轴数据源
 @param dataY      X轴数据源
 */
- (void)configDataX:(NSArray<YYBarChartNode *> *)dataX
              dataY:(NSArray<YYBarChartNode *> *)dataY {
    ///对dataY进行排序
    dataY = [dataY sortedArrayUsingComparator:^NSComparisonResult(YYBarChartNode  *_Nonnull obj1, YYBarChartNode  *_Nonnull obj2) {
        return [obj1.title floatValue] < [obj2.title floatValue];
    }];
    self.dataX = dataX;
    self.dataY = dataY;
    [self updateTitlesYWithData:dataY];
    [self updateTitlesXWithData:dataX];
}
@end
//------------------------------YYBarChartConfig-----------
@implementation YYBarChartConfig
- (instancetype)init {
    if (self = [super init]) {
        self.padding = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        self.itemWidthX = 20.f;
        self.itemSpacingX = self.itemWidthX;
        self.itemHeightY = 25.f;
        self.lineHeightY = 0.5f;
        self.lineColorY = UIColor.yy_colorWithHex(@"#E0E6F1");
        self.lineTitleSpacingY = 10.f;
        self.bounces = YES;
    }
    return self;
}

@end
//------------------------------YYBarChartNode-----------
@interface YYBarChartNode()

@end

@implementation YYBarChartNode
- (instancetype)init {
    if (self = [super init]) {
        self.titleFont = [UIFont systemFontOfSize:12.f];
    }
    return self;
}
@end
