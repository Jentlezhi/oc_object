//
//  YYLayout.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/09/20.
//

#import "YYLayout.h"
#import <objc/message.h>

const char *YYLAYOUT_MAKER_KEY = "YYLAYOUT_MAKER_KEY";

@implementation YYLayout

static CGFloat _radio = 1.f;

+ (void)setRadio:(CGFloat)radio {
    _radio = radio;
}
+ (CGFloat)radio {
    return _radio;
}
@end

@implementation YYLayoutToItem

+ (instancetype)itemWithItem:(UIView *)item
                   attribute:(NSLayoutAttribute)attribute {
    YYLayoutToItem *layoutToItem = [YYLayoutToItem new];
    layoutToItem.toItem = item;
    layoutToItem.toItemAttribute = attribute;
    return layoutToItem;
}

@end

@interface YYLayoutConstraint : NSObject

@property(nonatomic, weak) id item;
@property(nonatomic, assign) NSLayoutAttribute itemAttribute;
@property(nonatomic, assign) NSLayoutRelation relation;
@property(nonatomic, weak) id toItem;
@property(nonatomic, assign) NSLayoutAttribute toItemAttribute;
@property(nonatomic, assign) CGFloat multiplier;
@property(nonatomic, assign) CGFloat constant;
@property(nonatomic, assign) BOOL preFinishLayout;
@property(nonatomic, assign) BOOL finishLayout;

@end

@implementation YYLayoutConstraint

- (instancetype)init {
    if (self = [super init]) {
        self.itemAttribute = NSLayoutAttributeNotAnAttribute;
        self.relation = NSLayoutRelationEqual;
        self.multiplier = 1.f;
        self.constant = 0.f;
    }
    return self;
}

@end

@interface YYLayoutMaker()

@property(nonatomic, weak) id item;
/// 所有约束，真正的约束对象，与NSLayoutConstraint一一对应
@property(nonatomic, strong) NSMutableArray <YYLayoutConstraint*> *layoutConstraints;
/// 所有约束，NSLayoutConstraint对象
@property(nonatomic, strong) NSMutableArray <NSLayoutConstraint*> *originLayoutConstraints;
/// 所有约束属性
@property(nonatomic, strong) NSMutableArray <NSNumber*> *attributes;

@end

@implementation YYLayoutMaker

///=============================================================================
/// 约束属性
///=============================================================================

- (YYLayoutMaker *)left {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeLeft];
    return self;
}
- (YYLayoutMaker *)right {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeRight];
    return self;
}

- (YYLayoutMaker *)top {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeTop];
    return self;
}

- (YYLayoutMaker *)bottom {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeBottom];
    return self;
}
- (YYLayoutMaker *)width {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeWidth];
    return self;
}
- (YYLayoutMaker *)height {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeHeight];
    return self;
}
- (YYLayoutMaker *)centerX {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeCenterX];
    return self;
}
- (YYLayoutMaker *)centerY {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeCenterY];
    return self;
}
- (YYLayoutMaker *)center {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeCenterX];
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeCenterY];
    return self;
}

- (YYLayoutMaker *)widthAndHeight {
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeWidth];
    [self _addLayoutWithAttributeIfNeedWithAttribute:NSLayoutAttributeHeight];
    return self;
}

///=============================================================================
/// 参考对象
///=============================================================================
- (YYLayoutMaker * _Nonnull (^)(id _Nonnull))equalTo {
    return [self _makeEqualBlockWithRelation:NSLayoutRelationEqual];
}
- (YYLayoutMaker * _Nonnull (^)(void))equalToSuperview {
    return ^(){
        [self _layoutAllWithAttribute:[(UIView*)self.item superview] relation:NSLayoutRelationEqual];
        return self;
    };
}
- (YYLayoutMaker * _Nonnull (^)(id _Nonnull))lessThenOrEqualTo {
    return [self _makeEqualBlockWithRelation:NSLayoutRelationLessThanOrEqual];
}
- (YYLayoutMaker * _Nonnull (^)(void))lessThenOrEqualToSuperview {
    return ^(){
        [self _layoutAllWithAttribute:[(UIView*)self.item superview] relation:NSLayoutRelationLessThanOrEqual];
        return self;
    };
}
- (YYLayoutMaker * _Nonnull (^)(id _Nonnull))greaterThenOrEqualTo {
    return [self _makeEqualBlockWithRelation:NSLayoutRelationGreaterThanOrEqual];
}
- (YYLayoutMaker * _Nonnull (^)(void))greaterThenOrEqualToSuperview {
    return ^(){
        [self _layoutAllWithAttribute:[(UIView*)self.item superview] relation:NSLayoutRelationGreaterThanOrEqual];
        return self;
    };
}
- (YYLayoutMaker * _Nonnull (^)(CGFloat))offset {
    return ^(CGFloat offset) {
        for (YYLayoutConstraint *layoutConstraint in self.layoutConstraints) {
            if (layoutConstraint.finishLayout) {
                continue;
            }
            if (layoutConstraint.constant > 0.f) {
                continue;
            }
            layoutConstraint.constant = offset;
            layoutConstraint.finishLayout = YES;
        }
        return self;
    };
}
- (YYLayoutMaker * _Nonnull (^)(CGFloat))multipliedBy {
    return ^(CGFloat multiplier) {
        for (YYLayoutConstraint *layoutConstraint in self.layoutConstraints) {
            if (layoutConstraint.finishLayout) {
                continue;
            }
            layoutConstraint.multiplier = multiplier;
            layoutConstraint.finishLayout = YES;
        }
        return self;
    };
}

