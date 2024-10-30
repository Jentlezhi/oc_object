//
//  NSString+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YYExtension)

/**
 字符串拼接，链式调用
 用法：
 1.对于常量字符串，直接调用yy_append
   @"abc".yy_append(@"def");
 2.对于变量，使用之前要判空
   NSString *text = xxx;
   NSString.yy_avoidNil(text).yy_append(@"a").yy_append(@"b").yy_append(@"c"));
 */
@property(nonatomic, copy, readonly) NSString *(^yy_append)(NSString *_Nullable text);
/**
 判断字符串是否为空
 */
@property(nonatomic, copy, class, readonly) BOOL (^yy_isEmpty)(NSString *_Nullable text);

/**
 判断字符串是否为非空
 */
@property(nonatomic, copy, class, readonly) BOOL (^yy_isNotEmpty)(NSString *_Nullable text);

/**
 字符串nil返回默认值
 */
@property(nonatomic, copy, class, readonly) NSString *(^yy_ifNilSetDefaultValue)(NSString *_Nullable text, NSString * _Nonnull defaultValue);
/**
 字符串避免nil
 */
@property(nonatomic, copy, class, readonly) NSString *(^yy_avoidNil)(NSString *_Nullable text);

@end

NS_ASSUME_NONNULL_END
