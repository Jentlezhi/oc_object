//
//  YYAMapConfig.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapConfig.h"
#import "YYAMapManager.h"
#import "YYBundleHelper.h"

@interface YYAMapConfig()

/// 地图管理
@property(nonatomic, weak) YYAMapManager *mapManager;

@end

@implementation YYAMapConfig
- (instancetype)init {
    if (self = [super init]) {
        self.showsUserLocation = NO;
        self.mapType = MAMapTypeStandard;
        self.showsCompass = YES;
        self.allowsBackgroundLocationUpdates = NO;
        self.polylineSelectlineWidth = 23.f;
        self.polylineRegularlineWidth = self.polylineSelectlineWidth;
        self.polylineSelectedStrokeImage = [self defaultStrokeImage];
        self.polylineRegularStrokeImage = [self defaultStrokeImage];
        self.polylineRegularStrokeImageAlpha = 0.25f;
        self.polylineSelectedStrokeImageAlpha = 1.f;
    }
    return self;
}
- (void)setPolylineRegularStrokeImageAlpha:(CGFloat)polylineRegularStrokeImageAlpha {
    _polylineRegularStrokeImageAlpha = polylineRegularStrokeImageAlpha;
    if (polylineRegularStrokeImageAlpha <= 0 || polylineRegularStrokeImageAlpha >=1) {return;}
    self.polylineRegularStrokeImage = [self imageWithAlpha:polylineRegularStrokeImageAlpha forImage:[self defaultStrokeImage]];
}
- (void)setPolylineSelectedStrokeImageAlpha:(CGFloat)polylineSelectedStrokeImageAlpha {
    _polylineSelectedStrokeImageAlpha = polylineSelectedStrokeImageAlpha;
    if (polylineSelectedStrokeImageAlpha <= 0 || polylineSelectedStrokeImageAlpha >=1) {return;}
    self.polylineSelectedStrokeImage = [self imageWithAlpha:polylineSelectedStrokeImageAlpha forImage:[self defaultStrokeImage]];
}

- (UIImage *)defaultStrokeImage {
    return [YYBundleHelper imageName:@"custtexture_green" bundleName:@"YYAMap3DMap"];
}
#pragma mark - Methods
- (UIImage *)imageWithAlpha:(CGFloat)alpha forImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);

    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);

    CGContextSetBlendMode(context, kCGBlendModeMultiply);

    CGContextSetAlpha(context, alpha);

    CGContextDrawImage(context, area, image.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}
@end
