//
//  JZUtility.m
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import "JZUtility.h"

@implementation JZUtility
/**
 获取起止日期的所有日期集合
 @param startDate      起始日期
 @param endDate        终止日期
 @return 该区间内所有日期集合
 */
+ (NSArray <NSDate *> *)getDatesBetweenStartDate:(NSDate *)startDate
                                      andEndDate:(NSDate *)endDate {
    ///公历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSMutableArray <NSDate *> *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [startDate compare:endDate];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:startDate];
         ///逐步添加日期
         [componentAarray addObject:startDate];
         ///后一天
         [comps setDay:([comps day] + 1)];
         startDate = [calendar dateFromComponents:comps];
         ///对比日期大小
         result = [startDate compare:endDate];
    }
    return componentAarray;
}
/**
 获取初始日期n天内的所有日期集合
 @param startDate      起始日期
 @param dayCount       指定n天内
 @return 该区间内所有日期集合
 */
+ (NSArray <NSDate *> *)getDatesFromStartDate:(NSDate *)startDate
                                  dayCount:(NSInteger)dayCount {
    NSDate *endDate = [startDate initWithTimeIntervalSinceNow:dayCount * 24 * 60 * 60];
    return [self getDatesBetweenStartDate:startDate andEndDate:endDate];
}

@end
