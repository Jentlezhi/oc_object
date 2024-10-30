//
//  YYNumberFormat.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/2/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNumberFormat : NSObject
/**
 阿拉伯数字转中文
 @param number      阿拉伯数字
 @return            中文数字
 */
+ (NSString *)convertNumberToChinese:(NSInteger)number;

/**
 浮点转字符串，最多保留小数点后两位
 @param value       浮点
 @return            格式化后的浮点
 */
+ (NSString *)convertFloatToString:(float)value;

@end

NS_ASSUME_NONNULL_END
