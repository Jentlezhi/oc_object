//
//  JZUtility.h
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import <Foundation/Foundation.h>

///屏蔽PerformSelector的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

NS_ASSUME_NONNULL_BEGIN

@interface JZUtility : NSObject

/**
 获取起止日期的所有日期集合
 @param startDate      起始日期
 @param endDate        终止日期
 @return 该区间内所有日期集合
 */
+ (NSArray <NSDate *> *)getDatesBetweenStartDate:(NSDate *)startDate
                                      andEndDate:(NSDate *)endDate;
/**
 获取初始日期n天内的所有日期集合
 @param startDate      起始日期
 @param dayCount       指定n天内
 @return 该区间内所有日期集合
 */
+ (NSArray <NSDate *> *)getDatesFromStartDate:(NSDate *)startDate
                                     dayCount:(NSInteger)dayCount;

@end

NS_ASSUME_NONNULL_END
