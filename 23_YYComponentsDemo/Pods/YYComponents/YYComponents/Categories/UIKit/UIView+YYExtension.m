//
//  UIView+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UIView+YYExtension.h"
#import <objc/runtime.h>
#import <YYComponents/YYFoundationExtension.h>
#import <Masonry/Masonry.h>

const char *YYTAPACTIONKEY = "YYTAPACTIONKEY";

const char *YYVIEWCONFIGKEY = "YYVIEWCONFIGKEY";

@implementation YYViewConfig

- (instancetype)init {
    if (self = [super init]) {
//        self.backgroundColor = UIColor.clearColor;
        self.hidden = NO;
    }
    return self;
}

@end

@implementation UIView (YYExtension)

/**
 移除所有子视图
 */
- (void)yy_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

+ (instancetype)yy_viewWithConfig:(void(^)(YYViewConfig *config))configBlock {
    YYViewConfig *config = [YYViewConfig new];
    !configBlock?:configBlock(config);
    UIView *v = [self new];
    ///存储config
    objc_setAssociatedObject(v, YYVIEWCONFIGKEY, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (config.backgroundColor) {
        v.backgroundColor = config.backgroundColor;
    }
    if (config.cornerRaduis > 0) {
        v.layer.cornerRadius = config.cornerRaduis;
        v.layer.masksToBounds = YES;
    }
    if (config.borderColor && config.borderWidth > 0) {
        v.layer.borderColor = config.borderColor.CGColor;
        v.layer.borderWidth = config.borderWidth;
    }
    v.hidden = config.hidden;
    return v;
}

/**
 添加点击事件
 @param tapBlock     点击动作
 */
- (void)yy_addTapAction:(void(^)(void))tapBlock {
    if (tapBlock == nil) {return;}
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_yy_tapAction)];
    objc_setAssociatedObject(self, YYTAPACTIONKEY, tapBlock, OBJC_ASSOCIATION_COPY);
    [self addGestureRecognizer:tap];
}

- (void)_yy_tapAction {
    void(^tapBlock)(void) = objc_getAssociatedObject(self, YYTAPACTIONKEY);
    if (tapBlock) {
        tapBlock();
    }
}

/**
 布局子视图
 @param direction      布局方向
 @param itemNumber     数量
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_addSubviewsWithDirection:(YYLayoutSubviewsDirection)direction
                         itemNumber:(NSInteger)itemNumber
                     itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                        itemSpacing:(CGFloat)itemSpacing
                          itemBuild:(nonnull UIView * (^)(NSInteger index))itemBuild {
    ///构建子视图为nil，直接返回
    if (itemBuild == nil){return;}
    UIView *superView = self;
    ///先移除旧视图
    if (superView.subviews.count > 0){
        [superView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    ///间距
    CGFloat leftSpacing = itemEdgeInsets.left;
    CGFloat rightSpacing = itemEdgeInsets.right;
    CGFloat topSpacing = itemEdgeInsets.top;
    CGFloat bottomSpacing = itemEdgeInsets.bottom;
    BOOL horizontal = (direction == YYLayoutSubviewsHorizontal);
    ///添加新的视图
    for (NSInteger index = 0; index < itemNumber; index ++) {
        UIView *itemView = itemBuild(index);
        if (itemView == nil) {continue;}
        ///取前一个视图
        UIView *preItemView = nil;
        if (index >= 1 && index <= itemNumber - 1) {
            preItemView = [superView.subviews objectAtIndex:index - 1];
        }
        [superView addSubview:itemView];
        if (horizontal){
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView) {
                    make.left.equalTo(preItemView.mas_right).offset(itemSpacing);
                } else {
                    make.left.mas_equalTo(leftSpacing);
                }
                make.top.mas_equalTo(topSpacing);
                make.bottom.mas_equalTo(-bottomSpacing);
                if (index == (itemNumber - 1)) {
                    make.right.mas_equalTo(-rightSpacing);
                }
            }];
        }else{///纵向
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView) {
                    make.top.equalTo(preItemView.mas_bottom).offset(itemSpacing);
                } else {
                    make.top.mas_equalTo(topSpacing);
                }
                make.left.mas_equalTo(leftSpacing);
                make.right.mas_equalTo(-rightSpacing);
                if ([self isKindOfClass:[UIScrollView class]]) {
                    make.width.mas_equalTo(self.mas_width).offset(-(leftSpacing + rightSpacing));
                }
                if (index == (itemNumber - 1)) {
                    make.bottom.mas_equalTo(-bottomSpacing);
                }
            }];
        }
    }
}

+ (NSString *)yy_classIdentifier {
    return NSStringFromClass([self class]);;
}
/**
 设置指定方向圆角
 @param size         尺寸
 @param corners      方向
 @param cornerRadii  圆角
 */
