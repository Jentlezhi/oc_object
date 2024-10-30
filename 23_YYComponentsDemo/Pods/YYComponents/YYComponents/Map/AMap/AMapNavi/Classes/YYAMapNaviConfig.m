//
//  YYAMapNaviConfig.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapNaviConfig.h"
#import <AMapNaviKit/AMapNaviDriveView.h>

@interface YYAMapNaviConfig()

@end

@implementation YYAMapNaviConfig
- (instancetype)init {
    if (self = [super init]) {
        self.isUseInternalTTS = NO;
        self.showGreyAfterPass = NO;
        self.showMoreButton = NO;
        self.allowsBackgroundLocationUpdates = NO;
        self.trackingMode = AMapNaviViewTrackingModeCarNorth;
    }
    return self;
}
@end
