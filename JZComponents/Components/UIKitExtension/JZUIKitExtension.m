//
//  JZUIKitExtension.m
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import "JZUIKitExtension.h"

/* <----------------------- UITableViewCell -------------------------------> */

@implementation UITableViewCell (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock {
    NSMutableArray *mArray = NSMutableArray.new;
    if (addBlock) {
        mArray = addBlock(mArray);
    }
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self.contentView addSubview:obj];
        }
    }];
    !layoutBlock?:layoutBlock();
}

@end

/* <----------------------- UITableViewCell -------------------------------> */

/* <----------------------- UIView -------------------------------> */

@implementation UIView (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock {
    NSMutableArray *mArray = NSMutableArray.new;
    if (addBlock) {
        mArray = addBlock(mArray);
    }
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }
    }];
    !layoutBlock?:layoutBlock();
}

/**
 设置内容太多不被压缩.
 @param expanded  - 是否展开，不被压缩.
 */
- (void)setMoreExpanded:(BOOL)expanded {
    if (expanded) {
        //设置抗压缩，值越大越不容易压缩
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
}

/**
 设置内容不足不被压缩.
 @param expanded  - 是否拉伸.
 */
- (void)setLessExpanded:(BOOL)expanded {
    if (expanded) {
        //设置抗拉伸，值越小越容易被拉伸
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    }
}

/**
 设置指定方向圆角
 @param rect         坐标
 @param corners      方向
 @param cornerRadii  圆角
 */
- (void)cornerWithRoundedRect:(CGRect)rect
            byRoundingCorners:(UIRectCorner)corners
                  cornerRadii:(CGSize)cornerRadii{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/**
 布局子视图
 @param direction      布局方向
 @param itemNumber     数量
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)jz_addSubviewsWithDirection:(JZLayoutSubviewsDirection)direction
                         itemNumber:(NSInteger)itemNumber
                     itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                        itemSpacing:(CGFloat)itemSpacing
                          itemBuild:(nonnull UIView* (^)(NSInteger index))itemBuild {
    ///构建子视图为nil，直接返回
    if (itemBuild == nil){return;}
    UIView *fatherView = self;
    ///先移除旧视图
    [fatherView removeAllSubviews];
    ///间距
    CGFloat leftSpacing = itemEdgeInsets.left;
    CGFloat rightSpacing = itemEdgeInsets.right;
    CGFloat topSpacing = itemEdgeInsets.top;
    CGFloat bottomSpacing = itemEdgeInsets.bottom;
    BOOL horizontal = (direction == JZLayoutSubviewsHorizontal);
    ///添加新的视图
    for (NSInteger index = 0; index < itemNumber; index ++) {
        UIView *itemView = itemBuild(index);
        ///取前一个视图
        UIView *preItemView = [fatherView.subviews jz_objectAtIndexWithSafe:index - 1];
        [fatherView addSubview:itemView];
        if (horizontal){
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView){
                    make.left.equalTo(preItemView.mas_right).offset(itemSpacing);
                }else{
                    make.left.equalTo(fatherView).offset(leftSpacing);
                }
                make.top.equalTo(fatherView).offset(topSpacing);
                make.bottom.equalTo(fatherView).offset(-bottomSpacing);
                ///最后一个对齐父视图
                if (index == (itemNumber - 1)){
                    make.right.equalTo(fatherView).offset(-rightSpacing);
                }
            }];
        }else{///纵向
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView){
                    make.top.equalTo(preItemView.mas_bottom).offset(itemSpacing);
                }else{
                    make.top.equalTo(fatherView).offset(topSpacing);
                }
                make.left.equalTo(fatherView).offset(leftSpacing);
                make.right.equalTo(fatherView).offset(-rightSpacing);
                ///最后一个对齐父视图
                if (index == (itemNumber - 1)){
                    make.bottom.equalTo(fatherView).offset(-bottomSpacing);
                }
            }];
        }
    }
}
@end

/* <----------------------- UIView -------------------------------> */

/* <----------------------- UIFont -------------------------------> */

@implementation UIFont (JZExtension)

+ (UIFont * _Nonnull (^)(CGFloat))jz_systemFontSize {
    return ^(CGFloat fontSize){
        return [UIFont systemFontOfSize:fontSize];
    };
}

+ (UIFont * _Nonnull (^)(CGFloat))jz_boldSystemFontSize {
    return ^(CGFloat fontSize){
        return [UIFont boldSystemFontOfSize:fontSize];
    };
}

@end

/* <----------------------- UIFont -------------------------------> */


/* <----------------------- UIColor -------------------------------> */

@implementation UIColor (JZExtension)

/**
 快速创建16进制颜色：链式调用.
 @return 颜色.
 */
+ (UIColor * _Nonnull (^)(NSString * _Nonnull))jz_hexColor {
    return ^(NSString *hexColor){
        return [UIColor jz_colorWithHexColor:hexColor];
    };
}
/**
 16进制颜色.
 @param hexValue - 16进制色值.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithHexColor:(NSString *)hexValue {
    if ([hexValue length] <6){//长度不合法
        return UIColor.blackColor;
    }
    NSString *colorString = [[hexValue stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 1];
            green = [self _colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 1];
            red   = [self _colorComponentFrom: colorString start: 1 length: 1];
            green = [self _colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 2];
            green = [self _colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 2];
            red   = [self _colorComponentFrom: colorString start: 2 length: 2];
            green = [self _colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}


+ (CGFloat)_colorComponentFrom:(NSString *)string
                        start:(NSUInteger)start
                       length:(NSUInteger)length {
    unsigned hexComponent;
    @try{
        NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
        NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
        
        [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    }
    @catch(NSException *exception){}
    @finally{}
    return hexComponent / 255.0;
}

/**
 随机颜色.
 @return 颜色.
 */
+ (instancetype)jz_randomColor {
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    CGFloat a = arc4random_uniform(256);
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0];
}

/**
 适配暗黑.
 @param normalColor    - normal颜色.
 @param darkColor      - 暗黑颜色.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithNormalColor:(NSString *)normalColor
                           darkColor:(NSString *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor jz_colorWithHexColor:normalColor];
            }else {
                return [UIColor jz_colorWithHexColor:darkColor];
            }
        }];
        return dyColor;
    } else {
        return [UIColor jz_colorWithHexColor:normalColor];
    }
}

@end

/* <----------------------- UIColor -------------------------------> */

/* <----------------------- UILabel -------------------------------> */

@implementation UILabel (JZExtension)

///hook住setText方法，处理nil的情况
//+ (void)initialize {
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        RSSwizzleInstanceMethod(self,
//                                @selector(setText:),
//                                RSSWReturnType(void),
//                                RSSWArguments(NSString *s),
//                                RSSWReplacement(
//        {
//            NSString *c = s == nil ? @"" : s;
//            RSSWCallOriginal(c);
//        }), 0, NULL);
//    });
//}


/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                       textColor:(UIColor *)textColor {
    
    return [self jz_labelWithText:text textColor:textColor font:[UIFont systemFontOfSize:16.f]];
}

/**
 快速创建label.
 @param textColor   - 文字颜色.
 @param font        - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithTextColor:(UIColor *)textColor
                            font:(UIFont *)font {
    
    return [self jz_labelWithText:nil textColor:textColor font:font];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font {
    
    return [self jz_labelWithText:text textColor:textColor font:font textAlignment:NSTextAlignmentLeft];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @param textAlignment - 文字对齐方式.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment {
    
    return [self jz_labelWithText:text textColor:textColor backgroundColor:nil font:font textAlignment:textAlignment];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @param textAlignment - 文字对齐方式.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment {
    
    return [self jz_labelWithText:text textColor:textColor backgroundColor:backgroundColor font:font textAlignment:textAlignment moreExpanded:NO];
}

/**
 快速创建label.
 @param text              - 文字内容.
 @param textColor         - 文字颜色.
 @param backgroundColor   - 背景颜色.
 @param font              - 字体.
 @param textAlignment     - 文字对齐方式.
 @param moreExpanded      - 文字过长是否不被压缩
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment  moreExpanded:(BOOL)moreExpanded {
    UILayoutPriority layoutPriority = moreExpanded ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh;
    return [self jz_labelWithText:text textColor:textColor backgroundColor:backgroundColor font:font textAlignment:textAlignment contentHuggingPriority:UILayoutPriorityDefaultLow compressionPriority:layoutPriority];
}

/**
 快速创建label.
 @param text                 - 文字内容.
 @param textColor            - 文字颜色.
 @param backgroundColor      - 背景颜色.
 @param font                 - 字体.
 @param textAlignment        - 文字对齐方式.
 @param contentHuggingPriority  - 抗伸缩优先级.
 @param compressionPriority     - 抗压缩优先级.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment  contentHuggingPriority:(UILayoutPriority)contentHuggingPriority compressionPriority:(UILayoutPriority)compressionPriority{
    UILabel *l = UILabel.new;
    l.textColor = textColor;
    if (backgroundColor) {
        l.backgroundColor = backgroundColor;
    }
    l.textAlignment = textAlignment;
    l.font = font;
    l.text = text;
    [l setContentHuggingPriority:contentHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
    [l setContentCompressionResistancePriority:compressionPriority forAxis:UILayoutConstraintAxisHorizontal];
    [l sizeToFit];
    return l;
}


@end

/* <----------------------- UILabel -------------------------------> */


/* <----------------------- UIButton -------------------------------> */

@implementation UIButton (JZExtension)

/**
 快速创建Button.
 @param title             - 标题.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont {
    
    return [self jz_buttonWithTitle:title titleColor:titleColor titleFont:titleFont cornerRadius:0 backgroundColor:nil];
}

/**
 快速创建Button.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @param cornerRadius      - 圆角.
 @param backgroundColor   - 背景色.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont
                   cornerRadius:(CGFloat)cornerRadius
                   backgroundColor:(UIColor *)backgroundColor {
    
    return [self jz_buttonWithTitle:nil titleColor:titleColor titleFont:titleFont cornerRadius:cornerRadius backgroundColor:backgroundColor];
}
/**
 快速创建Button.
 @param title             - 标题.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @param cornerRadius      - 圆角.
 @param backgroundColor   - 背景色.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor {
    
    UIButton *btn = UIButton.new;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
    }
    btn.titleLabel.font = titleFont;
    [btn setBackgroundImage:[UIImage jz_imageWithColor:[UIColor jz_colorWithHexColor:@"#FFD1A6"]] forState:UIControlStateDisabled];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
    if (cornerRadius > 0) {
        btn.layer.cornerRadius = cornerRadius;
        btn.layer.masksToBounds = YES;
    }
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    return btn;
}
/**
 返回带图片的按钮
 @param imageName    图片名称
 @return 按钮
 */
+ (instancetype)jz_buttonWithImageName:(NSString *)imageName {
    
    UIButton *btn = UIButton.new;
    if (!imageName) {
        return btn;
    }
    [btn setBackgroundImage:[UIImage jz_imageWithColor:[UIColor jz_colorWithHexColor:@"#E0E2E9"]] forState:UIControlStateDisabled];
    UIImage *image = [UIImage imageNamed:imageName];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn sizeToFit];
    return btn;
}
/**
 设置按钮图片和标题模式
 @param style        JZButtonEdgeInsetsStyle
 @param space        space - 间距
 */
- (void)jz_layoutButtonWithEdgeInsetsStyle:(JZButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    CGFloat imageWith = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case JZButtonEdgeInsetsStyleImageTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
        }
            break;
        case JZButtonEdgeInsetsStyleImageLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space, 0, space);
            labelEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space);
        }
            break;
        case JZButtonEdgeInsetsStyleImageBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
        }
            break;
        case JZButtonEdgeInsetsStyleImageRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth-space);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end

