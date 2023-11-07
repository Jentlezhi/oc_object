//
//  FoundationExtension.m
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import "JZFoundationExtension.h"
#import "NSObject+YYModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#define _SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

@implementation NSObject (JZExtension)

/**
 字典数组转模型数组.
 @param json - 字典数组.
 @return 模型数组.
 */
+ (NSArray *)jz_modelArrayWithKeyValuesArray:(id _Nullable)json {
    return [NSArray yy_modelArrayWithClass:[self class] json:json];
}

/**
 字典转模型.
 @param json - 字典
 @return 模型.
 */
+ (instancetype)jz_modelWithJSON:(id _Nullable)json {
    return [self yy_modelWithJSON:json];
}

/**
 模型转字典.
 @return 字典.
 */
- (NSDictionary *)jz_keyValues {
    return [self yy_modelToJSONObject];
}
/**
 把一个model中的所有值赋值给该model
 @param model          - 模型
 @param setNilValue    - 是否赋值model中的空值
 */
- (void)jz_setModelValueWithModel:(id)model
                      setNilValue:(BOOL)setNilValue{
    Class cls = [self class];
    if (![model isKindOfClass:cls]) {
        return;
    }
    unsigned int count = 0;
    //获取类的属性列表
    Ivar *ivars = class_copyIvarList(cls, &count);
    //给属性赋值
    for (int i = 0; i<count; i++){
        Ivar ivar = ivars[i];
        //获取变量名称
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //生成setter方法
        NSString *usefullStr = [key substringFromIndex:1];          //跳过下划线
        SEL getSel = NSSelectorFromString(usefullStr);
        key = usefullStr.capitalizedString;                         //大写首字母
        key = [NSString stringWithFormat:@"set%@:", key];     //拼接set方法字符串
        SEL setSel = NSSelectorFromString(key);
        //调用setter方法
        if ([self respondsToSelector:setSel]){
            id value = nil;
            _SuppressPerformSelectorLeakWarning(
                if ([model respondsToSelector:getSel]){
                    value = [model performSelector:getSel];
                }
            );
            if (!setNilValue){
                if (value != nil){
                    [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
                }
            }else{
                [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    free(ivars);
}
/**
 把一个模型中的所有值赋值给该模型
 @param model    - 模型
 */
- (void)jz_setModelValueWithModel:(id)model {
    [self jz_setModelValueWithModel:model setNilValue:YES];
}
/**
 模型赋值-简单的设置对应key的值
 @param data    - 数据
 */
- (void)jz_setModelValueWithData:(id)data {
    NSDictionary  *d;
    if ([data isKindOfClass:[NSDictionary class]]) {
        d = data;
    }else{
        d = [data jz_keyValues];
    }
    if (d == nil || ![d isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [d.allKeys enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *selName = @"set".jz_append(key.jz_capitalizedFirstLatter).jz_append(@":");
        SEL setSel = NSSelectorFromString(selName);
        _SuppressPerformSelectorLeakWarning(
           if([self respondsToSelector:setSel]){
               id value = [d valueForKey:key];
               [self performSelector:setSel withObject:value];
           }
        );
    }];
}
/**
 对象转字符串[转换失败返回空字符串]
 @return 字符串
 */
- (NSString * _Nullable)jz_toString {
    NSString *strValue = @"";
    id object = self;
    ///NSString
    if ([object isKindOfClass:NSString.class]){
        strValue = object;
        return strValue;
    }
    ///NSNumber
    if ([object isKindOfClass:NSNumber.class]){
        NSNumber *numberValue = object;
        //Type Encodings
        const char *numberType = numberValue.objCType;
        ///float
        if (strcmp(numberType, @encode(float)) == 0){
            float floatValue = numberValue.floatValue;
            strValue = [NSString stringWithFormat:@"%f",floatValue];
            //NSDecimalNumber保证精度
            NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:strValue];
            strValue = decimalNumber.stringValue;
            return strValue;
        }
        ///double
        if (strcmp(numberType, @encode(double)) == 0){
            double doubleValue = numberValue.doubleValue;
            strValue = [NSString stringWithFormat:@"%f",doubleValue];
            NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:strValue];
            strValue = decimalNumber.stringValue;
            return strValue;
        }
        ///其他转为int
        int intValue = numberValue.intValue;
        strValue = [NSString stringWithFormat:@"%d",intValue];
        return strValue;
    }
    ///NSDictionary
    if ([object isKindOfClass:NSDictionary.class]){
        NSDictionary *dictValue = object;
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictValue options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (NSString.jz_isNotEmpty(jsonStr)){
            strValue = jsonStr;
        }
    }
    return strValue;
}
@end

@implementation NSString (JZExtension)
/**
 int转NSString
 @param intValue  - int值
 @return 转换后的字符串
 */
+ (NSString * _Nonnull (^)(int))jz_contentWithInt {
    return ^(int intValue){
        return [NSString stringWithFormat:@"%d",intValue];
    };
}
/**
 integer转NSString
 @param integerValue  - integer值
 @return 转换后的字符串
 */
+ (NSString * _Nonnull (^)(NSInteger))jz_contentWithInteger {
    return ^(NSInteger integerValue){
        return [NSString stringWithFormat:@"%ld",(long)integerValue];
    };
}
/**
 double转NSString
 @param doubleValue    - double值
 @param decimalPlaces  - 精确位数(1-6位)
 @return 转换后的字符串
 */
+ (NSString * _Nonnull (^)(double, int))jz_contentWithDouble {
    return ^(double doubleValue,int decimalPlaces){
        switch (decimalPlaces) {
            case 1:
                return [NSString stringWithFormat:@"%.1f",doubleValue];
                break;
            case 2:
                return [NSString stringWithFormat:@"%.2f",doubleValue];
                break;
            case 3:
                return [NSString stringWithFormat:@"%.3f",doubleValue];
                break;
            case 4:
                return [NSString stringWithFormat:@"%.4f",doubleValue];
                break;
            case 5:
                return [NSString stringWithFormat:@"%.5f",doubleValue];
                break;
            case 6:
                return [NSString stringWithFormat:@"%.6f",doubleValue];
                break;
            default:
                return [NSString stringWithFormat:@"%f",doubleValue];
                break;
        }
    };
}
/**
 float转NSString
 @param floatValue     - float值
 @param decimalPlaces  - 精确位数(1-6位)
 @return 转换后的字符串
 */
+ (NSString * _Nonnull (^)(float, int))jz_contentWithFloat {
    return ^(float floatValue,int decimalPlaces){
        switch (decimalPlaces) {
            case 1:
                return [NSString stringWithFormat:@"%.1f",floatValue];
                break;
            case 2:
                return [NSString stringWithFormat:@"%.2f",floatValue];
                break;
            case 3:
                return [NSString stringWithFormat:@"%.3f",floatValue];
                break;
            case 4:
                return [NSString stringWithFormat:@"%.4f",floatValue];
                break;
            case 5:
                return [NSString stringWithFormat:@"%.5f",floatValue];
                break;
            case 6:
                return [NSString stringWithFormat:@"%.6f",floatValue];
                break;
            default:
                return [NSString stringWithFormat:@"%f",floatValue];
                break;
        }
        
    };
}
/**
 拼接字符串.
 @param str - 新字符串.
 @return 拼接后的字符串.
 */
- (instancetype)_append:(NSString *)str {
    if (![str isKindOfClass:[NSString class]] || str.length == 0) {
        return self;
    }
    return [self stringByAppendingString:str];
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))jz_append {
    return ^(NSString *content){
        return [self _append:content];
    };
}
/**
 首字母大写.
 @return 首字母大写的新字符串.
 */
- (instancetype)jz_capitalizedFirstLatter {
    NSString *firstLetter = [self substringToIndex:1].capitalizedString;
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstLetter];
}

/**
 判断字符串是否为空(nil/空字符串).
 @return 是否为空.
 */
+ (BOOL (^)(NSString * nullable))jz_isEmpty {
    return ^(NSString *str){
        return [self _isEmpty:str];
    };
}

/**
 判断字符串是否为非空.
 @return 是否为非空.
 */
+ (BOOL (^)(NSString * nullable))jz_isNotEmpty {
    return ^(NSString *str){
        BOOL ret = ![self _isEmpty:str];
        return ret;
    };
}

+ (BOOL)_isEmpty:(NSString *)str {
    if(!str || str == nil || ![str isKindOfClass:[NSString class]]) return YES;
    if ([str isEqual:[NSNull null]]) {return YES;}
    if ([str isKindOfClass:[NSNull class]]) {return YES;}
    ///兼容强制转换为NSString的情况
    if ([str isEqualToString:@"(null)"]) {return YES;}
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [str stringByTrimmingCharactersInSet:set];
    return trimmedStr.length == 0;
}

/**
 判断字符串是否相等.
 @return 是否相等.
 */
- (BOOL (^)(NSString * _Nullable))jz_isEqual {
    return ^(NSString *str){
        if (str == nil || ![str isKindOfClass:[NSString class]]) {
            return NO;
        }
        return [self isEqualToString:str];
    };
}

/**
 守护字符串安全，非空.
 @return 返回非空字符串.
 */
+ (NSString * _Nonnull (^)(NSString * _Nullable))jz_guard {
    return ^(NSString *str){
        if (NSString.jz_isEmpty(str)) {
            return @"";
        }
        return str;
    };;
}

+ (NSString * _Nonnull (^)(NSString * _Nullable, NSString * _Nullable))jz_valueAndDefaultValue {
    
    return ^(NSString *value,NSString *defaultValue){
        if (NSString.jz_isNotEmpty(value)) {
            return value;
        }
        return NSString.jz_isNotEmpty(defaultValue) ? defaultValue : @"";
    };
}

+ (NSString * _Nonnull (^)(__autoreleasing id _Nullable))jz_parse {
    
    return ^(id  _Nullable value){
        //NSNumber
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value stringValue];
        }
        //NSString
        if ([value isKindOfClass:[NSString class]]) {
            return NSString.jz_valueAndDefaultValue(value,@"");
        }
        return @"";
    };
}

