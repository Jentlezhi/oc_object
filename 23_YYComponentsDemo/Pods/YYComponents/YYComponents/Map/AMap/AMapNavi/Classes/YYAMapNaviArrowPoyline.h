//
//  YYAMapNaviArrowPoyline.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/2/27.
//

#import <AMapNaviKit/AMapNaviKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAMapNaviArrowPoyline : MAPolyline<AMapNaviCompositeOverlay>

@property (nonatomic, strong) MAOverlayRenderer *overlayRender;

@property (nonatomic, assign) MAOverlayLevel overlayLevel;

@end

NS_ASSUME_NONNULL_END
