//
//  YYAMapNaviPoint.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapNaviPoint : NSObject
///纬度
@property (nonatomic, assign) CGFloat latitude;
///经度
@property (nonatomic, assign) CGFloat longitude;
/**
 * @brief AMapNaviPoint类对象的初始化函数
 * @param lat 纬度
 * @param lon 经度
 * @return AMapNaviPoint类对象id
 */
+ (instancetype)locationWithLatitude:(CGFloat)lat longitude:(CGFloat)lon;

@end

NS_ASSUME_NONNULL_END
