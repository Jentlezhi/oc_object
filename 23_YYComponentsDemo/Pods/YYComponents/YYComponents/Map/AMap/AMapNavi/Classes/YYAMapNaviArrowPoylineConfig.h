//
//  YYAMapNaviArrowPoylineConfig.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/2/27.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapNaviArrowPoylineConfig : NSObject

///路线的所有形状点
@property (nonatomic, strong) NSArray<AMapNaviPoint *> *routeCoordinates;
///笔触颜色,默认是kMAOverlayRendererDefaultStrokeColor
@property (nonatomic, strong) UIColor *strokeColor;
///笔触宽度, 单位屏幕点坐标，默认是0
@property (nonatomic, assign) CGFloat lineWidth;
///LineJoin,默认是kMALineJoinBevel
@property (nonatomic, assign) MALineJoinType lineJoinType;
///LineCap,默认是kMALineCapButt
@property (nonatomic, assign) MALineCapType lineCapType;
///虚线类型, since 5.5.0
@property (nonatomic, assign) MALineDashType lineDashType;
///用于生成笔触纹理id的图片（支持非PowerOfTwo图片; 如果您需要减轻绘制产生的锯齿,您可以参考AMap.bundle中的traffic_texture_blue.png的方式,在image两边增加部分透明像素.)。（since 5.3.0）
@property (nonatomic, strong) UIImage *strokeImage;
/// 透明度
@property(nonatomic, assign) CGFloat strokeImageAlpha;
///绘制overlay的层级
@property (nonatomic, assign) MAOverlayLevel overlayLevel;
///透明度[0，1]，默认为1. 使用MAOverlayRenderer类提供的渲染接口会自动应用此属性。（since 5.1.0）
@property (nonatomic, assign) CGFloat alpha;

@end

NS_ASSUME_NONNULL_END
