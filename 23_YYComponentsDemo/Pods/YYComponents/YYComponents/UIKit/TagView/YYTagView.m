//
//  YYTagView.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/19.
//

#import "YYTagView.h"
#import "Masonry.h"

@implementation YYTagViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width;
    }
    return self;
}

@end

@interface YYTagView()

@property(nonatomic, strong) YYTagViewConfig *config;

@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, copy) NSInteger (^itemCountBlock)(YYTagViewConfig *config);

@property(nonatomic, copy) UIView *(^itemBuildBlock)(NSInteger index);

@property(nonatomic, copy) void(^clickCallback)(YYTagViewConfig *config, NSInteger index);

@property(nonatomic, assign) NSInteger lineCount;

@end

const NSInteger itemViewTagMin = 1000000;

@implementation YYTagView

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
                  didClickItem:(void(^)(YYTagViewConfig *config, NSInteger index))didClickItemBlock {
    YYTagView *tagView = [self new];
    if (configBlock) {
        configBlock(tagView.config);
    }
    [tagView configs];
    tagView.itemCountBlock = itemCountBlock;
    tagView.itemBuildBlock = itemBuildBlock;
    tagView.clickCallback = didClickItemBlock;
    [tagView setupViews];
    [tagView buildItemViews];
    return tagView;
}
- (void)configs {
    self.lineCount = 1;
}
- (void)setupViews {
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.config.padding);
    }];
}

- (void)buildItemViews {
    if (!self.itemBuildBlock){return;}
    if (!self.itemCountBlock){return;}
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger itemCount = self.itemCountBlock(self.config);
    CGFloat itemSpacingH = self.config.itemSpacingH;
    CGFloat itemSpacingV = self.config.itemSpacingV;
    CGFloat paddingLeft = self.config.padding.left;
    CGFloat paddingRight = self.config.padding.right;
    CGFloat contentMaxWidth = self.config.preferredMaxLayoutWidth - paddingLeft - paddingRight;
    CGFloat remainingWidth = 0.f;
    UIView *preItem = nil;
    UIView *preLineItem = nil;
    CGFloat currentItemWidth;
    for(NSInteger index = 0; index < itemCount; index++) {
        UIView *itemView = self.itemBuildBlock(index);
        itemView.tag = itemViewTagMin + index;
        if (itemView == nil){continue;}
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        [itemView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:itemView];
        currentItemWidth = [itemView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
        if (index > 0) {
            remainingWidth -= (currentItemWidth + itemSpacingH);
            if (remainingWidth <= 0) {
                preItem = nil;
            } else {
                preItem = self.contentView.subviews[index-1];
            }
        } else {
            preItem = nil;
            remainingWidth = contentMaxWidth - (currentItemWidth + itemSpacingH);
        }
        //剩余宽度不足
        if (remainingWidth <= 0 && index > 0) {
            preLineItem = self.contentView.subviews[index-1];
            remainingWidth = contentMaxWidth - (currentItemWidth + itemSpacingH);
        }
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (preLineItem) {
                make.top.equalTo(preLineItem.mas_bottom).offset(itemSpacingV);
            } else {
                make.top.mas_equalTo(0.f);
            }
            if (preItem) {
                make.left.equalTo(preItem.mas_right).offset(itemSpacingH);
            } else {
                make.left.mas_equalTo(0.f);
            }
            make.width.mas_lessThanOrEqualTo(contentMaxWidth);
            if (index == itemCount - 1) {
                make.bottom.equalTo(self.contentView);
            }
        }];
    }
}

#pragma mark - Methods
- (void)reloadData {
    [self buildItemViews];
}
- (void)itemClickAction:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - itemViewTagMin;
    !self.clickCallback?:self.clickCallback(self.config,index);
}
#pragma mark - Lazyload
- (YYTagViewConfig *)config {
    if (!_config) {
        _config = [YYTagViewConfig new];
    }
    return _config;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

@end
