//
//  YYBottomSheetView.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2022/10/17.
//  Copyright © 2022 GitHub. All rights reserved.
//

#import "YYBottomSheetView.h"
#import <YYComponents/YYLayout.h>

#define YY_ALERT_VIEW_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define YY_ALERT_VIEW_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

@interface YYBottomSheetScrollView : UIScrollView

@end

@implementation YYBottomSheetScrollView
///支持多个PanGestureRecognizer
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end

@interface YYBottomSheetConfig()

/// 当前视图是否展示
@property(nonatomic, assign) BOOL isShow;

@end

@implementation YYBottomSheetConfig

- (instancetype)init {
    if (self = [super init]) {
        self.showCloseButton = YES;
        self.closeBtnWidth = 20.f;
        self.closeBtnTopMargin = 10.f;
        self.closeBtnRightMargin = 10.f;
        self.supportDrag = YES;
        self.dragCloseOffset = 50.f;
    }
    return self;
}

- (CGFloat)maxHeight {
    if (_maxHeight <= 0 || _maxHeight >= YY_ALERT_VIEW_SCREEN_HEIGHT * 0.8f){
        return YY_ALERT_VIEW_SCREEN_HEIGHT * 0.8f;
    }
    return _maxHeight;
}

- (CGFloat)closeButtonWidth {
    if (_closeBtnWidth <= 0) {
        return 20.f;
    }
    return _closeBtnWidth;
}

//- (UIEdgeInsets)contentInsets {
//    if (_contentInsets.left == 0 && _contentInsets.right == 0 && _contentInsets.top == 0 && _contentInsets.bottom == 0) {
//        return UIEdgeInsetsMake(0, 16, 0, 16);
//    }
//    return _contentInsets;
//}
- (UIEdgeInsets)titleViewInsets {
    if (_titleViewInsets.left == 0 && _titleViewInsets.right == 0 && _titleViewInsets.top == 0 && _titleViewInsets.bottom == 0) {
        return UIEdgeInsetsMake(0, self.contentInsets.left, 0, self.contentInsets.right);
    }
    return _titleViewInsets;
}
- (UIColor *)backgroundColor {
    if (_backgroundColor == nil){
        return UIColor.whiteColor;
    }
    return _backgroundColor;
}
@end
@interface YYBottomSheetView()<UIScrollViewDelegate>
/// 适配器
@property(nonatomic, strong) YYBottomSheetConfig *config;
/// 灰色点击区域
@property(strong, nonatomic) UIView *topHolderView;
/// 动画视图
@property(nonatomic, strong) UIView *animationView;
/// 展示视图
@property(nonatomic, strong) UIView *showView;
/// 顶部圆角视图
@property(nonatomic, strong) UIView *topCornerView;
/// 关闭按钮
@property(strong, nonatomic) UIButton *closeBtn;
/// 关闭按钮宽度
@property(nonatomic, assign) CGFloat clostBtnWidth;
/// 标题区域
@property(nonatomic, strong) UIView *titleView;
/// 内容父视图
@property(nonatomic, strong) UIView *innerContentView;
/// 顶部
@property(nonatomic, strong) UIView *topView;
/// 滚动视图
@property(nonatomic, strong) YYBottomSheetScrollView *scrollView;
/// 中间内容
@property(nonatomic, strong) UIView *middleContentView;
/// 底部[避开安全区域]
@property(nonatomic, strong) UIView *bottomView;
/// 动画原始frame
@property(nonatomic, assign) CGRect animationViewOriginFrame;

@end

const CGFloat TOP_CORNER_HEIGHT = 16.f;
const CGFloat YY_ANIMATION_DURATION = 0.25f;

@implementation YYBottomSheetView

/**
 初始化方法
 @return                 对象
 */
+ (instancetype)bottomSheet {
    return [self bottomSheetWithConfig:nil];
}

/**
 初始化方法
 @param configBlock      配置
 @return                 对象
 */