/**
 随机英文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int))jz_randomLetters {
    return ^(int length){
        return [self _randomLettersWithMin:length max:length];
    };
}

/**
 随机英文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int, int))jz_randomRangedLetters {
    return ^(int min,int max){
        return [self _randomLettersWithMin:min max:max];
    };
}

+ (NSMutableString *)_randomLettersWithMin:(int)min max:(int)max {
    NSMutableString *randomString = [NSMutableString string];
    if (min <= 0 || min > max) {
        return randomString;
    }
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSInteger length = arc4random()%(max-min+1) + min;
    for (NSInteger i = 0; i < length; i++) {
        uint32_t index = (uint32_t)[letters length];
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform(index)]];
    }
    return randomString;
}

/**
 随机中文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int))jz_randomChineseLetters {
    return ^(int length){
        return [self _randomChineseLettersWithMin:length max:length];
    };
}

/**
 随机中文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int, int))jz_randomRangedChineseLetters {
    return ^(int min,int max){
        return [self _randomChineseLettersWithMin:min max:max];
    };
}


+ (NSMutableString *)_randomChineseLettersWithMin:(int)min max:(int)max {
    NSMutableString *randomChineseString = @"".mutableCopy;
    if (min <= 0 || min > max) {
        return randomChineseString;
    }
    NSUInteger count = arc4random()%(max-min+1) + min;
    for(NSInteger i =0; i < count; i++){
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL =0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData*data = [NSData dataWithBytes:&number length:2];
        NSString*string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [randomChineseString appendString:string];
    }
    return randomChineseString;
}
/**
 根据时间串返回NSDate
 @return NSDate
 */