- (void)yy_setCornerWithSize:(CGSize)size
            byRoundingCorners:(UIRectCorner)corners
                  cornerRadii:(CGSize)cornerRadii {
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/**
 生成一个和该对象特征一样的对象，仅限YYViewConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy {
    return [self yy_copyWithConfig:nil];
}
/**
 生成一个和该对象特征一样的对象，仅限YYViewConfig中的属性
 @param configBlock      配置block
 @return                 新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYViewConfig *config))configBlock {
    YYViewConfig *currentConfig = objc_getAssociatedObject(self, YYVIEWCONFIGKEY);
    UIView *v = [[self class] yy_viewWithConfig:^(YYViewConfig * _Nonnull config) {
        [currentConfig yy_setAllPropertiesValueToModel:config];
        //如果外界想额外修改config的其他的属性，则回调出去
        if (configBlock) {
            configBlock(config);
        }
    }];
    return v;
}
/**
 添加网格视图
 @param itemNumber       格子数量
 @param numberOfColumns  每行显示个数
 @param contentInsets    内边距
 @param itemSpacingH     格子水平方向间距
 @param itemSpacingV     格子垂直方向间距
 @param itemBuild        格子内容
 */
- (void)yy_addGridSubviewsWithItemNumber:(NSUInteger)itemNumber
                         numberOfColumns:(NSUInteger)numberOfColumns
                          contentInsets:(UIEdgeInsets)contentInsets
                            itemSpacingH:(CGFloat)itemSpacingH
                            itemSpacingV:(CGFloat)itemSpacingV
                               itemBuild:(nonnull UIView* (^)(NSInteger index))itemBuild {
    if (itemBuild == nil) {return;}
    UIView *superview = self;
    CGFloat leftMargin = contentInsets.left;
    CGFloat rightMargin = contentInsets.right;
    CGFloat topMargin = contentInsets.top;
    CGFloat bottomMargin = contentInsets.bottom;
    for (NSInteger index = 0; index < itemNumber; index++) {
        UIView *view = itemBuild(index);
        if (view == nil){continue;}
        if (![superview.subviews containsObject:view]) {
            [superview addSubview:view];
        }
        NSArray *subviews = superview.subviews;
        UIView *topRefView;
        if (index >= numberOfColumns) {
            topRefView = subviews[index - numberOfColumns];
        }
        NSInteger leftRefIndex = index % numberOfColumns == 0 ? -1 : (index - 1);
        UIView *leftRefView;
        if (leftRefIndex >= 0) {
            leftRefView = subviews[leftRefIndex];
        }
        ///复用时，避免约束冲突
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (leftRefView) {
                make.left.equalTo(leftRefView.mas_right).offset(itemSpacingH);
            } else {
                make.left.mas_equalTo(leftMargin);
            }
            if (topRefView) {
                make.top.equalTo(topRefView.mas_bottom).offset(itemSpacingV);
            }else{
                make.top.mas_equalTo(topMargin);
            }
            make.width.equalTo(superview.mas_width).multipliedBy(1.f/numberOfColumns).offset(-(leftMargin + rightMargin + (numberOfColumns - 1)*itemSpacingH)/numberOfColumns);
            if (index == itemNumber - 1) {
                make.bottom.mas_equalTo(-bottomMargin);
            }
        }];
    }
}
/**
 平分布局[保证视图的宽高已知]
 @param direction      布局方向
 @param itemNumber     数量
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_distributeSubViewsWithDirection:(YYLayoutSubviewsDirection)direction
                                itemNumber:(NSInteger)itemNumber
                            itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                               itemSpacing:(CGFloat)itemSpacing
                                 itemBuild:(nonnull UIView * (^)(NSInteger index))itemBuild {
    NSMutableArray *itemWeights = @[].mutableCopy;
    for (NSInteger index = 0; index < itemNumber; index++) {
        [itemWeights addObject:@(1)];
    }
    [self yy_distributeSubViewsWithDirection:direction itemWeights:itemWeights itemEdgeInsets:itemEdgeInsets itemSpacing:itemSpacing itemBuild:itemBuild];
//    ///构建子视图为nil，直接返回
//    if (itemBuild == nil){return;}
//    UIView *superView = self;
//    ///先移除旧视图
//    if (superView.subviews.count > 0){
//        [superView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    }
//    ///间距
//    CGFloat leftSpacing = itemEdgeInsets.left;
//    CGFloat rightSpacing = itemEdgeInsets.right;
//    CGFloat topSpacing = itemEdgeInsets.top;
//    CGFloat bottomSpacing = itemEdgeInsets.bottom;
//    BOOL horizontal = (direction == YYLayoutSubviewsHorizontal);
//    ///如果仅有一个子视图
//    if (itemNumber == 1) {
//        UIView *itemView = itemBuild(0);
//        if (itemView == nil) {return;}
//        [superView addSubview:itemView];
//        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(superView);
//        }];
//        return;
//    }
//    ///如果有多个视图
//    for (NSInteger index = 0; index < itemNumber; index ++) {
//        UIView *itemView = itemBuild(index);
//        if (itemView == nil) {continue;}
//        ///取前一个视图
//        UIView *preItemView = nil;
//        if (index >= 1 && index <= itemNumber - 1) {
//            preItemView = [superView.subviews objectAtIndex:index - 1];
//        }
//        [superView addSubview:itemView];
//        if (horizontal){
//            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (preItemView) {
//                    make.left.equalTo(preItemView.mas_right).offset(itemSpacing);
//                } else {
//                    make.left.mas_equalTo(leftSpacing);
//                }
//                make.top.mas_equalTo(topSpacing);
//                make.bottom.mas_equalTo(-bottomSpacing);
//                make.width.equalTo(self.mas_width).dividedBy(itemNumber).offset(-(leftSpacing + rightSpacing + (itemNumber - 1)*itemSpacing)/itemNumber*1.0);
//            }];
//        }else{///纵向
//            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (preItemView) {
//                    make.top.equalTo(preItemView.mas_bottom).offset(itemSpacing);
//                } else {
//                    make.top.mas_equalTo(topSpacing);
//                }
//                make.left.mas_equalTo(leftSpacing);
//                make.right.mas_equalTo(-rightSpacing);
//                if ([self isKindOfClass:[UIScrollView class]]) {
//                    make.width.mas_equalTo(self.mas_width).offset(-(leftSpacing + rightSpacing));
//                }
//                make.height.equalTo(self.mas_height).dividedBy(itemNumber).offset(-(topSpacing + bottomSpacing + (itemNumber - 1)*itemSpacing)/itemNumber*1.0);
//            }];
//        }
//    }
}
/**
 平分布局[保证视图的宽高已知]，支持设置item权重
 @param direction      布局方向
 @param itemWeights    子视图所占的权重
 @param itemEdgeInsets 间距
 @param itemSpacing    子视图间距
 @param itemBuild      创建子视图
 */