+ (instancetype)bottomSheetWithConfig:(void(^__nullable)(YYBottomSheetConfig *config))configBlock {
    YYBottomSheetView *bottomSheetView = [self new];
    if (configBlock) {
        YYBottomSheetConfig *config = [YYBottomSheetConfig new];
        bottomSheetView.config = config;
        configBlock(config);
        [bottomSheetView setUpViews];
    } else {
        [bottomSheetView setUpViews];
    }
    return bottomSheetView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.1f];
    }
    return self;
}

- (void)setUpViews {
    CGFloat closeBtnTopMargin = self.config.closeBtnTopMargin;
    CGFloat closeBtnRightMargin = self.config.closeBtnRightMargin;
    CGFloat closeBtnWidth = self.config.closeButtonWidth;
    BOOL showCloseBtn = self.config.showCloseButton;
    
    CGFloat titleViewBottomTop = self.config.titleViewInsets.top;
    CGFloat titleViewBottomMargin = self.config.titleViewInsets.bottom;
    CGFloat titleViewLeftMargin = self.config.titleViewInsets.left;
    CGFloat titleViewRightMargin = self.config.titleViewInsets.right;
    
    CGFloat contentTopMargin = self.config.contentInsets.top;
    CGFloat contentBottomMargin = self.config.contentInsets.bottom;
    CGFloat contentLeftMargin = self.config.contentInsets.left;
    CGFloat contentRightMargin = self.config.contentInsets.right;

    [self.topCornerView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.greaterThenOrEqualToSuperview();
        make.left.right.equalTo(self.animationView);
        make.height.yy_equalTo(TOP_CORNER_HEIGHT);
    }];
    [self.showView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.left.right.bottom.equalTo(self.animationView);
        ///解决在某些机型上topCornerView与showView连接处有分割线的bug
        make.top.equalTo(self.topCornerView.yy_bottom).offset(-0.5f);
    }];
    
    [self.topHolderView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.left.right.equalToSuperview();
        make.bottom.equalTo(self.showView.yy_top);
    }];
    
    [self.titleView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.equalToSuperview().offset(titleViewBottomTop);
        make.left.equalToSuperview().offset(titleViewLeftMargin);
        make.right.equalToSuperview().offset(-titleViewRightMargin);
        make.height.yy_equalTo(CGFLOAT_MIN);
    }];
    self.closeBtn.hidden = !showCloseBtn;
    [self.closeBtn yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.width.height.yy_equalTo(closeBtnWidth);
        make.right.yy_equalTo(-closeBtnRightMargin);
        make.top.yy_equalTo(closeBtnTopMargin - TOP_CORNER_HEIGHT);
        if (!showCloseBtn) {
            make.height.yy_equalTo(CGFLOAT_MIN);
        }
    }];
    [self.innerContentView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.left.yy_equalTo(contentLeftMargin);
        make.right.yy_equalTo(-contentRightMargin);
        make.top.equalTo(self.closeBtn.yy_bottom).offset(titleViewBottomMargin + contentTopMargin);
        make.bottom.yy_equalTo(-([self safeAreaBottom] + contentBottomMargin));
    }];
    
    [self.topView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.left.right.top.equalToSuperview();
        make.height.yy_equalTo(CGFLOAT_MIN);
    }];
    
    [self.scrollView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.equalTo(self.topView.yy_bottom);
        make.left.right.width.equalTo(self.innerContentView);
    }];
    
    [self.middleContentView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.left.right.top.bottom.width.equalTo(self.scrollView);
        make.height.yy_equalTo(CGFLOAT_MIN);
    }];
    [self.bottomView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.equalTo(self.scrollView.yy_bottom);
        make.left.right.bottom.equalTo(self.innerContentView);
        make.height.yy_equalTo(CGFLOAT_MIN);
    }];
}

