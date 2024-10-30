//
//  YYAMapNaviConfig.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import "YYAMapNaviPoint.h"
#import <AMapNaviKit/AMapNaviCommonObj.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapNaviConfig : NSObject
///起始点
@property (nonatomic, strong) YYAMapNaviPoint *startPoint;
///途经点
@property (nonatomic, strong) YYAMapNaviPoint *wayPoint;
///终点
@property (nonatomic, strong) YYAMapNaviPoint *endPoint;
///走过的路线是否置灰，默认为NO
@property (nonatomic, assign) BOOL showGreyAfterPass;
///是否显示更多按钮,默认NO
@property (nonatomic, assign) BOOL showMoreButton;
///是否允许后台定位。默认为NO(后台定位播报需要xcdoe设置勾选：Background Modes->Location updates)
@property(nonatomic, assign) BOOL allowsBackgroundLocationUpdates;
///是否使用内置播放器进行导航播报, 如果为YES，就是由导航SDK来播报导航信息. 默认为NO(后台语言播报需要xcdoe设置勾选：Background Modes->Audio, AirPlay, and Picture in Piceure)
@property (nonatomic, assign) BOOL isUseInternalTTS;
///导航界面跟随模式,默认AMapNaviViewTrackingModeCarNorth(车头一直朝上，对竖屏比较友好)
@property (nonatomic, assign) AMapNaviViewTrackingMode trackingMode;
@end

NS_ASSUME_NONNULL_END
