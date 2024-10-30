//
//  YYAMapManager.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import "YYAMapConfig.h"
#import <AMapNaviKit/MAMapView.h>
#import "YYAMapPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapManager : NSObject
/**
 创建地图管理
 */
+ (instancetype)managerWithConfig:(void(^)(YYAMapConfig *config))configBlock;

/// 配置
@property(nonatomic, strong, readonly) YYAMapConfig *config;
/// 地图视图
@property(nonatomic, strong, readonly) MAMapView *mapView;

/**
 添加大头针
 @param points      大头针信息
 */
- (void)addAnnotationsWithPoints:(NSArray <YYAMapPoint*> *)points;
/**
 向地图窗口添加一组Overlay
 @param overlays      overlay信息
 */
- (void)addOverlays:(NSArray <id <MAOverlay>>*)overlays;
/**
 连接路径，选中所选路径
 @param routeID         选中的路径
 @param animation       是否显示动画
 @param duration        动画时长
 */
- (void)selectNaviRouteWithRouteID:(NSInteger)routeID
                         animation:(BOOL)animation
                          duration:(CFTimeInterval)duration;

- (void)reloadMap;
/**
 * @brief 强制刷新。（since 6.0.0）
 */
- (void)forceRefresh;

@end

NS_ASSUME_NONNULL_END