#pragma mark - Lazy Load
- (YYBottomSheetConfig *)config {
    if (!_config){
        _config = [YYBottomSheetConfig new];
    }
    return _config;
}
- (UIView *)topHolderView {
    if (!_topHolderView) {
        _topHolderView = UIView.new;
        _topHolderView.translatesAutoresizingMaskIntoConstraints = NO;
        _topHolderView.backgroundColor = UIColor.clearColor;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_topHolderView addGestureRecognizer:tapGesture];
        [self addSubview:_topHolderView];
    }
    return _topHolderView;
}
- (UIView *)animationView {
    if (!_animationView){
        _animationView = [UIView new];
        _animationView.frame = CGRectMake(0, YY_ALERT_VIEW_SCREEN_HEIGHT, YY_ALERT_VIEW_SCREEN_WIDTH, YY_ALERT_VIEW_SCREEN_HEIGHT*0.8f);
        [self addSubview:_animationView];
    }
    return _animationView;
}
- (UIView *)showView {
    if (!_showView){
        _showView = [UIView new];
        _showView.translatesAutoresizingMaskIntoConstraints = NO;
        _showView.backgroundColor = UIColor.whiteColor;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [_showView addGestureRecognizer:panGesture];
        [self.animationView addSubview:_showView];
    }
    return _showView;
}
- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    if (!self.config.supportDrag) {return;}
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        self.scrollView.scrollEnabled = YES;
    }
    CGPoint point = [panGesture translationInView:self];
    CGFloat pointY = point.y;
    if (pointY < 0) {return;}
    if (self.scrollView.contentOffset.y > 0 ) {return;}
    CGRect animationViewRect = self.animationView.frame;
    switch (panGesture.state) {
        case UIGestureRecognizerStateChanged:
            animationViewRect.origin.y = self.animationViewOriginFrame.origin.y + pointY;
            self.animationView.frame = animationViewRect;
            self.scrollView.scrollEnabled = NO;
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.scrollView.scrollEnabled = YES;
//            CGPoint point = [self.animationView convertPoint:self.showView.frame.origin toView:self];
//            CGFloat contentVisibleHeight = YY_ALERT_VIEW_SCREEN_HEIGHT - point.y;
//            CGFloat contentHeightLimit = self.showView.frame.size.height/3.f;
//            if (contentVisibleHeight <= 50) {
//                [self close];
//            } else {
//                [self showanimationViewWithAnimation];
//            }
            if (pointY >= self.config.dragCloseOffset) {
                [self close];
            } else {
                [self showanimationViewWithAnimation];
            }
            self.animationViewOriginFrame = self.animationView.frame;
        }
            break;
        default:
            break;
    }
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *closeIconView = [self closeIconView];
        closeIconView.userInteractionEnabled = NO;
        [_closeBtn addSubview:closeIconView];
        [closeIconView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
            make.left.right.top.bottom.equalTo(self->_closeBtn);
        }];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:_closeBtn];
    }
    return _closeBtn;
}
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.showView addSubview:_titleView];
    }
    return _titleView;
}
- (UIView *)innerContentView {
    if (!_innerContentView){
        _innerContentView = [UIView new];
        [self.showView addSubview:_innerContentView];
    }
    return _innerContentView;
}
- (UIView *)topView {
    if (!_topView){
        _topView = [UIView new];
        [self.innerContentView addSubview:_topView];
    }
    return _topView;
}
- (UIView *)topCornerView {
    if (!_topCornerView) {
        _topCornerView = [UIView new];
        _topCornerView.backgroundColor = UIColor.whiteColor;
        _topCornerView.translatesAutoresizingMaskIntoConstraints = NO;
        CGRect bounds = CGRectMake(0, 0, YY_ALERT_VIEW_SCREEN_WIDTH, TOP_CORNER_HEIGHT);
        _topCornerView.bounds = bounds;
        [self cornerRoundedWithView:_topCornerView roundedRect:bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(TOP_CORNER_HEIGHT*0.5f,TOP_CORNER_HEIGHT*0.5f)];
        [self.animationView addSubview:_topCornerView];
    }
    return _topCornerView;
}
- (UIView *)bottomView {
    if (!_bottomView){
        _bottomView = [UIView new];
        [self.innerContentView addSubview:_bottomView];
    }
    return _bottomView;
}
- (YYBottomSheetScrollView *)scrollView {
    if (!_scrollView){
        _scrollView = [YYBottomSheetScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.innerContentView addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)middleContentView {
    if (!_middleContentView){
        _middleContentView = [UIView new];
        [self.scrollView addSubview:_middleContentView];
    }
    return _middleContentView;
}
#pragma mark - Methods
/**
 关闭弹框
 */
- (void)close {
    __weak typeof(self) weakSelf = self;
    [self closeAnimationViewWithAnimationCompletion:^{
        [weakSelf removeFromSuperview];
        weakSelf.config.isShow = NO;
        !weakSelf.dismissAnimationFinish?:weakSelf.dismissAnimationFinish();
    }];
}
/**
 添加标题视图
 @param titleView         标题视图
 @param titleViewLayoutBlock   标题视图布局
 */
- (void)addTitleView:(nonnull UIView *)titleView
     titleViewLayout:(void(^__nonnull)(UIView *superView, UIView *titleView))titleViewLayoutBlock {
    [self.titleView addSubview:titleView];
    if (titleViewLayoutBlock) {
        if (self.config.showCloseButton) {
            CGFloat closeBtnRightMargin = self.config.closeBtnRightMargin;
            [self.closeBtn yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
                make.width.height.yy_equalTo(self.config.closeBtnWidth);
                make.right.yy_equalTo(-closeBtnRightMargin);
                make.centerY.equalTo(self.titleView.yy_centerY);
            }];
        }
        [self.titleView yy_remakeLayout:^(YYLayoutMaker *make) {
            make.top.yy_equalTo(self.config.titleViewInsets.top);
            make.left.yy_equalTo(self.config.titleViewInsets.left);
            make.right.yy_equalTo(-self.config.titleViewInsets.right);
            if (self.config.showCloseButton) {
                make.height.yy_greaterThenOrEqualTo(self.config.closeButtonWidth);
            }
        }];
        [self.innerContentView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
            make.left.yy_equalTo(self.config.contentInsets.left);
            make.right.yy_equalTo(-self.config.contentInsets.right);
            make.top.equalTo(self.titleView.yy_bottom).offset(self.config.titleViewInsets.bottom + self.config.contentInsets.top);
            make.bottom.yy_equalTo(-([self safeAreaBottom] + self.config.titleViewInsets.bottom));
        }];
        titleViewLayoutBlock(self.titleView,titleView);
    }
}
/**
 添加顶部视图
 @param topView         顶部视图
 @param topViewLayoutBlock   顶部视图布局
 */
