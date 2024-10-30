//
//  YYAMapManager.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapManager.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "YYSelectableOverlay.h"

@interface YYAMapManager()<MAMapViewDelegate>

/// 服务
@property(nonatomic, strong) YYAMapConfig *config;
/// 地图视图
@property(nonatomic, strong) MAMapView *mapView;
/// 地图服务
@property(nonatomic, strong) AMapServices *mapServices;
/// 大头针
@property(nonatomic, strong) NSMutableArray <YYAMapPoint*> *pinAnnotations;

@end


@implementation YYAMapManager

+ (instancetype)managerWithConfig:(void(^)(YYAMapConfig *config))configBlock {
    YYAMapManager *manager = [self new];
    if (configBlock) {
        configBlock(manager.config);
    }
    [manager configs];
    return manager;
}
- (void)configs {
    //在构造MAMapView（MAOfflineMap，MAOfflineMapViewController,MATraceManager等）之前必须进行合规检查，设置接口之前保证隐私政策合规
    [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
    ///设置配置
    MAMapView *mapView = self.mapView;
    YYAMapConfig *config = self.config;
    ///是否显示用户位置
    mapView.showsUserLocation = config.showsUserLocation;
    ///地图类型。注意：自定义样式优先级高于mapType，如开启了自定义样式，要关闭自定义样式后mapType才生效
    mapView.mapType = config.mapType;
    ///是否显示指南针, 默认YES
    mapView.showsCompass = config.showsCompass;
    ///指南针原点位置
    mapView.compassOrigin = config.compassOrigin;
    ///指南针的宽高(只读属性)
    [config setValue:@(mapView.compassSize) forKey:@"compassSize"];
    ///是否显示比例尺, 默认YES
    mapView.showsScale = config.showsScale;
    ///比例尺原点位置
    mapView.scaleOrigin = config.scaleOrigin;
    ///比例尺的最大宽高
    [config setValue:@(mapView.scaleSize) forKey:@"scaleSize"];
    ///设置缩放级别（默认3-19，有室内地图时为3-20）
    if (config.zoomLevel >= 3 && config.zoomLevel <= 19) {
        [mapView setZoomLevel:config.zoomLevel animated:NO];
    }
    ///是否允许后台定位。默认为NO。只在iOS 9.0之后起作用。\n 设置为YES的时候必须保证 Background Modes 中的 Location updates处于选中状态，否则会抛出异常。\n 注意：定位必须在停止的状态下设置（showsUserLocation = NO），否则无效
    mapView.allowsBackgroundLocationUpdates = config.allowsBackgroundLocationUpdates;
    ///是否显示交通路况图层, 默认为NO
    mapView.showTraffic = config.showTraffic;
    ///自定义小蓝点
    if (config.locationImage) {
        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsHeadingIndicator = YES;
        r.image = config.locationImage;
        [mapView updateUserLocationRepresentation:r];
    }
}
#pragma mark -  lazyload
- (YYAMapConfig *)config {
    if (!_config) {
        _config = [YYAMapConfig new];
    }
    return _config;
}
- (AMapServices *)mapServices {
    if (!_mapServices) {
        _mapServices = [AMapServices sharedServices];
        
    }
    return _mapServices;
}
- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [MAMapView new];
        _mapView.delegate = self;
    }
    return _mapView;
}
- (NSMutableArray <YYAMapPoint*> *)pinAnnotations {
    if (!_pinAnnotations) {
        _pinAnnotations = @[].mutableCopy;
    }
    return _pinAnnotations;
}
#pragma mark - Setter
#pragma mark - Methods
- (void)addAnnotationsWithPoints:(NSArray <YYAMapPoint*> *)points {
    [self.pinAnnotations addObjectsFromArray:points];
}
- (void)reloadMap {
    [self.mapView reloadMap];
}
- (void)forceRefresh {
    [self.mapView forceRefresh];
}
- (void)addAnnotations {
    if (self.config.startPoint.showPinAnnotationView && self.config.startPoint) {
        [self.pinAnnotations addObject:self.config.startPoint];
    }
    if (self.config.wayPoint.showPinAnnotationView && self.config.wayPoint) {
        [self.pinAnnotations addObject:self.config.wayPoint];
    }
    if (self.config.endPoint.showPinAnnotationView && self.config.endPoint) {
        [self.pinAnnotations addObject:self.config.endPoint];
    }
    if (self.pinAnnotations.count == 0) {return;}
    [self.mapView removeAnnotations:self.pinAnnotations];
    [self.mapView addAnnotations:self.pinAnnotations];
//    [self.mapView showAnnotations:self.pinAnnotations animated:self.config.annotationsDefaultShowAnimations];
}
/**
 向地图窗口添加一组Overlay
 @param overlays      overlay信息
 */
