//
//  YYDebouncedButton.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2019/9/2.
//

#import "YYButton.h"

@interface YYButton()

/// 记录上次响应时间
@property(nonatomic, assign) NSTimeInterval eventTime;
/// 线程安全
@property(nonatomic, strong) NSLock *lock;
/// 是否需要给原始属性赋值
@property(nonatomic, assign) BOOL needSetOrigin;
/// 原始image
@property(nonatomic, strong) UIImage *originNormalImage;
/// 原始标题
@property(nonatomic, copy) NSString *originNormalTitle;
/// 原始标题颜色
@property(nonatomic, strong) UIColor *originNormalTitleColor;
/// loading
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation YYButton

- (instancetype)init {
    if (self = [super init]) {
        self.needSetOrigin = YES;
    }
    return self;
}

/**
 防抖动
 */
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.eventInterval <= 0) {
        [super sendAction:action to:target forEvent:event];
        return;
    }
    [self.lock lock];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    if (nowTime - self.eventTime > self.eventInterval) {
        [super sendAction:action to:target forEvent:event];
        self.eventTime = [[NSDate date] timeIntervalSince1970];
    }
    [self.lock unlock];
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [NSLock new];
    }
    return _lock;
}
/**
 增大点击范围
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    UIEdgeInsets enlargedRect = self.enlargedRect;
    CGRect rect = CGRectMake(bounds.origin.x - enlargedRect.left,
                             bounds.origin.y - enlargedRect.top,
                             bounds.size.width + enlargedRect.left + enlargedRect.right,
                             bounds.size.height + enlargedRect.top + enlargedRect.bottom);
    return CGRectContainsPoint(rect,point);
}
#pragma mark - Setter
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    if (state == UIControlStateNormal && self.needSetOrigin) {
        self.originNormalImage = image;
    }
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    if (state == UIControlStateNormal && self.needSetOrigin) {
        self.originNormalTitle = title;
    }
}
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [super setTitleColor:color forState:state];
    if (state == UIControlStateNormal && self.needSetOrigin) {
        self.loadingTipColor = color;
    }
}
- (void)setLoadingTipColor:(UIColor *)loadingTipColor {
    _loadingTipColor = loadingTipColor;
    self.indicatorView.color = loadingTipColor;
}
- (NSString *)loadingTip {
    if (_loadingTip == nil) {
        return self.titleLabel.text;
    }
    return _loadingTip;
}
- (void)setIsLoading:(BOOL)isLoading {
    if (isLoading) {
        if (_isLoading){return;}
        self.needSetOrigin = NO;
        self.userInteractionEnabled = NO;
        CGFloat contentSize = self.bounds.size.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom;
        CGFloat indicatorViewSize = contentSize*0.7f;
        UIImage *image = [self imageWithColor:UIColor.clearColor imageSize:CGSizeMake(contentSize, contentSize)];
        [self.indicatorView startAnimating];
        CGFloat radio = indicatorViewSize/20.f;
        CGAffineTransform transform = CGAffineTransformMakeScale(radio, radio);
        self.indicatorView.transform = transform;
        [self setImage:image forState:UIControlStateNormal];
        [self.imageView addSubview:self.indicatorView];
        self.indicatorView.center = CGPointMake(contentSize*0.5, contentSize*0.5);
        [self.indicatorView startAnimating];
        [self setTitle:self.loadingTip forState:UIControlStateNormal];
        [self setTitleColor:self.loadingTipColor forState:UIControlStateNormal];
    } else {
        self.needSetOrigin = YES;
        self.userInteractionEnabled = YES;
        [self.indicatorView stopAnimating];
        [self.indicatorView removeFromSuperview];
        [self setImage:self.originNormalImage forState:UIControlStateNormal];
        [self setTitle:self.originNormalTitle forState:UIControlStateNormal];
        [self setTitleColor:self.loadingTipColor forState:UIControlStateNormal];
    }
    _isLoading = isLoading;
}
#pragma mark - lazyload
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView){
        _indicatorView = [UIActivityIndicatorView new];
    }
    return _indicatorView;
}
#pragma mark - methods
- (UIImage*)imageWithColor:(UIColor *)color
                        imageSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
