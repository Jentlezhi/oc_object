//
//  YYFloatingBall.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/6.
//

#import "YYFloatingBall.h"

@implementation YYFloatingBallConfig

- (instancetype)init {
    if (self = [super init]) {
        self.size = 40.f;
        self.defaultOrigin = CGPointMake(0, UIApplication.sharedApplication.keyWindow.safeAreaInsets.top + 44.f);
        self.borderWidth = 2.f;
        self.borderColor = UIColor.greenColor;
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5f];
    }
    return self;
}

@end

@interface YYFloatingBall()

@property(nonatomic, strong) YYFloatingBallConfig *config;

@property(nonatomic, weak) UIView *fatherView;

@property(nonatomic, copy) void(^tapBlock)(void);

@property(nonatomic, copy) void(^longTapBlock)(void);

@end

@implementation YYFloatingBall

+ (instancetype)ballWithConfig:(void(^)(YYFloatingBallConfig *config))configBlock
                           tap:(void(^)(void))tapBlock
                       longTap:(void(^)(void))longTapBlock {
    YYFloatingBall *ball = [self new];
    if (configBlock) {
        configBlock(ball.config);
    }
    [ball configs];
    [ball setupViews];
    ball.tapBlock = tapBlock;
    ball.longTapBlock = longTapBlock;
    return ball;
}

- (void)setupViews {
    
}
- (void)configs {
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = self.config.borderColor.CGColor;
    self.backgroundColor = self.config.backgroundColor;
    self.layer.cornerRadius = self.config.size*0.5f;
    self.clipsToBounds = YES;
    
    // 添加拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panGesture];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGesture];
    
    // 添加长按手势
    UILongPressGestureRecognizer *longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap:)];
    [self addGestureRecognizer:longTapGesture];
}
- (YYFloatingBallConfig *)config {
    if (!_config) {
        _config = [YYFloatingBallConfig new];
    }
    return _config;
}

#pragma mark - Methods
- (void)show {
    UIWindow *mainWindow = (UIWindow *)[UIApplication sharedApplication].windows.firstObject;
    self.fatherView = mainWindow;
    [mainWindow addSubview:self];
    self.frame = CGRectMake(self.config.defaultOrigin.x, self.config.defaultOrigin.y, self.config.size, self.config.size);
}
- (void)hiden {
    [self removeFromSuperview];
}
- (void)handleTap:(UIPanGestureRecognizer *)gesture {
    !self.tapBlock?:self.tapBlock();
}
- (void)handleLongTap:(UIPanGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        !self.longTapBlock?:self.longTapBlock();
    }
}
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.fatherView];
    // 移动浮球的中心点
    CGPoint newCenter = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y + translation.y);
    // 规避安全区域
    newCenter.x = MAX(gesture.view.frame.size.width / 2, newCenter.x);
    newCenter.x = MIN(self.fatherView.frame.size.width - gesture.view.frame.size.width / 2, newCenter.x);
    newCenter.y = MAX(gesture.view.frame.size.height / 2, newCenter.y);
    newCenter.y = MIN(self.fatherView.frame.size.height - gesture.view.frame.size.height / 2, newCenter.y);
    // 更新浮球的位置
    gesture.view.center = newCenter;
    [gesture setTranslation:CGPointZero inView:self.fatherView];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self snapFloatingButtonToEdge];
    }
}
- (void)snapFloatingButtonToEdge {
    CGFloat marginX = self.config.size*0.5; // 边缘间距
    CGFloat marginY = UIApplication.sharedApplication.keyWindow.safeAreaInsets.top + 20.f; // 边缘间距
    CGRect frame = self.frame;
    CGFloat centerX = CGRectGetMidX(frame);
    CGFloat centerY = CGRectGetMidY(frame);

    // 计算距离四个边缘的距离
    CGFloat distanceLeft = centerX - marginX;
    CGFloat distanceRight = self.fatherView.bounds.size.width - centerX - marginX;
    CGFloat distanceTop = centerY - marginY;
    CGFloat distanceBottom = self.fatherView.bounds.size.height - centerY - marginY;

    // 找到最小距离
    CGFloat minDistance = MIN(MIN(distanceLeft, distanceRight), MIN(distanceTop, distanceBottom));

    // 移动浮球到最近的边缘
    if (minDistance == distanceLeft) {
        [self animateFloatingButtonToEdge:CGPointMake(marginX, centerY)];
    } else if (minDistance == distanceRight) {
        [self animateFloatingButtonToEdge:CGPointMake(self.fatherView.bounds.size.width - marginX, centerY)];
    } else if (minDistance == distanceTop) {
        [self animateFloatingButtonToEdge:CGPointMake(centerX, marginY)];
    } else {
        [self animateFloatingButtonToEdge:CGPointMake(centerX, self.fatherView.bounds.size.height - marginY)];
    }
}

- (void)animateFloatingButtonToEdge:(CGPoint)edgePoint {
    [UIView animateWithDuration:0.25f
                              delay:0.0
             usingSpringWithDamping:0.7 // 弹性阻尼，0-1之间，值越小弹性效果越明显
              initialSpringVelocity:0.5 // 弹簧初始速度，正值表示向右，负值表示向左
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                           self.center = edgePoint;
                         }
                         completion:nil];
}

@end
