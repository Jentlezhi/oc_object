//
//  YYNumberFormat.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/2/6.
//

#import "YYNumberFormat.h"

@implementation YYNumberFormat

/**
 阿拉伯数字转中文
 @param number      阿拉伯数字
 @return            中文数字
 */
+ (NSString *)convertNumberToChinese:(NSInteger)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = (NSNumberFormatterStyle)kCFNumberFormatterRoundHalfDown;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans_US"];
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
    string = [string stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    return string;
}
/**
 浮点转字符串，最多保留小数点后两位
 @param value       浮点
 @return            格式化后的浮点
 */
+ (NSString *)convertFloatToString:(float)value {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:0];
    [formatter setMinimumIntegerDigits:1];
    NSString *resultString = [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
    return resultString;
}




@end