- (void)addTopView:(nonnull UIView *)topView
     topViewLayout:(void(^__nonnull)(UIView *superView, UIView *topView))topViewLayoutBlock {
//    [self.topView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
//        make.left.right.top.equalToSuperview();
//    }];
    [self.topView yy_removeConstraint:NSLayoutAttributeHeight];
    [self.topView addSubview:topView];
    !topViewLayoutBlock?:topViewLayoutBlock(self.topView,topView);
}
/**
 添加内容视图[内容超过指定高度（maxHeight）可滚动]
 @param contentView          内容视图
 @param contentViewLayoutBlock    内容视图布局
 */
- (void)addContentView:(nonnull UIView *)contentView
           contentViewLayout:(void(^__nonnull)(UIView *superView, UIView *contentView))contentViewLayoutBlock {
    [self.middleContentView yy_removeConstraint:NSLayoutAttributeHeight];
    [self.middleContentView addSubview:contentView];
    !contentViewLayoutBlock?:contentViewLayoutBlock(self.middleContentView,contentView);
}
/**
 添加底部视图
 @param bottomView       底部视图
 @param bottomViewLayout 底部视图布局
 */
- (void)addBottomView:(nonnull UIView *)bottomView
     bottomViewLayout:(void(^__nonnull)(UIView *superView, UIView *bottomView))bottomViewLayout {
    [self.bottomView yy_removeConstraint:NSLayoutAttributeHeight];
    [self.bottomView addSubview:bottomView];
    !bottomViewLayout?:bottomViewLayout(self.bottomView,bottomView);
}
/**
 显示动画
 */