- (void (^)(CGFloat))yy_equalTo {
    return [self _equalToBlockWithRelation:NSLayoutRelationEqual];
}
- (void (^)(CGFloat))yy_lessThenOrEqualTo {
    return [self _equalToBlockWithRelation:NSLayoutRelationLessThanOrEqual];
}
- (void (^)(CGFloat))yy_greaterThenOrEqualTo {
    return [self _equalToBlockWithRelation:NSLayoutRelationGreaterThanOrEqual];
}

#pragma mark - Methods
- (CGFloat)value:(CGFloat)value {
    return value*YYLayout.radio;
}

- (void)_addLayoutWithAttributeIfNeedWithAttribute:(NSLayoutAttribute)attribute {
    BOOL layoutInside = NO;
    //如果之前的布局已经完成，或者已经执行了equalTo方法，则置为已完成
    for (YYLayoutConstraint *constraint in self.layoutConstraints) {
        if (constraint.itemAttribute == attribute) {
            layoutInside = YES;
        }
        //此处作为判断一行make的结束，另一行make的的执行
        if (constraint.preFinishLayout) {
            constraint.finishLayout = YES;
        }
    }
    ///未添加过约束，生成YYLayoutConstraint对象
    if (layoutInside == NO) {
        YYLayoutConstraint *newLayoutConstraint = [YYLayoutConstraint new];
        newLayoutConstraint.item = self.item;
        newLayoutConstraint.itemAttribute = attribute;
        [self.attributes addObject:@(newLayoutConstraint.itemAttribute)];
        [self.layoutConstraints addObject:newLayoutConstraint];
    }
}
/**
 对所有保存的布局对象布局
 */
- (void)makeLayout {
    UIView *item = (UIView *)self.item;
    UIView *superview = [item superview];
    if (superview == nil){return;}
    item.translatesAutoresizingMaskIntoConstraints = NO;
//    NSMutableArray *removedArray = @[].mutableCopy;
//    for (NSLayoutConstraint *layoutConstraint in superview.constraints) {
//        if (layoutConstraint.firstItem == item) {
//            [removedArray addObject:layoutConstraint];
//        }
//    }
//    [NSLayoutConstraint deactivateConstraints:removedArray];
    for (YYLayoutConstraint *layoutConstraint in self.layoutConstraints) {
        [self addNewLayoutWithLayoutConstraint:layoutConstraint];
    }
}
/**
 更新约束
 */
- (void)updateLayoutWithOldLayoutConstraints:(NSArray <YYLayoutConstraint*> *)oldLayoutConstraints
                  oldOriginLayoutConstraints:(NSArray <NSLayoutConstraint*> *)oldOriginLayoutConstraints
                               oldAttributes:(NSArray <NSNumber*>*)oldAttributes {
    
    NSArray <NSNumber*>*newAttributes = self.attributes;
//    //如果新的约束属性不在旧约束属性中，那么就无法更新
//    NSSet *newAttributesSet = [NSSet setWithArray:newAttributes];
//    NSSet *oldAttributesSet = [NSSet setWithArray:oldAttributes];
//    if (![newAttributesSet isSubsetOfSet:oldAttributesSet]) {
//        NSCAssert(false, @"找不到旧的约束，无法更新！");
//        return;
//    }
    NSMutableArray *addLayoutConstraints = @[].mutableCopy;
    for (YYLayoutConstraint *oldLayoutConstraint in oldLayoutConstraints) {
        if (![newAttributes containsObject:@(oldLayoutConstraint.itemAttribute)]) {
            [addLayoutConstraints addObject:oldLayoutConstraint];
        }
    }
    ///同步attributes的数据
    self.attributes = oldAttributes.mutableCopy;
    [self.layoutConstraints addObjectsFromArray:addLayoutConstraints];
    ///移除所有旧约束
    for (NSLayoutConstraint *constraint  in oldOriginLayoutConstraints) {
        UIView *superview = [(UIView *)self.item superview];
        [superview removeConstraint:constraint];
    }
}
/**
 添加新约束
 @param layoutConstraint     约束关系
 */