- (void)addOverlays:(NSArray <id <MAOverlay>>*)overlays {
    [self.mapView removeOverlays:self.mapView.overlays];
    ///使路径插入道路信息底部
    [self.mapView addOverlays:overlays level:MAOverlayLevelAboveRoads];
}
/**
 连接路径，选中所选路径
 @param routeID         选中的路径
 @param animation       是否显示动画
 @param duration        动画时长
 */
- (void)selectNaviRouteWithRouteID:(NSInteger)routeID
                         animation:(BOOL)animation
                          duration:(CFTimeInterval)duration {
    NSArray *overlays = self.mapView.overlays;
    __block YYSelectableOverlay *selectedOverlay;
    [overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop) {
         if ([overlay isKindOfClass:[YYSelectableOverlay class]]) {
             YYSelectableOverlay *selectableOverlay = overlay;
             MAPolylineRenderer *overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
             if (selectableOverlay.routeID == routeID) {///当前选中的路线
                 selectedOverlay = selectableOverlay;
                 selectableOverlay.selected = YES;
                 selectableOverlay.selectedColor = self.config.polylineSelectColor;
                 overlayRenderer.fillColor   = self.config.polylineSelectColor;
                 overlayRenderer.strokeColor = self.config.polylineSelectColor;
                 overlayRenderer.strokeImage = self.config.polylineSelectedStrokeImage;
                 overlayRenderer.lineWidth = self.config.polylineSelectlineWidth;
                 [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:overlays.count - 1];
             } else {///其他路线
                 selectableOverlay.selected = NO;
                 selectableOverlay.regularColor = self.config.polylineRegularColor;
                 overlayRenderer.fillColor   = self.config.polylineRegularColor;
                 overlayRenderer.strokeColor = self.config.polylineRegularColor;
                 overlayRenderer.strokeImage = self.config.polylineRegularStrokeImage;
                 overlayRenderer.lineWidth = self.config.polylineRegularlineWidth;
             }
         }
    }];
    if (selectedOverlay) {
        [self.mapView setVisibleMapRect:selectedOverlay.boundingMapRect edgePadding:self.config.annotationsEdgePadding animated:animation duration:duration];
    }
}
#pragma mark - MAMapViewDelegate
/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView {
    [self addAnnotations];
}
/**
 大头针
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[YYAMapPoint class]]) {
        YYAMapPoint *navAnnotation = (YYAMapPoint *)annotation;
        if (!navAnnotation.showPinAnnotationView){
            return nil;
        }
        if (navAnnotation.customImage) {
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil){
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
    reuseIdentifier:reuseIndetifier];
            }
            annotationView.image = navAnnotation.customImage;
            return annotationView;
        }
        static NSString *annotationIdentifier = @"NaviPointAnnotationIdentifier";
        MAPinAnnotationView *pointAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (pointAnnotationView == nil)
        {
            pointAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:annotationIdentifier];
        }
        pointAnnotationView.animatesDrop   = NO;
        pointAnnotationView.canShowCallout = (navAnnotation.pinTitle && navAnnotation.pinTitle.length > 0) ? YES : NO;
        pointAnnotationView.draggable      = NO;
        [pointAnnotationView setPinColor:(MAPinAnnotationColor)navAnnotation.pinColor];
        return pointAnnotationView;
    }
    return nil;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[YYSelectableOverlay class]]) {
        YYSelectableOverlay *selectableOverlay = (YYSelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        return polylineRenderer;
    }
    return nil;
}
@end
