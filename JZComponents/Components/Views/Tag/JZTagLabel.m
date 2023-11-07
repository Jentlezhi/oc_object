//
//  JZUIKitExtension.m
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import "JZTagLabel.h"

@interface JZTagLabel()

@property(nonatomic, strong) UIButton *tagLabel;

@end

@implementation JZTagLabel
/**
 标签初始化
 @param text                     内容
 @param textFont                 字体
 @param textBackgroundColor      背景颜色
 @param cornerRadius             圆角
 @param contentInsets            内边距
 @return 标签
 */
+ (instancetype)labelWithText:(NSString *)text
                                textFont:(UIFont *)textFont
                     textBackgroundColor:(UIColor *)textBackgroundColor
                 cornerRadius:(CGFloat)cornerRadius
                contentInsets:(UIEdgeInsets)contentInsets {
    JZTagLabel *tagLabel = [JZTagLabel new];
    tagLabel.text = text;
    tagLabel.textFont = textFont;
    tagLabel.textBackgroundColor = textBackgroundColor;
    tagLabel.cornerRadius = cornerRadius;
    tagLabel.contentInsets = contentInsets;
    return tagLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self _tagConfig];
        [self _addSubComponents];
    }
    return self;
}

- (void)_tagConfig {
    self.clipsToBounds = YES;
}
- (void)_addSubComponents {
    [self addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Lazy Load
- (UIButton *)tagLabel {
    if (!_tagLabel){
        _tagLabel = [UIButton new];
        _tagLabel.userInteractionEnabled = NO;
    }
    return _tagLabel;
}
#pragma mark - Setter
- (void)setText:(NSString *)text {
    _text = text;
    [self.tagLabel setTitle:text forState:UIControlStateNormal];
}
- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.tagLabel.titleLabel.font = textFont;
}
- (void)setTextBackgroundColor:(UIColor *)textBackgroundColor {
    _textBackgroundColor = textBackgroundColor;
    self.tagLabel.backgroundColor = textBackgroundColor;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.tagLabel.layer.cornerRadius = cornerRadius;
    self.tagLabel.layer.masksToBounds = YES;
}
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    self.tagLabel.contentEdgeInsets = contentInsets;
}

@end
