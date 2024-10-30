//
//  YYAMapNaviManager.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviCommonObj.h>
#import "YYAMapNaviConfig.h"
#import "YYSelectableOverlay.h"
#import "YYAMapNaviArrowPoylineConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapNaviManager : NSObject

///配置
@property(nonatomic, strong, readonly) YYAMapNaviConfig *config;
///导航视图
@property(nonatomic, strong, readonly) AMapNaviDriveView *driveView;
///导航实时数据
@property(nonatomic, strong, readonly) AMapNaviInfo *naviInfo;
/**
 路线规划成功回调
 路径信息:allRouteInfos
 NSDictionary {
   routeID:路径id
   routeLabel:路径标签
   routeLength:路径长度
   routeTime:导航路径所需的时间(单位:秒)
 }
 */
@property(nonatomic, copy) void (^calculateRouteSuccess)(AMapNaviRoute *naviRoute, NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes, NSArray <id <MAOverlay>> *overlays, NSArray <NSDictionary *> *allRouteInfos);
/*
 出现偏航需要重新计算路径时的回调函数
 偏航后SDK内部将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理，您无需自行算路
 */
@property(nonatomic, copy) void (^driveManagerNeedRecalculateRouteForYawCallback)(AMapNaviDriveManager *driveManager);
/// 退出按钮的点击回调
@property(nonatomic, copy) void(^driveViewCloseButtonClickedCallback)(AMapNaviDriveManager *driveManager, AMapNaviDriveView *driveView);
/// 设置/更多按钮点击回调
@property(nonatomic, copy) void(^driveViewMoreButtonClickedCallback)(void);
///路线规划失败回调
@property(nonatomic, copy) void (^calculateRouteFail)(void);
///当前导航路径的信息,仅在路线规划成功回调之后可正常获取
@property (nonatomic, readonly, nullable) AMapNaviRoute *naviRoute;
///多路径规划时的所有路径信息,仅在路线规划成功回调之后可正常获取
@property (nonatomic, readonly, nullable) NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes;
///导航到达目的地后的回调函数(模拟导航和实时导航都回调改方法)
@property(nonatomic, copy) void(^driveManagerOnArrivedDestination)(AMapNaviDriveManager *driveManager);
///导航信息更新回调
@property(nonatomic, copy) void(^updateNaviInfo)(AMapNaviInfo *naviInfo);
/**
 创建导航管理
 */
+ (instancetype)managerWithConfig:(void(^)(YYAMapNaviConfig *config))configBlock;
/**
 * @brief 带起点的驾车路径规划
 * @param startPoint  起点坐标，传nil表示从“当前位置”出发
 * @param endPoint    终点坐标.
 * @param wayPoint    途经点坐标
 * @param strategy    路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithStartPoint:(nullable YYAMapNaviPoint *)startPoint
                                 endPoint:(nonnull YYAMapNaviPoint *)endPoint
                                 wayPoint:(nullable YYAMapNaviPoint *)wayPoint
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy;
/**
 * @brief 根据高德POIId进行驾车路径规划,为了保证路径规划的准确性,请尽量使用此方法. since 6.1.0
 * @param startPOIId  起点POIId,如果以“我的位置”作为起点,请传nil
 * @param endPOIId    终点POIId,必填
 * @param wayPOIIds   途经点POIId,最多支持16个途经点. 超过16个会取前16个
 * @param strategy    路径的计算策略，建议使用 AMapNaviDrivingStrategyMultipleDefault，与[高德地图]默认策略一致 (避让拥堵+速度优先+避免收费)
 * @return 规划路径所需条件和参数校验是否成功，不代表算路成功与否
 */
- (BOOL)calculateDriveRouteWithStartPointPOIId:(nullable NSString *)startPOIId
                                 endPointPOIId:(nonnull NSString *)endPOIId
                                wayPointsPOIId:(nullable NSArray<NSString *> *)wayPOIIds
                               drivingStrategy:(AMapNaviDrivingStrategy)strategy;


/**
 销毁AMapNaviDriveManager单例. AMapNaviDriveManager内存开销比较大，建议不使用时可销毁
 @return            是否销毁成功. 如果返回NO，请检查单例是否被强引用
 */
- (BOOL)destroyNaviDriveManager;
/**
 overlays
 */
+ (NSArray <YYSelectableOverlay *> *)overlays;
/**
 路径信息
 NSDictionary {
   routeID:路径id
   routeLabel:路径标签
   routeLength:路径长度
 }
 */
+ (NSArray <NSDictionary *> *)allRouteInfos;
/**
 根据路线开始导航
 @param routeID     路线id
 */
- (void)selectNaviRouteWithRouteID:(NSInteger)routeID;
/**
 * @brief 开始模拟导航. 注意：必须在路径规划成功的情况下，才能够开始模拟导航
 * @return 是否成功
 */
- (BOOL)startEmulatorNaviWithSpeed:(int)speed;
/**
 * @brief 开始实时导航. 注意：必须在路径规划成功的情况下，才能够开始实时导航
 * @return 是否成功
 */
- (BOOL)startGPSNavi;
/**
 * @brief 停止导航,包含实时导航和模拟导航
 */
- (void)stopNavi;
/**
 添加路线
 @param configBlock    配置信息
 */
- (void)addMapNaviArrowPoylineWithConfig:(void(^)(YYAMapNaviArrowPoylineConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
