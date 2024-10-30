//
//  YYAMapConfig.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import "YYAMapPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapConfig : NSObject
///是否显示用户位置[默认: NO]
@property(nonatomic, assign) BOOL showsUserLocation;
///地图类型。注意：自定义样式优先级高于mapType，如开启了自定义样式，要关闭自定义样式后mapType才生效
@property (nonatomic, assign) MAMapType mapType;
///是否显示指南针, 默认YES
@property(nonatomic, assign) BOOL showsCompass;
///指南针原点位置
@property (nonatomic, assign) CGPoint compassOrigin;
///指南针的宽高
@property (nonatomic, readonly) CGSize compassSize;
///是否显示比例尺, 默认YES
@property (nonatomic, assign) BOOL showsScale;
///比例尺原点位置
@property (nonatomic, assign) CGPoint scaleOrigin;
///比例尺的最大宽高
@property (nonatomic, readonly) CGSize scaleSize;
///地图的缩放级别的范围从3到19级，共17个级别
@property (nonatomic, assign) CGFloat zoomLevel;
///起始点
@property (nonatomic, strong) YYAMapPoint *startPoint;
///途经点
@property (nonatomic, strong) YYAMapPoint *wayPoint;
///终点
@property (nonatomic, strong) YYAMapPoint *endPoint;
///选中策略的线颜色
@property (nonatomic, strong) UIColor *polylineSelectColor;
///其他策略的线颜色
@property (nonatomic, strong) UIColor *polylineRegularColor;
///策略的线宽度:选中
@property (nonatomic, assign) CGFloat polylineSelectlineWidth;
///策略的线宽度:其他
@property (nonatomic, assign) CGFloat polylineRegularlineWidth;
///策略选择的纹理图
@property(nonatomic, strong) UIImage *polylineSelectedStrokeImage;
///选择的纹理图透明度
@property(nonatomic, assign) CGFloat polylineSelectedStrokeImageAlpha;
///策略未选择的纹理图
@property(nonatomic, strong) UIImage *polylineRegularStrokeImage;
///未选择的纹理图透明度
@property(nonatomic, assign) CGFloat polylineRegularStrokeImageAlpha;
///是否允许后台定位。默认为NO。
@property(nonatomic, assign) BOOL allowsBackgroundLocationUpdates;
///是否显示交通路况图层, 默认为NO
@property (nonatomic, getter = isShowTraffic) BOOL showTraffic;
///自定义小蓝点
@property(nonatomic, strong) UIImage *locationImage;
/// annotations嵌入边界
@property(nonatomic, assign) UIEdgeInsets annotationsEdgePadding;

@end

NS_ASSUME_NONNULL_END
