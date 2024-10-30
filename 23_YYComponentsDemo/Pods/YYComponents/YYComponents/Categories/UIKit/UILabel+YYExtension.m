//
//  UILabel+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UILabel+YYExtension.h"
#import <objc/message.h>
#import <YYComponents/YYComponentsMacro.h>
#import <YYComponents/YYMethodSwizzling.h>
#import <objc/runtime.h>
#import <YYComponents/YYFoundationExtension.h>

const char *YYLABELCONFIGKEY = "YYLABELCONFIGKEY";

@implementation YYLabelConfig

- (instancetype)init {
    if (self = [super init]) {
        self.textColor = UIColor.blackColor;
//        self.backgroundColor = UIColor.whiteColor;
        self.textAlignment = NSTextAlignmentLeft;
        self.font = [UIFont systemFontOfSize:16.f];
        self.text = @"";
        self.numberOfLines = 1;
        self.horizontalHuggingPriority = UILayoutPriorityRequired;
        self.horizontalCompressionResistancePriority = UILayoutPriorityRequired;
        self.hidden = NO;
    }
    return self;
}

@end

@implementation UILabel (YYExtension)

+ (void)load {
    YYExecuteOnce(
                  [YYMethodSwizzling yy_methodSwizzlingWithClass:self originalSEL:@selector(setText:) swizzledSEL:@selector(yy_setText:)];
                  );
}

- (void)yy_setText:(NSString *)text {
    if (self.yy_lineSpacing < 0.1f) {
        [self yy_setText:text];
    } else {
        [self _setText:text lineSpacing:self.yy_lineSpacing];
    }
}

- (void)setYy_lineSpacing:(CGFloat)yy_lineSpacing {
    YYSetAssociatedObject(@selector(yy_lineSpacing), @(yy_lineSpacing), OBJC_ASSOCIATION_RETAIN);
    if (yy_lineSpacing > 0.1f) {
        [self _setText:self.text lineSpacing:yy_lineSpacing];
    }
}
- (CGFloat)yy_lineSpacing {
    return [YYGetAssociatedObject() floatValue];
}

+ (instancetype)yy_labelWithConfig:(void(^)(YYLabelConfig *config))configBlock {
    
    YYLabelConfig *config = [YYLabelConfig new];
    !configBlock?:configBlock(config);
    UILabel *l = [self new];
    ///存储config
    objc_setAssociatedObject(l, YYLABELCONFIGKEY, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    l.textColor = config.textColor;
    if (config.backgroundColor) {
        l.backgroundColor = config.backgroundColor;
    }
    l.textAlignment = config.textAlignment;
    l.font = config.font;
    
    if (config.text != nil) {
        l.text = config.text;
    }
    l.numberOfLines = config.numberOfLines;
    ///抗拉伸
    [l setContentHuggingPriority:config.horizontalHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
    ///抗压缩
    [l setContentCompressionResistancePriority:config.horizontalCompressionResistancePriority forAxis:UILayoutConstraintAxisHorizontal];
    ///行间距
    l.yy_lineSpacing = config.lineSpacing;
    l.hidden = config.hidden;
    l.adjustsFontSizeToFitWidth = config.adjustsFontSizeToFitWidth;
    [l sizeToFit];
    return l;
}

- (void)_setText:(NSString*)text
     lineSpacing:(CGFloat)lineSpacing {
    if (text == nil || text.length == 0) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}
/**
 生成一个和该对象特征一样的对象，仅限YYLabelConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy {
    return [self yy_copyWithConfig:nil];
}
/**
 生成一个和该对象特征一样的对象，仅限YYLabelConfig中的属性
 @param configBlock      配置block
 @return            新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYLabelConfig *config))configBlock {
    YYLabelConfig *currentConfig = objc_getAssociatedObject(self, YYLABELCONFIGKEY);
    UILabel *l = [[self class] yy_labelWithConfig:^(YYLabelConfig * _Nonnull config) {
        [currentConfig yy_setAllPropertiesValueToModel:config];
        if (configBlock) {
            configBlock(config);
        }
    }];
    return l;
}

@end