/* <----------------------- UIButton -------------------------------> */


/* <----------------------- UIImage -------------------------------> */

@implementation UIImage (JZExtension)

/**
 根据颜色返回图片
 @param color     颜色
 @param size      尺寸
 @return 图片
 */
+ (instancetype)jz_imageWithColor:(UIColor *)color {
    
    return [self jz_imageWithColor:color imageSize:CGSizeMake(1.0f, 1.0f)];
}
/**
 根据颜色返回图片
 @param color     颜色
 @param size      尺寸
 @return 图片
 */
+ (instancetype)jz_imageWithColor:(UIColor *)color
                     imageSize:(CGSize)size {

    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

/* <----------------------- UIImage -------------------------------> */


/* <----------------------- UIImageView -------------------------------> */

@implementation UIImageView (JZExtension)

/**
 快速创建UIImageView
 @param imageName  - 图片文件名
 @return UIImageView对象
 */
+ (instancetype)jz_imageWithImageName:(nullable NSString *)imageName {
    if (imageName == nil || !imageName.length) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        return imageView;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}
/**
 快速创建UIImageView
 @param image  - 图片
 @return UIImageView对象
 */
+ (instancetype)jz_imageWithImage:(UIImage *)image {
    if (image == nil) {
        return [UIImageView new];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

@end

/* <----------------------- UIImageView -------------------------------> */


/* <----------------------- UITextField -------------------------------> */

@implementation UITextField (JZExtension)

/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param placeholder      - 占位文字.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                              placeholder:(nullable NSString *)placeholder {
    
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:UIKeyboardTypeDefault placeholder:placeholder];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色
 @param font             - 字体
 @param keyboardType     - 键盘类型
 @param placeholder      - 占位文字
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                              placeholder:(nullable NSString *)placeholder {
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:keyboardType placeholder:placeholder placeholderColor:nil];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色
 @param font             - 字体
 @param keyboardType     - 键盘类型
 @param placeholder      - 占位文字
 @param placeholderColor - 占位文字颜色
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor{
    
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:keyboardType clearButtonMode:UITextFieldViewModeNever placeholder:placeholder placeholderColor:placeholderColor];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色
 @param font             - 字体
 @param keyboardType     - 键盘类型
 @param clearButtonMode  - 清除按钮的样式
 @param placeholder      - 占位文字
 @param placeholderColor - 占位文字颜色
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor {
    return [self jz_textFieldWithTextColor:textColor font:font textAlignment:NSTextAlignmentLeft keyboardType:keyboardType clearButtonMode:clearButtonMode placeholder:placeholder placeholderColor:placeholderColor];
    
}

/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param textAlignment    - 文字对齐方式.
 @param keyboardType     - 键盘类型.
 @param clearButtonMode  - 清除按钮的样式.
 @param placeholder      - 占位文字.
 @param placeholderColor - 占位文字颜色.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                            textAlignment:(NSTextAlignment)textAlignment
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor{
    
    UITextField *customTF = UITextField.new;
    customTF.font = font;
    customTF.textColor =  textColor;
    customTF.keyboardType = keyboardType;
    customTF.textAlignment = textAlignment;
    customTF.placeholder = placeholder;
    customTF.clearButtonMode = clearButtonMode;
    if (!placeholderColor) {
        placeholderColor = [UIColor colorWithRed:182.f green:182.f blue:182.f alpha:1.f];
    }
    [customTF jz_setPlaceholder:placeholder withFont:font fontColor:placeholderColor];
    
    return customTF;
}

- (void)jz_setPlaceholder:(NSString *)placeholder
              withFont:(UIFont *)font
             fontColor:(UIColor *)fontColor {
    placeholder = placeholder == nil ? self.placeholder : placeholder;
    if (placeholder == nil || placeholder.length == 0) {
        return;
    }
    font = font == nil ? self.font : font;
    fontColor = fontColor == nil ? self.textColor : fontColor;
    if (font == nil || fontColor == nil) {
        return;
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: fontColor, NSFontAttributeName: font}];
    
}

@end

/* <----------------------- UITextField -------------------------------> */


/* <----------------------- UIDevice -------------------------------> */

@implementation UIDevice (JZExtension)

+ (CGFloat)safeAreaTopMargin {
    CGFloat m =  [self safeAreaInsets].top;
    return m;
}

+ (CGFloat)safeAreaBottomMargin {
    return [self safeAreaInsets].bottom;
}

+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

@end

/* <----------------------- UIDevice -------------------------------> */

/* <----------------------- UIViewController -----------------------------> */

@implementation UIViewController (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock {
    NSMutableArray *mArray = NSMutableArray.new;
    if (addBlock) {
        mArray = addBlock(mArray);
    }
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self.view addSubview:obj];
        }
    }];
    !layoutBlock?:layoutBlock();
}


@end

/* <----------------------- UIViewController -----------------------------> */
