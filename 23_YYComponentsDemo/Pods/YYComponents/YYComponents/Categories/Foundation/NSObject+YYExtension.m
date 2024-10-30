//
//  NSObject+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//  Copyright © 2018 Jentle. All rights reserved.
//

#import "NSObject+YYExtension.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSString+YYExtension.h"

@implementation NSObject (YYExtension)

/**
 转成字符串
 */
- (NSString *)yy_toString {
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
        if (NSString.yy_isNotEmpty(jsonStr)){
            strValue = jsonStr;
        }
    }
    //NSArray<NSString*>
    if ([object isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray*)object;
        NSMutableArray <NSString*> *stringArray = @[].mutableCopy;
        for (id object in array) {
            if (object == nil && ![object isKindOfClass:NSString.class]) {continue;}
            NSString *strValue = (NSString*)object;
            [stringArray addObject:strValue];
        }
        strValue = [stringArray componentsJoinedByString:@""];
    }
    return strValue;
}
/**
 把模型中存在的所有值赋值给另一个model
 @param toModel      目标model
 */
- (void)yy_setAllPropertiesValueToModel:(nonnull id)toModel {
    NSArray *properties = [[self class] yy_allProperties];
    NSArray *toModelProperties = [[toModel class] yy_allProperties];
    for (NSString *propertyName in properties) {
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue && [toModelProperties containsObject:propertyName]) {
            [toModel setValue:propertyValue forKey:propertyName];
        }
    }
}
/**
 获取类的所有属性
 */
+ (NSArray *)_allPropertiesForClass:(Class)cls {
    NSMutableArray *mArray = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        [mArray addObject:propertyName];
    }
    free(properties);
    return mArray.copy;
}

+ (NSArray<NSString *> *)yy_allProperties {
    return [self _allPropertiesForClass:[self class]];
}


@end