- (NSDate *)jz_toDate {
    return [self jz_toDateWithFormatType:JZDateFormatTypeY_M_D];
}
/**
 根据时间串返回NSDate
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSDate *)jz_toDateWithFormatType:(JZDateFormatType)type {
    NSString *formatString;
    switch (type) {
        case JZDateFormatTypeY_M_D:
            formatString = @"yyyy-MM-dd";
            break;
        case JZDateFormatTypeY_M_DHMS:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            formatString = @"yyyy-MM-dd";
            break;
    }
    return [self jz_toDateWithFormat:formatString];
}
/**
 根据时间串返回NSDate
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSDate *)jz_toDateWithFormat:(NSString *)formatString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:formatString];
    return [formatter dateFromString:self];;
}
/**
 比较日期的早晚
 @param dateString   - 比较的日期：[2022-09-01]
 @return 是否比传入的日期晚
 */
- (BOOL)jz_laterDateString:(NSString *)dateString {
    return [self _differenceBetweenDateStr1:self dateStr2:dateString] > 0;
}
/**
 比较日期的早晚，仅仅比较2022-09-01格式的日期
 @param dateString   - 比较的日期：[2022-09-01]
 @return 是否比传入的日期早
 */
- (BOOL)jz_earlierDateString:(NSString *)dateString {
    return [self _differenceBetweenDateStr1:self dateStr2:dateString] < 0;
}
- (NSInteger)_differenceBetweenDateStr1:(NSString *)dateStr1
                               dateStr2:(NSString *)dateStr2{
    NSInteger dateInteger1 = [[dateStr1 stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    NSInteger dateInteger2 = [[dateStr2 stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue];
    return dateInteger1 - dateInteger2;
}
/**
 json转字典，解析失败返回nil
 */
- (NSDictionary * _Nullable)jz_toDictionary {
    NSString *strValue = self;
    if (NSString.jz_isEmpty(strValue)){
        return nil;
    }
    NSData *jsonData = [strValue dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err){
        return nil;
    }
    return dic;
}


@end

@implementation NSArray (JZExtension)

- (id)jz_objectAtIndexWithSafe:(NSUInteger)index {

    if (index >= [self count]) {
        return nil;
    }
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }else{
        return value;
    }
}
- (id)newObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newObjectAtIndex:index];
    } @catch (NSException * exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"!!!![exception]: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

@end

@implementation NSMutableArray (JZExtension)

/**
 添加视图的方法.
 @param subview  - 视图.
 */
- (void)jz_addSubview:(nonnull UIView *)subview {
    if (![subview isKindOfClass:[UIView class]]) {return;}
    [self addObject:subview];
}
/**
 取元素.
 @param index  - 索引.
 */
- (id)jz_objectAtIndexWithSafe:(NSUInteger)index {

    if (index >= [self count]) {
        return nil;
    }
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }else{
        return value;
    }
}

