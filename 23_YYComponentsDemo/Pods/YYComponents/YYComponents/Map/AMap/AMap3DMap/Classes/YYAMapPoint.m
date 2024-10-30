//
//  YYAMapPoint.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapPoint.h"

@implementation YYAMapPoint

+ (YYAMapPoint *)locationWithLatitude:(CGFloat)lat longitude:(CGFloat)lon {
    YYAMapPoint *point = [YYAMapPoint new];
    point.latitude = lat;
    point.longitude = lon;
    [point setCoordinate:CLLocationCoordinate2DMake(lat, lon)];
    return point;
}
#pragma mark - Setter
- (void)setPinTitle:(NSString *)pinTitle {
    _pinTitle = pinTitle;
    self.title = pinTitle;
}

@end
