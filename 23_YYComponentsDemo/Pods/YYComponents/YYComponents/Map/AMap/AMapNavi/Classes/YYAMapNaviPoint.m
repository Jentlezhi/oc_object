//
//  YYAMapNaviPoint.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapNaviPoint.h"

@implementation YYAMapNaviPoint
/**
 * @brief AMapNaviPoint类对象的初始化函数
 * @param lat 纬度
 * @param lon 经度
 * @return AMapNaviPoint类对象id
 */
+ (instancetype)locationWithLatitude:(CGFloat)lat longitude:(CGFloat)lon {
    YYAMapNaviPoint *point = [self new];
    point.latitude = lat;
    point.longitude = lon;
    return point;
}
@end