- (void)showanimationViewWithAnimation {
    [self resetScrollViewHeight];
    [UIView animateWithDuration:YY_ANIMATION_DURATION animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.6f];
        CGRect animationViewFrame = CGRectMake(0, YY_ALERT_VIEW_SCREEN_HEIGHT*0.2f, YY_ALERT_VIEW_SCREEN_WIDTH, YY_ALERT_VIEW_SCREEN_HEIGHT*0.8f);
        self.animationView.frame = animationViewFrame;
        self.animationViewOriginFrame = animationViewFrame;
    } completion:^(BOOL finished) {
        !self.showAnimationFinish?:self.showAnimationFinish();
    }];
}
/**
 关闭动画
 */
- (void)closeAnimationViewWithAnimationCompletion:(void(^)(void))completion {
    [UIView animateWithDuration:YY_ANIMATION_DURATION animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.animationView.frame = CGRectMake(0, YY_ALERT_VIEW_SCREEN_HEIGHT, YY_ALERT_VIEW_SCREEN_WIDTH, YY_ALERT_VIEW_SCREEN_HEIGHT*0.8f);
    } completion:^(BOOL finished) {
        !completion?:completion();
    }];
}
/**
 设置指定方向圆角
 @param rect         坐标
 @param corners      方向
 @param cornerRadii  圆角
 */
- (void)cornerRoundedWithView:(UIView *)view
                  roundedRect:(CGRect)rect
            byRoundingCorners:(UIRectCorner)corners
                  cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
/**
 显示内容
 @param superView   父视图
 */
- (void)showAlertViewOnView:(UIView * _Nullable)superView {
    if (superView == nil){
        superView = UIApplication.sharedApplication.keyWindow;
    }
    self.frame = UIScreen.mainScreen.bounds;
    self.config.isShow = YES;
    [superView addSubview:self];
    [self showanimationViewWithAnimation];
}
- (void)showAlertView {
    [self showAlertViewOnView:nil];
}
/**
 重置滚动视图的height
 */
- (void)resetScrollViewHeight {
    [self layoutIfNeeded];
    CGFloat middleContentViewHeight = self.middleContentView.bounds.size.height;
    CGFloat titleViewHeight = self.titleView.bounds.size.height;
    CGFloat topViewHeight = self.topView.bounds.size.height;
    CGFloat bottomViewHeight = self.bottomView.bounds.size.height;
    CGFloat contentFrameY = self.innerContentView.frame.origin.y;
    CGFloat bottomMargin = [self safeAreaBottom] + self.config.contentInsets.bottom;
    CGFloat contentMaxHeight = MAX(self.config.maxHeight - titleViewHeight - TOP_CORNER_HEIGHT - contentFrameY - topViewHeight - bottomViewHeight - bottomMargin, 0.f);
    [self.scrollView yy_updateLayout:^(YYLayoutMaker * _Nonnull make) {
        make.height.yy_equalTo(MIN(middleContentViewHeight, contentMaxHeight));
    }];
    [self updateConstraintsIfNeeded];
}
- (CGFloat)safeAreaBottom {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        return 0.f;
    }
}
///画关闭按钮
- (UIView *)closeIconView {
    UIView *closeBgView = [UIView new];
    UIView *HView = [UIView new];
    HView.backgroundColor = UIColor.blackColor;
    [closeBgView addSubview:HView];
    [HView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.height.yy_equalTo(2.f);
        make.left.right.centerY.equalTo(closeBgView);
    }];
    
    UIView *VView = [UIView new];
    VView.backgroundColor = UIColor.blackColor;
    [closeBgView addSubview:VView];
    [VView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.width.yy_equalTo(2.f);
        make.top.bottom.centerX.equalTo(closeBgView);
    }];
    closeBgView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
    return closeBgView;
}
///重写hitTest方法，让topCornerView的拖拽事件由self.showView的响应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint topCornerViewP = [self convertPoint:point toView:self.topCornerView];
    if ([self.topCornerView pointInside:topCornerViewP withEvent:event]) {
        return self.showView;
    }
    return [super hitTest:point withEvent:event];
}
@end

