//
//  YYAMapNaviManager.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapNaviManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviDriveManager.h>
#import <AMapNaviKit/AMapNaviDriveView.h>
#import <AMapNaviKit/AMapNaviRoute.h>
#import "YYAMapNaviArrowPoyline.h"

@interface YYAMapNaviManager()<AMapNaviDriveManagerDelegate,AMapNaviDriveViewDelegate,AMapNaviDriveDataRepresentable>
///配置
@property(nonatomic, strong) YYAMapNaviConfig *config;
///导航视图
@property(nonatomic, strong) AMapNaviDriveView *driveView;
///当前导航路径的信息,仅在路线规划成功回调之后可正常获取
@property (nonatomic, strong, nullable) AMapNaviRoute *naviRoute;
///多路径规划时的所有路径信息,仅在路线规划成功回调之后可正常获取
@property (nonatomic, strong, nullable) NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes;
///导航实时数据
@property(nonatomic, strong) AMapNaviInfo *naviInfo;
@end

@implementation YYAMapNaviManager

+ (instancetype)managerWithConfig:(void(^)(YYAMapNaviConfig *config))configBlock {
    YYAMapNaviManager *manager = [self new];
    if (configBlock) {
        configBlock(manager.config);
    }
    [manager configs];
    return manager;
}

- (void)configs {
    AMapNaviDriveManager *driveManager = [AMapNaviDriveManager sharedInstance];
    [driveManager setDelegate:self];
    //将self 、driveView、trafficBarView 添加为导航数据的Representative，使其可以接收到导航诱导数据
    [driveManager addDataRepresentative:self.driveView];
    [driveManager addDataRepresentative:self];
    AMapNaviDriveView *driveView = self.driveView;
    YYAMapNaviConfig *config = self.config;
    driveManager.isUseInternalTTS = config.isUseInternalTTS;
    [driveManager setAllowsBackgroundLocationUpdates:config.allowsBackgroundLocationUpdates];
    driveView.showGreyAfterPass = config.showGreyAfterPass;
    driveView.trackingMode = config.trackingMode;
}

#pragma mark - Lazyload
- (YYAMapNaviConfig *)config {
    if (!_config) {
        _config = [YYAMapNaviConfig new];
    }
    return _config;
}
- (AMapNaviDriveView *)driveView {
    if (!_driveView) {
        AMapNaviDriveView *driveView = [AMapNaviDriveView new];
        driveView.delegate = self;
        driveView.showMoreButton = self.config.showMoreButton;
        _driveView = driveView;
    }
    return _driveView;
}
#pragma mark - Methods
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
                           drivingStrategy:(AMapNaviDrivingStrategy)strategy {
    if (!endPoint){return NO;}
    NSArray <AMapNaviPoint *> *startPoints;
    if (startPoint) {
        AMapNaviPoint *_startPoint = [AMapNaviPoint locationWithLatitude:startPoint.latitude longitude:startPoint.longitude];
        startPoints = @[_startPoint];
    }
    AMapNaviPoint *_endPoint = [AMapNaviPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    NSArray <AMapNaviPoint *> *wayPoints;
    if (wayPoint) {
        AMapNaviPoint *_wayPoint = [AMapNaviPoint locationWithLatitude:wayPoint.latitude longitude:wayPoint.longitude];
        wayPoints = @[_wayPoint];
    }
    return [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:startPoints
                                                                           endPoints:@[_endPoint]
                                                                           wayPoints:wayPoints
                                                                     drivingStrategy:strategy];
}

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
                               drivingStrategy:(AMapNaviDrivingStrategy)strategy {
    return [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPointPOIId:startPOIId endPointPOIId:endPOIId wayPointsPOIId:wayPOIIds drivingStrategy:strategy];
}
/**
 销毁AMapNaviDriveManager单例. AMapNaviDriveManager内存开销比较大，建议不使用时可销毁
 @return            是否销毁成功. 如果返回NO，请检查单例是否被强引用
 */
- (BOOL)destroyNaviDriveManager {
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    [self.driveView removeFromSuperview];
    self.driveView = nil;
    self.config = nil;
    self.naviInfo = nil;
    return [AMapNaviDriveManager destroyInstance];
}
/**
 overlays
 */
+ (NSArray <YYSelectableOverlay *> *)overlays {
    NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes = [AMapNaviDriveManager sharedInstance].naviRoutes.copy;
    NSMutableArray <YYSelectableOverlay *> *polylineInfos = [NSMutableArray array];
    NSArray <NSNumber*> *naviRouteIDs = [naviRoutes allKeys];
    for (NSNumber *aRouteID in naviRouteIDs) {
        AMapNaviRoute *aRoute = [naviRoutes objectForKey:aRouteID];
        int count = (int)[[aRoute routeCoordinates] count];
        //添加路径Polyline
        CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < count; i++) {
            AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
            coords[i].latitude = [coordinate latitude];
            coords[i].longitude = [coordinate longitude];
        }
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
        YYSelectableOverlay *overlay = [[YYSelectableOverlay alloc] initWithOverlay:polyline];
        overlay.routeID = [aRouteID integerValue];
        [polylineInfos addObject:overlay];
        free(coords);
    }
    return polylineInfos;
}
/**
 路径信息
 NSDictionary {
   routeID:路径id
   routeLabel:路径标签
   routeLength:路径长度
   routeTime:导航路径所需的时间(单位:秒)
 }
 */
