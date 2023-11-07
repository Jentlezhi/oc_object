//
//  JZFoundationExtension.h
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JZDateFormatTypeY_M_D,//yyyy-MM-dd
    JZDateFormatTypeY_M_DHMS,//yyyy-MM-dd HH:mm:ss
} JZDateFormatType;

/* <----------------------- NSObject -------------------------------> */

@interface NSObject (JZExtension)
/**
 把一个模型中的所有值赋值给该模型
 @param model          - 模型
 @param setNilValue    - 是否赋值空值
 */
- (void)jz_setModelValueWithModel:(id)model
                      setNilValue:(BOOL)setNilValue;
/**
 把一个模型中的所有值赋值给该模型
 @param model    - 模型
 */
- (void)jz_setModelValueWithModel:(id)model;
/**
 模型赋值-简单的设置对应key的值
 @param data    - 数据
 */
- (void)jz_setModelValueWithData:(id)data;
/**
 字典数组转模型数组.
 @param json - 字典数组.
 @return 模型数组.
 */
+ (NSArray *)jz_modelArrayWithKeyValuesArray:(id _Nullable)json;

/**
 字典转模型.
 @param json - 字典.
 @return 模型.
 */
+ (instancetype)jz_modelWithJSON:(id _Nullable)json;

/**
 模型转字典
 @return 字典
 */
@property(copy, nonatomic, readonly) NSDictionary *jz_keyValues;
/**
 对象转字符串[转换失败返回空字符串]
 @return 字符串
 */
- (NSString * _Nullable)jz_toString;

@end

/* <----------------------- NSObject -------------------------------> */


/* <----------------------- NSString -------------------------------> */

@interface NSString (JZExtension)

/**
 int转NSString.
 @param intValue  - int值
 @return 转换后的字符串
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_contentWithInt)(int intValue);
/**
 integer转NSString.
 @param intValue  - integer值
 @return 转换后的字符串
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_contentWithInteger)(NSInteger integerValue);
/**
 float转NSString
 @param floatValue     - float值
 @param decimalPlaces  - 精确位数(1-6位)
 @return 转换后的字符串
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_contentWithFloat)(float floatValue, int decimalPlaces);
/**
 double转NSString
 @param doubleValue    - double值
 @param decimalPlaces  - 精确位数(1-6位)
 @return 转换后的字符串
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_contentWithDouble)(double doubleValue, int decimalPlaces);

/**
 拼接字符串.
 @param str  - 新字符串.
 @return 拼接后的字符串.
 */
@property(copy, nonatomic, readonly) NSString* (^jz_append)(NSString *str);

/**
 判断字符串是否为空(nil/空字符串).
 @param str  - 字符串.
 @return 是否为空.
 */
@property(copy, nonatomic, readonly, class) BOOL (^jz_isEmpty)(NSString * _Nullable str);

/**
 判断字符串是否为非空.
 @param str  - 字符串.
 @return 是否为非空.
 */
@property(copy, nonatomic, readonly ,class) BOOL (^jz_isNotEmpty)(NSString * _Nullable str);

/**
 判断字符串是否相等.
 @param str  - 字符串.
 @return 是否相等.
 */
@property(copy, nonatomic, readonly) BOOL (^jz_isEqual)(NSString * _Nullable str);

/**
 守护字符串安全，非空.
 @param str  - 字符串.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_guard)(NSString * _Nullable value);
/**
 非空返回该值，空返回默认值.
 @param value    - 字符串.
 @param defaultValue  - 默认值.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_valueAndDefaultValue)(NSString * _Nullable value,NSString * _Nullable defaultValue);
/**
 解析id类型的为字符串，不可解析的情况返回空字符串.
 @param value    - id类型.
 @return 返回字符串.
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_parse)(id _Nullable value);

/**
 随机英文字符串.
 @param length  - 字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomLetters)(int length);
/**
 随机英文字符串.
 @param min  - 最小字符串长度.
 @param max  - 最大字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomRangedLetters)(int min, int max);

/**
 随机中文字符串.
 @param length  - 字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomChineseLetters)(int length);
/**
 随机中文字符串.
 @param min  - 最小字符串长度.
 @param max  - 最大字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomRangedChineseLetters)(int min, int max);
/**
 首字母大写.
 @return 首字母大写的新字符串.
 */
@property(copy, nonatomic, readonly) NSString *jz_capitalizedFirstLatter;
/**
 根据时间串返回NSDate
 @return NSDate
 */
- (NSDate *)jz_toDate;
/**
 根据时间串返回NSDate
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSDate *)jz_toDateWithFormatType:(JZDateFormatType)type;
/**
 根据时间串返回NSDate
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSDate *)jz_toDateWithFormat:(NSString *)formatString;
/**
 比较日期的早晚，仅仅比较2022-09-01格式的日期
 @param dateString   - 比较的日期：[2022-09-01]
 @return 是否比传入的日期晚
 */
- (BOOL)jz_laterDateString:(NSString *)dateString;
/**
 比较日期的早晚，仅仅比较2022-09-01格式的日期
 @param dateString   - 比较的日期：[2022-09-01]
 @return 是否比传入的日期早
 */
- (BOOL)jz_earlierDateString:(NSString *)dateString;

/**
 json转字典，解析失败返回nil
 */
- (NSDictionary * _Nullable)jz_toDictionary;

@end

/* <----------------------- NSString -------------------------------> */


/* <----------------------- NSArray -------------------------------> */

@interface NSArray (JZExtension)

- (id)jz_objectAtIndexWithSafe:(NSUInteger)index;

@end

/* <----------------------- NSArray -------------------------------> */

/* <----------------------- NSMutableArray -------------------------------> */

@interface NSMutableArray (JZExtension)

/**
 添加视图的方法.
 @param subview  - 视图.
 */
- (void)jz_addSubview:(nonnull UIView *)subview;

- (id)jz_objectAtIndexWithSafe:(NSUInteger)index;

- (void)jz_addObjectSafe:(id)object;


@end

/* <----------------------- NSMutableArray -------------------------------> */


/* <----------------------- NSBundle -------------------------------> */

@interface NSBundle (JZExtension)

+ (id)jz_loadLocalFileWithName:(NSString *)name
                          type:(NSString *)type;

@end

/* <----------------------- NSBundle -------------------------------> */

/* <----------------------- NSDate -------------------------------> */

@interface NSDate (JZExtension)

/**
 根据时间串返回NSDate
 @return NSDate
 */
- (NSString *)jz_toString;
/**
 根据时间串返回NSDate
 @param format      格式化JZDateFormatType
 @return NSDate
 */
- (NSString *)jz_toDateWithFormatType:(JZDateFormatType)type;
/**
 根据NSDate返回时间串
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSString *)jz_toStringWithFormat:(NSString *)formatString;
/**
 重新生成新NSDate
 */
+ (NSDate *)newDateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                       minute:(NSInteger)minute
                     second:(NSInteger)second;

@end

/* <----------------------- NSDate -------------------------------> */
/* <----------------------- NSDictionary -------------------------------> */

@interface NSDictionary (JZExtension)
/**
 * 字典取值[可能返回nil]
 */
@property(nonatomic, copy, class, readonly) id _Nullable (^jz_objectForKey)(id objc, NSString * _Nullable key);
/**
 字典取字符串[失败返回空字符串]
 */
@property(nonatomic, copy, class, readonly) NSString * _Nullable (^jz_stringValueForKey)(id objc, NSString * _Nullable key);

@end


/* <----------------------- NSDictionary -------------------------------> */


NS_ASSUME_NONNULL_END
