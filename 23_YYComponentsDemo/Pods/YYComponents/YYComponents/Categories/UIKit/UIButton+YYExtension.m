//
//  UIButton+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UIButton+YYExtension.h"
#import "UIImage+YYExtension.h"
#import "UIColor+YYExtension.h"
#import <objc/runtime.h>
#import <YYComponents/YYFoundationExtension.h>

const char *YYBUTTONCONFIGKEY = "YYBUTTONCONFIGKEY";


@implementation YYButtonConfig

- (instancetype)init {
    if (self = [super init]) {
        self.normalTitle = @"";
        self.normalTitleColor = UIColor.blackColor;
        self.highlightedTitle = @"";
        self.titleLabelFont = [UIFont systemFontOfSize:16.f];
        self.disabledBackgroundColor = UIColor.yy_colorWithHex(@"#FFD1A6");
        self.enable = YES;
    }
    return self;
}

+ (BOOL)_isEmpty:(NSString *)text {
    if(!text || text == nil || ![text isKindOfClass:[NSString class]]) return YES;
    if ([text isEqual:[NSNull null]]) {return YES;}
    if ([text isKindOfClass:[NSNull class]]) {return YES;}
    ///兼容强制转换为NSString的情况
    if ([text isEqualToString:@"(null)"]) {return YES;}
    if ([text isEqualToString:@"<null>"]) {return YES;}
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [text stringByTrimmingCharactersInSet:set];
    return trimmedStr.length == 0;
}

+ (NSString *)_avoidNil:(NSString *)text {
    if ([self _isEmpty:text]) {
        return @"";
    }
    return text;
}

@end


const char *YYTOUCHUPINSIDEACTIONKEY = "YYTOUCHUPINSIDEACTIONKEY";

@implementation UIButton (YYExtension)

+ (instancetype)yy_buttonWithConfig:(void(^)(YYButtonConfig *config))configBlock {
    return [self yy_buttonWithConfig:configBlock touchUpInside:nil];
}

+ (instancetype)yy_buttonWithConfig:(void(^)(YYButtonConfig *config))configBlock
                      touchUpInside:(nullable void(^)(void))touchUpInsideBlock {
    YYButtonConfig *config = [YYButtonConfig new];
    !configBlock?:configBlock(config);
    UIButton *b = [self buttonWithType:UIButtonTypeCustom];
    ///存储config
    objc_setAssociatedObject(b, YYBUTTONCONFIGKEY, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (![YYButtonConfig _isEmpty:config.normalTitle]) {
        [b setTitle:config.normalTitle forState:UIControlStateNormal];
    }
    if (![YYButtonConfig _isEmpty:config.highlightedTitle]) {
        [b setTitle:config.highlightedTitle forState:UIControlStateHighlighted];
    } else {
        if (![YYButtonConfig _isEmpty:config.normalTitle]) {
            [b setTitle:config.normalTitle forState:UIControlStateHighlighted];
        }
    }
    if (config.normalTitleColor) {
        [b setTitleColor:config.normalTitleColor forState:UIControlStateNormal];
    }
    if (config.highlightedTitleColor){
        [b setTitleColor:config.highlightedTitleColor forState:UIControlStateHighlighted];
    } else {
        if (config.normalTitleColor) {
            [b setTitleColor:[config.normalTitleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        }
    }
    b.titleLabel.font = config.titleLabelFont;
    if (config.disabledBackgroundColor) {
        [b setBackgroundImage:[UIImage yy_imageWithColor:config.disabledBackgroundColor] forState:UIControlStateDisabled];
    }
    if (config.cornerRaduis > 0) {
        b.layer.cornerRadius = config.cornerRaduis;
        b.layer.masksToBounds = YES;
    }
    if (config.borderColor && config.borderWidth > 0) {
        b.layer.borderColor = config.borderColor.CGColor;
        b.layer.borderWidth = config.borderWidth;
    }
    if (config.normalImage) {
        [b setImage:config.normalImage forState:UIControlStateNormal];
    }
    if (config.normalBackgroundColor) {
        [b setBackgroundImage:[UIImage yy_imageWithColor:config.normalBackgroundColor] forState:UIControlStateNormal];
    }
    if (config.normalBackgroundImage) {
        [b setBackgroundImage:config.normalBackgroundImage forState:UIControlStateNormal];
    }
    b.enabled = config.enable;
    b.hidden = config.hidden;
    b.contentEdgeInsets = config.contentEdgeInsets;
    b.yy_touchUpInsideAction = touchUpInsideBlock;
    return b;
}
- (void)setYy_touchUpInsideAction:(void (^)(void))yy_touchUpInsideAction {
    if (yy_touchUpInsideAction) {
        objc_setAssociatedObject(self, YYTOUCHUPINSIDEACTIONKEY, yy_touchUpInsideAction, OBJC_ASSOCIATION_COPY);
        [self addTarget:self action:@selector(_yy_buttonTouchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void (^)(void))yy_touchUpInsideAction {
    return objc_getAssociatedObject(self, YYTOUCHUPINSIDEACTIONKEY);
}
- (void)_yy_buttonTouchUpInsideAction {
    void(^tapBlock)(void) = self.yy_touchUpInsideAction;
    if (tapBlock) {
        tapBlock();
    }
}
/**
 生成一个和该对象特征一样的对象，仅限YYButtonConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy {
    return [self yy_copyWithConfig:nil];
}
/**
 生成一个和该对象特征一样的对象，仅限YYButtonConfig中的属性
 @param configBlock      配置block
 @return                 新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYButtonConfig *config))configBlock {
    YYButtonConfig *currentConfig = objc_getAssociatedObject(self, YYBUTTONCONFIGKEY);
    UIButton *b = [[self class] yy_buttonWithConfig:^(YYButtonConfig * _Nonnull config) {
        [currentConfig yy_setAllPropertiesValueToModel:config];
        //如果外界想额外修改config的其他的属性，则回调出去
        if (configBlock) {
            configBlock(config);
        }
    }];
    return b;
}
/**
 设置按钮被点击的Action
 */
- (void)yy_executeClickedAction {
    if (![self respondsToSelector:@selector(addTarget:action:forControlEvents:)]){return;}
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}

@end