- (void)jz_addObjectSafe:(id)object {
    if (object) {
        [self addObject:object];
    }
}

@end

@implementation NSBundle (JZExtension)

+ (id)jz_loadLocalFileWithName:(NSString *)name
                       type:(NSString *)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (path == nil) {return nil;}
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {return nil;}
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end

/* <----------------------- NSDate -------------------------------> */

@implementation NSDate (JZExtension)
/**
 根据时间串返回NSDate
 @return NSDate
 */
- (NSString *)jz_toString {
    return [self jz_toDateWithFormatType:JZDateFormatTypeY_M_D];
}
/**
 根据时间串返回NSDate
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSString *)jz_toDateWithFormatType:(JZDateFormatType)type {
    NSString *formatString;
    switch (type) {
        case JZDateFormatTypeY_M_D:
            formatString = @"yyyy-MM-dd";
            break;
        case JZDateFormatTypeY_M_DHMS:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            formatString = @"yyyy-MM-dd";
            break;
    }
    return [self jz_toStringWithFormat:formatString];
}
/**
 根据NSDate返回时间串
 @param format      格式化[yyyy-MM-dd]/[yyyy-MM-dd HH:mm:ss]/[MM dd yyyy]
 @return NSDate
 */
- (NSString *)jz_toStringWithFormat:(NSString *)formatString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale systemLocale];
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:formatString];
    return [formatter stringFromDate:self];
}
/**
 重新生成新NSDate
 */
+ (NSDate *)newDateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                       minute:(NSInteger)minute
                       second:(NSInteger)second {
    
    NSString *dateStr = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld",year,month,day,hour,minute,second];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale systemLocale];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:dateStr];
}

@end

/* <----------------------- NSDate -------------------------------> */
/* <----------------------- NSDictionary -------------------------------> */

@implementation NSDictionary (JZExtension)
/**
 * 字典取值[可能返回nil]
 */
+ (id  _Nullable (^)(id _Nonnull, NSString * _Nullable))jz_objectForKey {
    return ^(id objc, NSString *key){
        id value = nil;
        if ([objc isKindOfClass:[NSDictionary class]] && NSString.jz_isNotEmpty(key)){
            NSDictionary *objcDict = objc;
            value = [objcDict objectForKey:key];
        }
        return value;
    };
}
/**
 字典取字符串[取值失败返回空字符串]
 */
+ (NSString * _Nullable (^)(id _Nonnull, NSString * _Nullable))jz_stringValueForKey {
    return ^(id objc, NSString *key){
        NSString *strValue = @"";
        id objectValue = NSDictionary.jz_objectForKey(objc,key);
        if (objectValue == nil){return strValue;}
        NSObject *obj = objectValue;
        return obj.jz_toString;
    };
}

@end
/* <----------------------- NSDictionary -------------------------------> */