- (void)addNewLayoutWithLayoutConstraint:(YYLayoutConstraint*)layoutConstraint {
    UIView *superview = [(UIView *)self.item superview];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:layoutConstraint.item attribute:layoutConstraint.itemAttribute relatedBy:layoutConstraint.relation toItem:layoutConstraint.toItem attribute:layoutConstraint.toItemAttribute multiplier:layoutConstraint.multiplier constant:[self value:layoutConstraint.constant]];
    //等价于[self.originLayoutConstraints addObject:constraint]
//    constraint.active = YES;
    [self.originLayoutConstraints addObject:constraint];
    [superview addConstraint:constraint];
}
/**
 重置数据
 */
- (void)resetData {
    [self.layoutConstraints removeAllObjects];
    [self.originLayoutConstraints removeAllObjects];
    [self.attributes removeAllObjects];
}

/**
 统一代码，根据relation生产block
 */
- (YYLayoutMaker *(^)(id))_makeEqualBlockWithRelation:(NSLayoutRelation)relation {
    return ^(id attr) {
        [self _layoutAllWithAttribute:attr relation:relation];
        return self;
    };
}
- (void)_layoutAllWithAttribute:(id)attr
                       relation:(NSLayoutRelation)relation {
    for (YYLayoutConstraint *layoutConstraint in self.layoutConstraints) {
        if (layoutConstraint.finishLayout) {
            continue;
        }
        if (layoutConstraint.toItem) {
            continue;
        }
        if ([attr isKindOfClass:YYLayoutToItem.class]) {
            YYLayoutToItem *toItem = (YYLayoutToItem*)attr;
            layoutConstraint.toItem = toItem.toItem;
            layoutConstraint.toItemAttribute = toItem.toItemAttribute;
            layoutConstraint.relation = relation;
            layoutConstraint.preFinishLayout = YES;
        } else if ([attr isKindOfClass:UIView.class]) {
            layoutConstraint.toItem = attr;
            layoutConstraint.toItemAttribute = layoutConstraint.itemAttribute;
            layoutConstraint.relation = relation;
            layoutConstraint.preFinishLayout = YES;
        } else if ([attr isKindOfClass:NSNumber.class]) {
            CGFloat constant = [(NSNumber*)attr floatValue];
            layoutConstraint.toItem = nil;
            layoutConstraint.toItemAttribute = NSLayoutAttributeNotAnAttribute;
            layoutConstraint.relation = relation;
            layoutConstraint.constant = constant;
            layoutConstraint.finishLayout = YES;
        }
    }
}

- (void(^)(CGFloat))_equalToBlockWithRelation:(NSLayoutRelation)relation {
    return ^(CGFloat offet) {
        for (YYLayoutConstraint *layoutConstraint in self.layoutConstraints) {
            if (layoutConstraint.finishLayout) {
                continue;
            }
            if (layoutConstraint.itemAttribute == NSLayoutAttributeWidth || layoutConstraint.itemAttribute == NSLayoutAttributeHeight) {
                layoutConstraint.toItem = nil;
                layoutConstraint.toItemAttribute = NSLayoutAttributeNotAnAttribute;
                layoutConstraint.constant = offet;
                layoutConstraint.relation = relation;
                layoutConstraint.finishLayout = YES;
            } else {
                layoutConstraint.toItem = [(UIView *)self.item superview];
                layoutConstraint.toItemAttribute = layoutConstraint.itemAttribute;
                layoutConstraint.constant = offet;
                layoutConstraint.relation = relation;
                layoutConstraint.finishLayout = YES;
            }
        }
    };
}

