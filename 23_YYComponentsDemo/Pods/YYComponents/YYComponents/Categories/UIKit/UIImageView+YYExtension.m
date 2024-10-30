//
//  UIImageView+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UIImageView+YYExtension.h"
#import <objc/runtime.h>
#import <YYComponents/YYFoundationExtension.h>

const char *YYIMAGEVIEWCONFIGKEY = "YYIMAGEVIEWCONFIGKEY";

@implementation YYImageViewConfig

- (instancetype)init {
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end

@implementation UIImageView (YYExtension)

+ (instancetype)yy_imageViewWithConfig:(void(^)(YYImageViewConfig *config))configBlock {
    YYImageViewConfig *config = [YYImageViewConfig new];
    !configBlock?:configBlock(config);
    UIImageView *i = [self new];
    ///存储config
    objc_setAssociatedObject(i, YYIMAGEVIEWCONFIGKEY, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (config.image) {
        i.image = config.image;
    } else {
        if (config.imageName != nil && config.imageName.length > 0) {
            i.image = [UIImage imageNamed:config.imageName];
        }
    }
    i.contentMode = config.contentMode;
    if (config.cornerRaduis > 0) {
        i.layer.cornerRadius = config.cornerRaduis;
        i.layer.masksToBounds = YES;
    }
    if (config.borderColor && config.borderWidth > 0) {
        i.layer.borderColor = config.borderColor.CGColor;
        i.layer.borderWidth = config.borderWidth;
    }
    if (config.backgroundColor) {
        i.backgroundColor = config.backgroundColor;
    }
    i.hidden = config.hidden;
    return i;
}
/**
 生成一个和该对象特征一样的对象，仅限YYImageViewConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy {
    return [self yy_copyWithConfig:nil];
}

/**
 生成一个和该对象特征一样的对象，仅限YYImageViewConfig中的属性
 @param configBlock      配置block
 @return                 新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYImageViewConfig *config))configBlock {
    YYImageViewConfig *currentConfig = objc_getAssociatedObject(self, YYIMAGEVIEWCONFIGKEY);
    UIImageView *i = [[self class] yy_imageViewWithConfig:^(YYImageViewConfig * _Nonnull config) {
        [currentConfig yy_setAllPropertiesValueToModel:config];
        if (configBlock) {
            configBlock(config);
        }
    }];
    return i;
}
@end
