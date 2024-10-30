//
//  YYAMapPoint.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <AMapNaviKit/AMapNaviKit.h>
typedef NS_ENUM(NSInteger, YYPinAnnotationType) {
    YYPinAnnotationTypeStart,
    YYPinAnnotationTypeWay,
    YYPinAnnotationTypeEnd
};
typedef NS_ENUM(NSInteger, YYPinAnnotationColor){
    YYPinAnnotationColorRed = 0,    ///< 红色大头针
    YYPinAnnotationColorGreen,      ///< 绿色大头针
    YYPinAnnotationColorPurple      ///< 紫色大头针
};
NS_ASSUME_NONNULL_BEGIN

@interface YYAMapPoint : MAPointAnnotation<MAAnnotation>
///纬度
@property (nonatomic, assign) CGFloat latitude;
///经度
@property (nonatomic, assign) CGFloat longitude;
///是否绘制大头针
@property(nonatomic, assign) BOOL showPinAnnotationView;
///大头针类型
@property (nonatomic, assign) YYPinAnnotationType pinType;
///大头针颜色
@property (nonatomic, assign) YYPinAnnotationColor pinColor;
///大头针标题
@property(nonatomic, copy) NSString *pinTitle;
///自定义图片[尺寸最佳为20x20]
@property(nonatomic, strong) UIImage *customImage;


+ (YYAMapPoint *)locationWithLatitude:(CGFloat)lat longitude:(CGFloat)lon;
@end

NS_ASSUME_NONNULL_END
