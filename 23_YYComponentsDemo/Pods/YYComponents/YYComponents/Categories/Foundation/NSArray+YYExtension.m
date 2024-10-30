//
//  NSArray+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "NSArray+YYExtension.h"

@implementation NSArray (YYExtension)

/**
 高阶映射
 @param block       映射函数
 @return            映射之后的新数组
 */
- (NSArray *)yy_map:(id _Nullable (^)(id _Nullable value))block {
    if (!block) {return self;};
    NSMutableArray *mArray = [NSMutableArray array];
    for (id objc in self) {
        id newValue = block(objc);
        if (newValue){
            [mArray addObject:newValue];
        }
    }
    return mArray.copy;
}
/**
 高阶过滤
 @param block       过滤函数
 @return            过滤数据之后的新数组
 */
- (NSArray *)yy_filter:(BOOL (^)(id _Nullable value))block {
    if (!block) {return self;};
    NSMutableArray *mArray = [NSMutableArray array];
    for (id objc in self) {
        BOOL needInsert = block(objc);
        if (needInsert){
            [mArray addObject:objc];
        }
    }
    return mArray.copy;
}
/**
 高阶折叠：从左至右，正向遍历
 @param start       起始
 @param reduce      折叠函数
 @return            折叠之后的新内容
 */
- (id)yy_foldLeftWithStart:(id)start
                        reduce:(id (^)(id memo, id each))reduce {
    if (!reduce) return start;
    for (id value in self) {
        start = reduce(start, value);
    }
    return start;
}
/**
 高阶折叠：从左至右，逆向遍历
 @param start       起始
 @param reduce      折叠函数
 @return            折叠之后的新内容
 */
- (id)yy_foldRightWithStart:(id)start
                        reduce:(id (^)(id memo, id each))reduce {
    if (!reduce) return start;
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    for (id value in reversedArray) {
        start = reduce(start, value);
    }
    return start;
}
/**
 遍历
 @param eachBlock   遍历函数
 */
- (void)yy_forEach:(void(^)(id each))eachBlock {
    if (!eachBlock) {return;};
    for (id objc in self) {
        eachBlock(objc);
    }
}
/**
 逆向遍历
 @param eachBlock   遍历函数
 */
- (void)yy_reverseForEach:(void(^)(id each))eachBlock {
    if (!eachBlock) {return;};
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    for (id objc in reversedArray) {
        eachBlock(objc);
    }
}
@end
