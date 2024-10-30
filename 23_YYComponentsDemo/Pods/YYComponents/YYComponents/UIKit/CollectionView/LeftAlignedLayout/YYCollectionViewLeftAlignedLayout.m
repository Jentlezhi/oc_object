//
//  YYCollectionViewLeftAlignedLayout.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/18.
//

#import "YYCollectionViewLeftAlignedLayout.h"

@interface YYCollectionViewLeftAlignedLayoutAttributeModel : NSObject

@property(nonatomic, assign) NSInteger index;
@property(nonatomic, assign) CGFloat width;

@end

@implementation YYCollectionViewLeftAlignedLayoutAttributeModel
+ (instancetype)attributeWithIndex:(int)index width:(float)width {
    YYCollectionViewLeftAlignedLayoutAttributeModel * attribute = [YYCollectionViewLeftAlignedLayoutAttributeModel new];
    attribute.index = index;
    attribute.width = width;
    return attribute;
}

@end

@interface YYCollectionViewLeftAlignedLayout()

@end

@implementation YYCollectionViewLeftAlignedLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] copy];
    NSMutableArray *subArray = [self groupTheSameLineItems:attributes];
    [self leftAlignUpdateItemAttributeInSigleLine:subArray];
    return attributes;
}

- (void)leftAlignUpdateItemAttributeInSigleLine:(NSMutableArray * )groupArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSArray *array  in groupArray) {
        NSInteger count = array.count;
        if (!count) {
            continue;
        }
        for (int i = 0; i < count; i++) {
            UICollectionViewLayoutAttributes *attrOne = array[i];
            [modelArray addObject:[YYCollectionViewLeftAlignedLayoutAttributeModel attributeWithIndex:i width:attrOne.size.width]];
        }
        CGFloat originX = 0;
        for (int i = 0; i < count; i++) {
            UICollectionViewLayoutAttributes *attr = [array objectAtIndex:i];
            NSPredicate *predice =[NSPredicate predicateWithFormat:@"index < %d",i];
            NSArray *resultArray = [modelArray filteredArrayUsingPredicate:predice];
            NSNumber *number = [resultArray valueForKeyPath:@"@sum.width"];
            originX = self.leftMargin + self.itemMargin * i + number.doubleValue;
            CGRect frame = attr.frame;
            frame.origin.x = originX;
            attr.frame = frame;
        }
        [modelArray removeAllObjects];
    }
}

- (NSMutableArray *)groupTheSameLineItems:(NSArray *)attributes {
    NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:attributes.count];
    NSMutableArray *currenArray = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (int i = 0; i < [attributes count]; i++) {
        UICollectionViewLayoutAttributes *attr = [attributes objectAtIndex:i];
        //当类型为UICollectionElementKindCell时，修改布局
        if (attr.representedElementKind==nil) {
            UICollectionViewLayoutAttributes *lastAttr = [currenArray firstObject];
            if (lastAttr && lastAttr.frame.origin.y != attr.frame.origin.y) {
                [subArray addObject:[NSArray arrayWithArray:currenArray]];
                [currenArray removeAllObjects];
            }
            [currenArray addObject:attr];
        }
    }
    if (currenArray.count) {
        [subArray addObject:[NSArray arrayWithArray:currenArray]];
        [currenArray removeAllObjects];
    }
    return subArray;
}


@end
