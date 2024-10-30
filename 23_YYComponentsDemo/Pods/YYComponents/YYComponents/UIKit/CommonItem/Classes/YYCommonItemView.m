//
//  YYCommonItemView.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/3.
//

#import "YYCommonItemView.h"
#import "YYBundleHelper.h"
#import <Masonry.h>

@implementation YYCommonItemViewConfig
- (instancetype)init {
    if (self = [super init]) {
        self.autoLayout = YES;
        self.contentEdgeInsets = UIEdgeInsetsZero;
        self.titleFont = [UIFont boldSystemFontOfSize:14.f];
        self.titleColor = UIColor.blackColor;
        self.contentFont = [UIFont systemFontOfSize:14.f];
        self.contentColor = UIColor.blackColor;
        self.titleWidth = 0.f;
        self.showRightIcon = YES;
        self.rightIconSize = CGSizeMake(16.f, 16.f);
        self.placeHolderFont = [UIFont systemFontOfSize:14.f];
        self.placeHolderColor = UIColor.blackColor;
    }
    return self;
}
@end

@interface YYCommonItemView()

/// 卡片视图
@property(nonatomic, strong) UIView *cardView;
/// 内容视图
@property(nonatomic, strong) UIView *contentView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 内容
@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIImageView *rightIcon;

@property(nonatomic, strong) YYCommonItemViewConfig *config;

@property(nonatomic, copy) void(^clickBlock)(void);

@end

@implementation YYCommonItemView

+ (instancetype)itemWithConfig:(nullable void(^)(YYCommonItemViewConfig *config))configBlock
                         click:(nullable void(^)(void))clickBlock {
    YYCommonItemView *itemView = [YYCommonItemView new];
    if (configBlock) {
        configBlock(itemView.config);
    }
    itemView.clickBlock = clickBlock;
    [itemView setupViews];
    [itemView configs];
    return itemView;
}
- (void)configs {
    if (self.config.backgroundColor) {
        self.backgroundColor = self.config.backgroundColor;
    }
    self.content = self.config.content;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAction)];
    [self.cardView addGestureRecognizer:tapGesture];
}
- (void)clickedAction {
    !self.clickBlock?:self.clickBlock();
}
- (void)setupViews {
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.config.cardEdgeInsets);
        if (!self.config.autoLayout) {
            make.height.mas_equalTo(self.config.contentHeight);
        }
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.config.contentEdgeInsets);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        if (self.config.autoLayout) {
            if (self.config.contentNumberOfLines == 1) {
                make.top.bottom.equalTo(self.contentView);
            } else {
                make.top.equalTo(self.contentView);
            }
        } else {
            make.centerY.equalTo(self.contentView);
        }
        if (self.config.titleWidth > 0.1f) {
            make.width.mas_equalTo(self.config.titleWidth);
        }
    }];
    if (self.config.showRightIcon) {
        [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0.f);
            make.centerY.equalTo(self.titleLabel);
            make.size.mas_equalTo(self.config.rightIconSize);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.config.contentTextAlignment == NSTextAlignmentLeft) {
                make.left.equalTo(self.titleLabel.mas_right).offset(self.config.contentLeftMargin);
                make.right.mas_lessThanOrEqualTo(self.rightIcon.mas_left).offset(-self.config.contentRightMargin);
            } else {
                make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(self.config.contentLeftMargin);
                make.right.mas_equalTo(self.rightIcon.mas_left).offset(-self.config.contentRightMargin);
            }
            if (self.config.contentNumberOfLines == 1) {
                make.centerY.equalTo(self.titleLabel);
            } else {
                make.top.equalTo(self.titleLabel).offset(self.config.contentOffsetTop);
            }
            if (self.config.autoLayout) {
                make.bottom.equalTo(self.contentView);
            }
        }];
    } else {
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.config.contentTextAlignment == NSTextAlignmentLeft) {
                make.left.equalTo(self.titleLabel.mas_right).offset(self.config.contentLeftMargin);
                make.right.mas_lessThanOrEqualTo(-self.config.contentRightMargin);
            } else {
                make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(self.config.contentLeftMargin);
                make.right.mas_equalTo(-self.config.contentRightMargin);
            }
            if (self.config.contentNumberOfLines == 1) {
                make.centerY.equalTo(self.titleLabel);
            } else {
                make.top.equalTo(self.titleLabel).offset(self.config.contentOffsetTop);
            }
            if (self.config.autoLayout) {
                make.bottom.equalTo(self.contentView);
            }
        }];
    }
}
- (YYCommonItemViewConfig *)config {
    if (!_config) {
        _config = [YYCommonItemViewConfig new];
    }
    return _config;
}
- (UIView *)cardView {
    if (!_cardView) {
        _cardView = [UIView new];
        if (self.config.cardBackgroundColor){
            _cardView.backgroundColor = self.config.cardBackgroundColor;
        }
        if (self.config.cardCornerRadius) {
            _cardView.layer.cornerRadius = self.config.cardCornerRadius;
            _cardView.layer.masksToBounds = YES;
        }
        [self addSubview:_cardView];
    }
    return _cardView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        [self.cardView addSubview:_contentView];
    }
    return _contentView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = self.config.titleFont;
        _titleLabel.textColor = self.config.titleColor;
        _titleLabel.text = self.config.title;
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = self.config.contentFont;
        _contentLabel.textColor = self.config.contentColor;
        _contentLabel.text = self.config.content;
        _contentLabel.numberOfLines = self.config.contentNumberOfLines;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
- (UIImageView *)rightIcon {
    if (!_rightIcon) {
        _rightIcon = [UIImageView new];
        if (self.config.rightIcon) {
            _rightIcon.image = self.config.rightIcon;
        } else {
            _rightIcon.image = [YYBundleHelper imageName:@"right_arrow" bundleName:@"YYCommonItem"];
        }
        [self.contentView addSubview:_rightIcon];
    }
    return _rightIcon;
}
#pragma mark - Setter
- (void)setContent:(NSString *)content {
    _content = content;
    if (content == nil || content.length == 0) {
        self.contentLabel.text = self.config.placeHolder;
        self.contentLabel.font = self.config.placeHolderFont;
        self.contentLabel.textColor = self.config.placeHolderColor;
        self.contentLabel.numberOfLines = 1;
    } else {
        self.contentLabel.text = content;
        self.contentLabel.font = self.config.contentFont;
        self.contentLabel.textColor = self.config.contentColor;
        self.contentLabel.numberOfLines = self.config.contentNumberOfLines;
    }
}
@end
