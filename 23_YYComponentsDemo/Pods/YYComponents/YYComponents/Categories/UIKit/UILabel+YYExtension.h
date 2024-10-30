//
//  UILabel+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLabelConfig : NSObject

@property(nonatomic, strong) UIColor *textColor;

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, assign) NSTextAlignment textAlignment;

@property(nonatomic, strong) UIFont *font;

@property(nonatomic, copy) NSString *text;

@property(nonatomic, assign) NSInteger numberOfLines;

@property(nonatomic, assign) UILayoutPriority horizontalHuggingPriority;

@property(nonatomic, assign) UILayoutPriority horizontalCompressionResistancePriority;

@property(nonatomic, assign) BOOL hidden;

@property(nonatomic, assign) CGFloat lineSpacing;

@property(nonatomic, assign) BOOL adjustsFontSizeToFitWidth;

@end

@interface UILabel (YYExtension)

@property(nonatomic, assign) CGFloat yy_lineSpacing;

/**
 快速创建label
 @param configBlock   配置描述
 @return              label
 */
+ (instancetype)yy_labelWithConfig:(void(^)(YYLabelConfig *config))configBlock;

- (void)_setText:(NSString*)text
     lineSpacing:(CGFloat)lineSpacing;

/**
 生成一个和该对象特征一样的对象，仅限YYLabelConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy;
/**
 生成一个和该对象特征一样的对象，仅限YYLabelConfig中的属性
 @param configBlock      配置block
 @return            新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYLabelConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
