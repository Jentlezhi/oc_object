//
//  YYSelectableOverlay.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import <AMapNaviKit/AMapNaviKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYSelectableOverlay : MABaseOverlay

@property (nonatomic, assign) NSInteger routeID;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *regularColor;

@property (nonatomic, strong) id<MAOverlay> overlay;

- (id)initWithOverlay:(id<MAOverlay>) overlay;

@end

NS_ASSUME_NONNULL_END
