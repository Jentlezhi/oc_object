//
//  YYAMapNaviArrowPoylineConfig.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/2/27.
//

#import "YYAMapNaviArrowPoylineConfig.h"
#import "YYBundleHelper.h"

@implementation YYAMapNaviArrowPoylineConfig

- (instancetype)init {
    if (self = [super init]) {
        self.lineWidth = 23.f;
        self.lineCapType = kMALineCapArrow;
        self.strokeImage = [YYBundleHelper imageName:@"custtexture_grey" bundleName:@"YYAMapNavi"];
        self.overlayLevel = MAOverlayLevelAboveLabels;
        self.alpha = 1.f;
    }
    return self;
}
#pragma mark - Methods

@end
