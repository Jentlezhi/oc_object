//
//  YYSelectableOverlay.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYSelectableOverlay.h"

@implementation YYSelectableOverlay

- (CLLocationCoordinate2D)coordinate {
    return [self.overlay coordinate];
}

- (MAMapRect)boundingMapRect {
    return [self.overlay boundingMapRect];
}
- (id)initWithOverlay:(id<MAOverlay>)overlay {
    self = [super init];
    if (self){
        self.overlay = overlay;
        self.selected = NO;
    }
    return self;
}

@end
