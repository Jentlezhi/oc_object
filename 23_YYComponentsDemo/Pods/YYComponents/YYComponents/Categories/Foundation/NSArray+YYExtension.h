//
//  NSArray+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YYExtension)

/**
 高阶映射
 @param block       映射函数
 @return            映射之后的新数组
 */
- (NSArray *)yy_map:(id _Nullable (^)(id _Nullable value))block;
/**
 高阶过滤
 @param block       过滤函数
 @return            过滤数据之后的新数组
 */
- (NSArray *)yy_filter:(BOOL (^)(id _Nullable value))block;
/**
 高阶折叠：从左至右，正向遍历
 @param start       起始
 @param reduce      折叠函数
 @return            折叠之后的新内容
 */
- (id)yy_foldLeftWithStart:(id)start
                    reduce:(id (^)(id memo, id each))reduce;
/**
 高阶折叠：从左至右，逆向遍历
 @param start       起始
 @param reduce      折叠函数
 @return            折叠之后的新内容
 */
- (id)yy_foldRightWithStart:(id)start
                            reduce:(id (^)(id memo, id each))reduce;
/**
 遍历
 @param eachBlock   遍历函数
 */
- (void)yy_forEach:(void(^)(id each))eachBlock;
/**
 逆向遍历
 @param eachBlock   遍历函数
 */
- (void)yy_reverseForEach:(void(^)(id each))eachBlock;

@end

NS_ASSUME_NONNULL_END