- (void)yy_distributeSubViewsWithDirection:(YYLayoutSubviewsDirection)direction
                               itemWeights:(NSArray <NSNumber*> *)itemWeights
                            itemEdgeInsets:(UIEdgeInsets)itemEdgeInsets
                               itemSpacing:(CGFloat)itemSpacing
                                 itemBuild:(nonnull UIView * (^)(NSInteger index))itemBuild {
    ///构建子视图为nil，直接返回
    if (itemBuild == nil || itemWeights.count == 0){return;}
    UIView *superView = self;
    ///先移除旧视图
    if (superView.subviews.count > 0){
        [superView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    ///item数量
    NSInteger itemNumber = itemWeights.count;
    ///item比例总和
    CGFloat totalWeights = [[itemWeights valueForKeyPath:@"@sum.floatValue"] floatValue];
    ///间距
    CGFloat leftSpacing = itemEdgeInsets.left;
    CGFloat rightSpacing = itemEdgeInsets.right;
    CGFloat topSpacing = itemEdgeInsets.top;
    CGFloat bottomSpacing = itemEdgeInsets.bottom;
    BOOL horizontal = (direction == YYLayoutSubviewsHorizontal);
    ///如果仅有一个子视图
    if (itemNumber == 1) {
        UIView *itemView = itemBuild(0);
        if (itemView == nil) {return;}
        [superView addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(itemEdgeInsets);
        }];
        return;
    }
    ///如果有多个视图
    for (NSInteger index = 0; index < itemNumber; index ++) {
        CGFloat itemRatio = [itemWeights[index] floatValue]/totalWeights;
        UIView *itemView = itemBuild(index);
        if (itemView == nil) {continue;}
        ///取前一个视图
        UIView *preItemView = nil;
        if (index >= 1 && index <= itemNumber - 1) {
            preItemView = [superView.subviews objectAtIndex:index - 1];
        }
        [superView addSubview:itemView];
        if (horizontal){///水平布局
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView) {
                    make.left.equalTo(preItemView.mas_right).offset(itemSpacing);
                } else {
                    make.left.mas_equalTo(leftSpacing);
                }
                make.top.mas_equalTo(topSpacing);
                make.bottom.mas_equalTo(-bottomSpacing);
                if ([self isKindOfClass:[UIScrollView class]]) {
                    make.height.mas_equalTo(self.mas_height).offset(-(topSpacing + bottomSpacing));
                }
                /*
                 布局核心：item的宽度按照设定的比例设定
                 (width - (left + right + (n - 1)*space))*(itemRatio/totalRatio)
                 转为width*(itemRatio/totalRatio)-(left + right + (n - 1)*space)*(itemRatio/totalRatio)
                 */
                make.width.equalTo(self.mas_width).multipliedBy(itemRatio).offset(-(leftSpacing + rightSpacing + (itemNumber - 1)*itemSpacing)*itemRatio);
            }];
        }else{///纵向
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (preItemView) {
                    make.top.equalTo(preItemView.mas_bottom).offset(itemSpacing);
                } else {
                    make.top.mas_equalTo(topSpacing);
                }
                make.left.mas_equalTo(leftSpacing);
                make.right.mas_equalTo(-rightSpacing);
                if ([self isKindOfClass:[UIScrollView class]]) {
                    make.width.mas_equalTo(self.mas_width).offset(-(leftSpacing + rightSpacing));
                }
                /*
                 布局核心：同水平布局
                 */
                make.height.equalTo(self.mas_height).multipliedBy(itemRatio).offset(-(topSpacing + bottomSpacing + (itemNumber - 1)*itemSpacing)*itemRatio);
            }];
        }
    }
}

@end
