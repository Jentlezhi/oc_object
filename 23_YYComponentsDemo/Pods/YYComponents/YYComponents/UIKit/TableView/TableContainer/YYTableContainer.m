//
//  YYTableContainer.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2020/11/1.
//

#import "YYTableContainer.h"
#import "UITableView+YYExtension.h"
#import "Masonry.h"

@implementation YYTableContainerConfig

- (instancetype)init {
    if (self = [super init]) {
        self.tableViewStyle = UITableViewStyleGrouped;
        self.estimatedRowHeight = 44.f;
    }
    return self;
}
@end

@interface YYTableContainer()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) YYTableContainerConfig *config;

@property(nonatomic, strong) UITableView *tableView;

/// 缓存sectionHeader/footer高度
@property(nonatomic, strong) NSMutableDictionary *sectionHeaderFooterHeightMap;

@end

@implementation YYTableContainer
/**
 创建静态表格
 @param itemNumber        数量
 @param contentEdgeInsets 间距
 @param itemSpacing       子视图间距
 @param itemBuild         创建子视图
 @return                  表格
 */
+ (instancetype)containerWithItemNumber:(NSInteger)itemNumber
                      contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                            itemSpacing:(CGFloat)itemSpacing
                    showScrollIndicator:(BOOL)showScrollIndicator
                              itemBuild:(nonnull UIView* (^)(NSIndexPath * _Nonnull indexPath))itemBuild {
    return [YYTableContainer containerWithConfig:^(YYTableContainerConfig * _Nonnull config) {
        config.contentEdgeInsets = contentEdgeInsets;
        config.showsVerticalScrollIndicator = showScrollIndicator;
        config.numberOfRowsInSection = ^NSInteger(UITableView * _Nonnull tableView, NSInteger section) {
            return itemNumber;
        };
        config.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            UIView *itemContentView = itemBuild(indexPath);
            if (itemContentView) {
                NSString *identifier = [NSString stringWithFormat:@"%lu",(unsigned long)[tableView hash]];
                YYTableViewCell *cell = [YYTableViewCell cellWithContentView:itemContentView edgeInsets:UIEdgeInsetsMake(itemSpacing*0.5f, 0, itemSpacing*0.5f, itemSpacing) reuseIdentifier:identifier];
                return cell;
            }
            return nil;
        };
    }];
}
#pragma mark - Lifecycle
/**
 创建表格
 @param configBlock     配置文件
 @return                表格
 */
+ (instancetype)containerWithConfig:(void(^)(YYTableContainerConfig *config))configBlock {
    YYTableContainer *container = [self new];
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.config.contentEdgeInsets);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.config.tableHeaderView) {
        self.tableView.yy_tableHeaderView = self.config.tableHeaderView;
    }
    if (self.config.tableFooterView) {
        self.tableView.yy_tableFooterView = self.config.tableFooterView;
    }
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.config.viewForHeaderInSection) {
        NSString *identifier = [NSString stringWithFormat:@"sectionHeader_identifier_%ld",section];
        UITableViewHeaderFooterView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!sectionHeaderView) {
            sectionHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
            UIView *contentView = self.config.viewForHeaderInSection(tableView, section);
            [sectionHeaderView addSubview:contentView];
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(sectionHeaderView);
            }];
        }
        return sectionHeaderView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.config.viewForHeaderInSection) {
        UIView *sectionHeader = self.config.viewForHeaderInSection(tableView, section);
        if (sectionHeader) {
            NSString *key = [NSString stringWithFormat:@"sectionHeader_%ld",section];
            NSNumber *heightNumber = [self.sectionHeaderFooterHeightMap valueForKey:key];
            CGFloat height;
            if (heightNumber) {
                height = [heightNumber floatValue];
            } else {
                height = [sectionHeader systemLayoutSizeFittingSize:CGSizeMake(tableView.frame.size.width, 0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
                [self.sectionHeaderFooterHeightMap setValue:@(height) forKey:key];
            }
            return height;
        }
        return CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.config.viewForFooterInSection) {
        NSString *identifier = [NSString stringWithFormat:@"sectionFooter_identifier_%ld",section];
        UITableViewHeaderFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!sectionFooterView) {
            sectionFooterView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
            UIView *contentView = self.config.viewForFooterInSection(tableView, section);
            [sectionFooterView addSubview:contentView];
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(sectionFooterView);
            }];
        }
        return sectionFooterView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.config.viewForFooterInSection) {
        UIView *sectionFooter = self.config.viewForFooterInSection(tableView, section);
        if (sectionFooter) {
            NSString *key = [NSString stringWithFormat:@"sectionFooter_%ld",section];
            NSNumber *heightNumber = [self.sectionHeaderFooterHeightMap valueForKey:key];
            CGFloat height;
            if (heightNumber) {
                height = [heightNumber floatValue];
            } else {
                height = [sectionFooter systemLayoutSizeFittingSize:CGSizeMake(tableView.frame.size.width, 0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
                [self.sectionHeaderFooterHeightMap setValue:@(height) forKey:key];
            }
            return height;
        }
        return CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.config.numberOfSections) {
        NSInteger cout = self.config.numberOfSections(tableView);
        return cout;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.config.numberOfRowsInSection) {
        return self.config.numberOfRowsInSection(tableView,section);
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.cellForRowAtIndexPath) {
        UITableViewCell *cell = self.config.cellForRowAtIndexPath(tableView, indexPath);
        if (cell) {
            return cell;
        }
        return [UITableViewCell new];
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.didSelectRowAtIndexPath) {
        self.config.didSelectRowAtIndexPath(tableView, indexPath);
    }
}
/**
 刷新
 */
- (void)reloadData {
    [self.tableView reloadData];
}
#pragma mark - Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.config.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = self.config.estimatedRowHeight;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.contentInset = self.config.tableEdgeInsets;
        _tableView.showsVerticalScrollIndicator = self.config.showsVerticalScrollIndicator;
        /// 隐藏分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = CGFLOAT_MIN;
        }
        ///当设置为UITableViewStyleGrouped是，需要设置tableHeaderView，否则就会有一个默认的间隔，消除的方法为设置高度为CGFLOAT_MIN
        if (_tableView.style == UITableViewStyleGrouped) {
            _tableView.tableHeaderView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        }
        _tableView.estimatedSectionHeaderHeight = CGFLOAT_MIN;
        _tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
        ///移除多余的分割线
        _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (YYTableContainerConfig *)config {
    if (!_config) {
        _config = [YYTableContainerConfig new];
    }
    return _config;
}
- (NSMutableDictionary *)sectionHeaderFooterHeightMap {
    if (!_sectionHeaderFooterHeightMap) {
        _sectionHeaderFooterHeightMap = @{}.mutableCopy;
    }
    return _sectionHeaderFooterHeightMap;
}
@end