+ (NSArray <NSDictionary *> *)allRouteInfos {
    NSMutableArray *routeInfos = @[].mutableCopy;
    NSDictionary<NSNumber *, AMapNaviRoute *> *naviRoutes = [AMapNaviDriveManager sharedInstance].naviRoutes.copy;
    NSArray <NSNumber*> *naviRouteIDs = [naviRoutes allKeys];
    for (NSNumber *aRouteID in naviRouteIDs) {
        AMapNaviRoute *aRoute = [naviRoutes objectForKey:aRouteID];
        NSMutableDictionary *dict = @{}.mutableCopy;
        [dict setValue:aRouteID forKey:@"routeID"];
        NSString *title = [[aRoute.routeLabels firstObject] content];
        [dict setValue:@((long)aRoute.routeLength) forKey:@"routeLength"];
        [dict setValue:title forKey:@"routeLabel"];
        [dict setValue:@(aRoute.routeTime) forKey:@"routeTime"];
        [routeInfos addObject:dict];
    }
    return routeInfos;
}
/**
 选择待导航路线
 @param routeID     路线id
 */
- (void)selectNaviRouteWithRouteID:(NSInteger)routeID {
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] selectNaviRouteWithRouteID:routeID];
}
/**
 * @brief 开始模拟导航. 注意：必须在路径规划成功的情况下，才能够开始模拟导航
 * @return 是否成功
 */
- (BOOL)startEmulatorNaviWithSpeed:(int)speed {
    [[AMapNaviDriveManager sharedInstance] setEmulatorNaviSpeed:speed];
    return [[AMapNaviDriveManager sharedInstance] startEmulatorNavi];
}
/**
 * @brief 开始实时导航. 注意：必须在路径规划成功的情况下，才能够开始实时导航
 * @return 是否成功
 */
- (BOOL)startGPSNavi {
    return [[AMapNaviDriveManager sharedInstance] startGPSNavi];
}
/**
 * @brief 停止导航,包含实时导航和模拟导航
 */
- (void)stopNavi {
    //停止导航
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
}
/**
 添加路线
 @param configBlock    配置信息
 */
- (void)addMapNaviArrowPoylineWithConfig:(void(^)(YYAMapNaviArrowPoylineConfig *config))configBlock {
    YYAMapNaviArrowPoylineConfig *config = [YYAMapNaviArrowPoylineConfig new];
    if (configBlock) {
        configBlock(config);
    }
    NSInteger n = config.routeCoordinates.count;
    CLLocationCoordinate2D ArrowPolylineCoords[n];
    for (NSInteger index = 0; index < n; index++) {
        AMapNaviPoint *point = config.routeCoordinates[index];
        ArrowPolylineCoords[index].latitude = point.latitude;
        ArrowPolylineCoords[index].longitude = point.longitude;
    }
    YYAMapNaviArrowPoyline *arrowPolyline = [YYAMapNaviArrowPoyline polylineWithCoordinates:ArrowPolylineCoords count:n];

    MAPolylineRenderer *arrowPolylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:arrowPolyline];
    arrowPolylineRenderer.strokeColor  = config.strokeColor;
    arrowPolylineRenderer.lineWidth = config.lineWidth;
    arrowPolylineRenderer.lineCapType = config.lineCapType;
    arrowPolylineRenderer.strokeImage = config.strokeImage;
    arrowPolylineRenderer.alpha = config.alpha;
    arrowPolyline.overlayRender = arrowPolylineRenderer;
    arrowPolyline.overlayLevel = config.overlayLevel;
    [self.driveView addCustomOverlay:arrowPolyline];
}
#pragma mark - AMapNaviDriveManagerDelegate
- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error {
    !self.calculateRouteFail?:self.calculateRouteFail();
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    self.naviRoute = [AMapNaviDriveManager sharedInstance].naviRoute;
    self.naviRoutes = [AMapNaviDriveManager sharedInstance].naviRoutes.copy;
    !self.calculateRouteSuccess?:self.calculateRouteSuccess(self.naviRoute, self.naviRoutes, [YYAMapNaviManager overlays], [YYAMapNaviManager allRouteInfos]);
}

/**
 * @brief 出现偏航需要重新计算路径时的回调函数.偏航后 SDK 内部将自动重新路径规划,该方法将在自动重新路径规划前通知您进行额外的处理，您无需自行算路.
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager {
    !self.driveManagerNeedRecalculateRouteForYawCallback?:self.driveManagerNeedRecalculateRouteForYawCallback(driveManager);
}
///退出按钮的点击
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    !self.driveViewCloseButtonClickedCallback?:self.driveViewCloseButtonClickedCallback([AMapNaviDriveManager sharedInstance], driveView);
}
/**
 * @brief 模拟导航到达目的地后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager {
    !self.driveManagerOnArrivedDestination?:self.driveManagerOnArrivedDestination(driveManager);
}

/**
 * @brief 实时导航到达目的地后的回调函数
 * @param driveManager 驾车导航管理类
 */
- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager {
    !self.driveManagerOnArrivedDestination?:self.driveManagerOnArrivedDestination(driveManager);
}
/**
 * @brief 导航信息更新回调
 * @param driveManager 驾车导航管理类
 * @param naviInfo 导航信息,参考 AMapNaviInfo 类
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviInfo:(nullable AMapNaviInfo *)naviInfo {
    self.naviInfo = naviInfo;
    !self.updateNaviInfo?:self.updateNaviInfo(naviInfo);
}
#pragma mark - MoreMenu Delegate
/**
 * @brief 导航界面更多按钮点击时的回调函数
 * @param driveView 驾车导航界面
 */
- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView {
    !self.driveViewMoreButtonClickedCallback?:self.driveViewMoreButtonClickedCallback();
}
@end
