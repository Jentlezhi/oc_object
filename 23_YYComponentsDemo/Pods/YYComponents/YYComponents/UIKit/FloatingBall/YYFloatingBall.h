//
//  YYFloatingBall.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYFloatingBallConfig : NSObject

/// 尺寸
@property(nonatomic, assign) CGFloat size;
/// 默认位置
@property(nonatomic, assign) CGPoint defaultOrigin;

@property(nonatomic, assign) CGFloat borderWidth;

@property(nonatomic, strong) UIColor *borderColor;

@property(nonatomic, strong) UIColor *backgroundColor;

@end

@interface YYFloatingBall : UIView

+ (instancetype)ballWithConfig:(void(^)(YYFloatingBallConfig *config))configBlock
                           tap:(void(^)(void))tapBlock
                       longTap:(void(^)(void))longTapBlock;

- (void)show;

- (void)hiden;

@end

NS_ASSUME_NONNULL_END