#pragma mark - Lazy load
- (NSMutableArray<YYLayoutConstraint *> *)layoutConstraints {
    if (!_layoutConstraints) {
        _layoutConstraints = @[].mutableCopy;
    }
    return _layoutConstraints;
}
- (NSMutableArray<NSLayoutConstraint *> *)originLayoutConstraints {
    if (!_originLayoutConstraints) {
        _originLayoutConstraints = @[].mutableCopy;
    }
    return _originLayoutConstraints;
}
- (NSMutableArray<NSNumber *> *)attributes {
    if (!_attributes) {
        _attributes = @[].mutableCopy;
    }
    return _attributes;
}
@end

@implementation UIView (YYLayout)

- (YYLayoutToItem *)yy_top {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeTop];
}
- (YYLayoutToItem *)yy_bottom {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeBottom];
}
- (YYLayoutToItem *)yy_left {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeLeft];
}
- (YYLayoutToItem *)yy_right {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeRight];
}
- (YYLayoutToItem *)yy_centerX {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeCenterX];
}
- (YYLayoutToItem *)yy_centerY {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeCenterY];
}
- (YYLayoutToItem *)yy_width {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeWidth];
}
- (YYLayoutToItem *)yy_height {
    return [YYLayoutToItem itemWithItem:self attribute:NSLayoutAttributeHeight];
}
- (YYLayoutToItem *)yy_center {
    ///这里强转为了消除警告，内部判断了真实类型
    return (YYLayoutToItem *)self;
}

- (void)yy_makeLayout:(void (^)(YYLayoutMaker * _Nonnull))layout {
    if (layout) {
        //couldn't find a common superview
        NSCAssert(self.superview != nil, @"找不到父视图，请先添加视图之后再添加约束！");
        YYLayoutMaker *maker = [YYLayoutMaker new];
        objc_setAssociatedObject(self, YYLAYOUT_MAKER_KEY, maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [maker setValue:self forKey:@"item"];
        layout(maker);
        [maker makeLayout];
    }
}

- (void)yy_remakeLayout:(void (^)(YYLayoutMaker * _Nonnull))layout {
    if (layout) {
        YYLayoutMaker *maker = objc_getAssociatedObject(self, YYLAYOUT_MAKER_KEY);
        if (maker) {
            ///移除旧约束
            [NSLayoutConstraint deactivateConstraints:maker.originLayoutConstraints];
//            for (NSLayoutConstraint *constraint  in maker.originLayoutConstraints) {
//                [self.superview removeConstraint:constraint];
//            }
            ///重置数据
            [maker resetData];
            ///添加新约束
            [self yy_makeLayout:layout];
        }else {
            [self yy_makeLayout:layout];
        }
    }
}
- (void)yy_updateLayout:(void (^)(YYLayoutMaker * _Nonnull))layout {
    if (layout) {
        YYLayoutMaker *maker = objc_getAssociatedObject(self, YYLAYOUT_MAKER_KEY);
        NSArray *oldLayoutConstraints = maker.layoutConstraints.copy;
        NSArray *oldOriginLayoutConstraints = maker.originLayoutConstraints.copy;
        NSArray *oldAttributes = maker.attributes.copy;
        ///删除旧约束数据
        [maker resetData];
        if (maker) {
            layout(maker);
            ///更新约束数据
            [maker updateLayoutWithOldLayoutConstraints:oldLayoutConstraints oldOriginLayoutConstraints:oldOriginLayoutConstraints oldAttributes:oldAttributes];
            ///重新约束
            [maker makeLayout];
        }
    }
}
/**
 移除某个属性的约束
 @param attribute      约束属性
 */
- (void)yy_removeConstraint:(NSLayoutAttribute)attribute {
    [self yy_removeConstraints:@[@(attribute)]];
}
/**
 移除某些属性的约束
 @param attributes      约束属性数组
 */
- (void)yy_removeConstraints:(NSArray <NSNumber*>*)attributes {
    YYLayoutMaker *maker = objc_getAssociatedObject(self, YYLAYOUT_MAKER_KEY);
    if (!maker) {return;}
    UIView *superView = self.superview;
    [self removeFromSuperview];
    NSMutableArray <YYLayoutConstraint*> *tempOriginLayoutConstraints = @[].mutableCopy;
    for (YYLayoutConstraint *layoutConstraint in maker.layoutConstraints) {
        if ([attributes containsObject:@(layoutConstraint.itemAttribute)]) {
            [tempOriginLayoutConstraints addObject:layoutConstraint];
        }
    }
    [maker.layoutConstraints removeObjectsInArray:tempOriginLayoutConstraints];
    [maker.originLayoutConstraints removeAllObjects];
    [maker.attributes removeAllObjects];
    [superView addSubview:self];
    [maker makeLayout];
}

@end

