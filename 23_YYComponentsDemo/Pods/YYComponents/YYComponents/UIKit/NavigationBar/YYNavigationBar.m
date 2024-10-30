//
//  YYNavigationView.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2019/9/2.
//

#import "YYNavigationBar.h"
#import <YYComponents/YYLayout.h>

#define YYNAVIGATION_SCREEN_WITDH (UIScreen.mainScreen.bounds.size.width)
const CGFloat YYNAVIGATIONHEIGHT = 44.f;

static void *YYNAVIGATIONBARBACKTYPEKEY = &YYNAVIGATIONBARBACKTYPEKEY;
static void *YYNAVIGATIONBARSHOWBACKBTNKEY = &YYNAVIGATIONBARSHOWBACKBTNKEY;
static void *YYNAVIGATIONBARTITLEKEY = &YYNAVIGATIONBARTITLEKEY;
static void *YYNAVIGATIONBARHIDDENKEY = &YYNAVIGATIONBARHIDDENKEY;
static void *YYNAVIGATIONBARBACKCOLORKEY = &YYNAVIGATIONBARBACKCOLORKEY;
static void *YYNAVIGATIONBARBACKLEFTMARGINKEY = &YYNAVIGATIONBARBACKLEFTMARGINKEY;
static void *YYNAVIGATIONBARBACKSIZEKEY = &YYNAVIGATIONBARBACKSIZEKEY;
static void *YYNAVIGATIONBARSHOWLINEKEY = &YYNAVIGATIONBARSHOWLINEKEY;
static void *YYNAVIGATIONBARBGCOLORKEY = &YYNAVIGATIONBARBGCOLORKEY;
static void *YYNAVIGATIONBARBOTTOMCOLORKEY = &YYNAVIGATIONBARBOTTOMCOLORKEY;

@implementation YYNavigationBarConfig

- (instancetype)init {
    if (self = [super init]) {
        self.leftBtnType = YYNavigationBarLeftBtnTypeBack;
        self.showLeftBtn = NO;
        self.showNavigation = YES;
        self.leftBtnLeftMargin = 15.f;
        self.leftBtnWidth = 20.f;
        self.showBottomLine = YES;
        self.backgroundColor = UIColor.whiteColor;
        self.bottomLineColor = [UIColor.blackColor colorWithAlphaComponent:0.1];
    }
    return self;
}

@end

@interface YYNavigationBar()

@property(nonatomic, strong) YYNavigationBarConfig *config;

@property(nonatomic, strong) UIView *navigationBar;

@property(nonatomic, strong) UIView *leftView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *centerView;

@property(nonatomic, strong) UIView *rightView;

@property(nonatomic, strong) UIView *bottomLineView;

@end

@implementation YYNavigationBar

+ (instancetype)mainviewNavigationBarWithTitle:(nullable NSString *)title {
    return [self navigationBarWithConfig:^(YYNavigationBarConfig * _Nonnull config) {
        config.showLeftBtn = NO;
        config.title = title;
    }];
}

+ (instancetype)subpageNavigationBarWithTitle:(nullable NSString *)title {
    return [self navigationBarWithConfig:^(YYNavigationBarConfig * _Nonnull config) {
        config.showLeftBtn = YES;
        config.title = title;
    }];
}

+ (instancetype)navigationBarWithConfig:(nullable void(^)(YYNavigationBarConfig *config))configBlock {
    YYNavigationBar *bar = [self new];
    if (configBlock) {
        configBlock(bar.config);
    }
    CGFloat topMargin = [self safeDistanceTop];
    bar.frame = CGRectMake(0, 0, YYNAVIGATION_SCREEN_WITDH, topMargin + YYNAVIGATIONHEIGHT);
    bar.clipsToBounds = YES;
    bar.backgroundColor = bar.config.backgroundColor;
    [bar setupAllSubviews];
    [bar addObservers];
    return bar;
}

+ (CGFloat)safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

- (void)setupAllSubviews {
    [self addSubview:self.navigationBar];
    [self.navigationBar addSubview:self.leftView];
    [self.navigationBar addSubview:self.centerView];
    [self.navigationBar addSubview:self.rightView];
    [self.navigationBar addSubview:self.bottomLineView];
    [self.centerView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.bottom.equalToSuperview();
        make.left.greaterThenOrEqualTo(self.leftView.yy_right);
    }];
    [self.rightView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.top.bottom.right.equalToSuperview();
    }];
    [self.bottomLineView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
        make.left.right.bottom.equalToSuperview();
        make.height.yy_equalTo(0.6f);
    }];
}
#pragma mark - Lazy load
- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [UIView new];
//        _navigationBar.backgroundColor = UIColor.yellowColor;
        CGFloat y = [YYNavigationBar safeDistanceTop];
        CGFloat h = YYNAVIGATIONHEIGHT;
        CGFloat w = YYNAVIGATION_SCREEN_WITDH;
        _navigationBar.frame = CGRectMake(0, y, w, h);
    }
    return _navigationBar;
}
- (YYNavigationBarConfig *)config {
    if (!_config) {
        _config = [YYNavigationBarConfig new];
    }
    return _config;
}
- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.hidden = YES;
        _leftView.frame = CGRectMake(0, 0, YYNAVIGATIONHEIGHT*1.2f, YYNAVIGATIONHEIGHT);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewClickAction)];
        [_leftView addGestureRecognizer:tap];
        UIView *leftView = [self _leftViewWtihType:YYNavigationBarLeftBtnTypeBack];
        [_leftView addSubview:leftView];
    }
    return _leftView;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerViewClickAction)];
        [_centerView addGestureRecognizer:tap];
    }
    return _centerView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = UIColor.blackColor;
    }
    return _titleLabel;
}
- (UIView *)rightView {
    if (!_rightView) {
        _rightView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightViewClickAction)];
        [_rightView addGestureRecognizer:tap];
    }
    return _rightView;
}
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = self.config.bottomLineColor;
    }
    return _bottomLineView;
}

#pragma mark - Mehods
- (UIView *)_leftViewWtihType:(YYNavigationBarLeftBtnType)btnType {
    if (btnType == YYNavigationBarLeftBtnTypeBack) {
        return [self backView];
    } else if (btnType == YYNavigationBarLeftBtnTypeClose) {
        return [self closeView];
    }
    return UIView.new;
}
///画返回按钮
- (UIView *)backView {
    CGFloat width = 2.f;
    CGFloat backViewWidth = self.config.leftBtnWidth;
    CGFloat backViewX = -backViewWidth*0.5 + self.config.leftBtnLeftMargin;
    CGFloat backViewY = (YYNAVIGATIONHEIGHT - backViewWidth)*0.5;
    CGFloat length = backViewWidth*0.5;
    UIColor *color = UIColor.blackColor;
    UIView *backView = [UIView new];
    backView.frame = CGRectMake(backViewX, backViewY, backViewWidth, backViewWidth);
    UIView *HView = [UIView new];
    HView.frame = CGRectMake(0, (backViewWidth - width)*0.5, length, width);
    HView.backgroundColor = color;
    [backView addSubview:HView];

    UIView *VView = [UIView new];
    VView.backgroundColor = color;
    VView.frame = CGRectMake((backViewWidth - width)*0.5, (backViewWidth - width)*0.5, width, length + width*0.5);
    [backView addSubview:VView];
    backView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -3*M_PI_4);
    return backView;
}

///画关闭按钮
- (UIView *)closeView {
    CGFloat width = 2.f;
    CGFloat closeViewWidth = self.config.leftBtnWidth;
    CGFloat offsetX = sqrt(pow(closeViewWidth,2)*2)*0.5f - closeViewWidth*0.5 - sqrt(pow(closeViewWidth*0.5,2)*0.5);
    CGFloat closeViewX = offsetX + self.config.leftBtnLeftMargin;
    CGFloat closeViewY = (YYNAVIGATIONHEIGHT - closeViewWidth)*0.5;
    UIColor *color = UIColor.blackColor;
    UIView *closeView = [UIView new];
//    closeView.backgroundColor = UIColor.redColor;
    closeView.frame = CGRectMake(closeViewX, closeViewY, closeViewWidth, closeViewWidth);
    UIView *HView = [UIView new];
    HView.frame = CGRectMake(0, (closeViewWidth - width)*0.5, closeViewWidth, width);
    HView.backgroundColor = color;
    [closeView addSubview:HView];

    UIView *VView = [UIView new];
    VView.backgroundColor = color;
    VView.frame = CGRectMake((closeViewWidth - width)*0.5, 0, width, closeViewWidth);
    [closeView addSubview:VView];
    closeView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -3*M_PI_4);
    return closeView;
}
- (void)relayout {
    [self.rightView layoutIfNeeded];
    [self.centerView layoutIfNeeded];
    CGFloat rightviewWidth = self.rightView.bounds.size.width;
    CGFloat centerviewWidth = self.centerView.bounds.size.width;
    //如果center和right都没有内容
    if (centerviewWidth < 1.f && rightviewWidth < 1.f){
        self.centerView.hidden = YES;
        self.rightView.hidden = YES;
    } else if (centerviewWidth > 1.f && rightviewWidth < 1.f) {
        self.centerView.hidden = NO;
        self.rightView.hidden = YES;
        [self.centerView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
            make.top.bottom.centerX.equalToSuperview();
            make.left.equalTo(self.leftView.yy_right);
        }];
    } else if (centerviewWidth < 1.f && rightviewWidth > 1.f) {
        self.centerView.hidden = YES;
        self.rightView.hidden = NO;
        [self.rightView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
            make.right.top.bottom.equalToSuperview();
            make.left.greaterThenOrEqualTo(self.leftView.yy_right);
        }];
    } else {
        self.centerView.hidden = NO;
        self.rightView.hidden = NO;
        CGFloat space = YYNAVIGATION_SCREEN_WITDH*0.5 - rightviewWidth;
        CGFloat rightcontentMaxwidth = YYNAVIGATION_SCREEN_WITDH*0.32f;
        if (space*2 < centerviewWidth) {
            if (rightviewWidth < rightcontentMaxwidth) {
                [self.rightView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
                    make.right.top.bottom.equalToSuperview();
                    make.width.yy_equalTo(rightviewWidth);
                }];
                [self.centerView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
                    make.top.bottom.centerX.equalToSuperview();
                    make.right.equalTo(self.rightView.yy_left);
                }];
            } else {
                [self.rightView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
                    make.top.bottom.right.equalToSuperview();
                    make.width.yy_equalTo(rightcontentMaxwidth);
                }];
                [self.centerView yy_remakeLayout:^(YYLayoutMaker * _Nonnull make) {
                    make.top.bottom.centerX.equalToSuperview();
                    make.right.equalTo(self.rightView.yy_left);
                }];
            }
        }
    }
}

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"config.showLeftBtn" options:options context:YYNAVIGATIONBARSHOWBACKBTNKEY];
    [self addObserver:self forKeyPath:@"config.title" options:options context:YYNAVIGATIONBARTITLEKEY];
    [self addObserver:self forKeyPath:@"config.showNavigation" options:options context:YYNAVIGATIONBARHIDDENKEY];
    [self addObserver:self forKeyPath:@"config.leftBtnColor" options:options context:YYNAVIGATIONBARBACKCOLORKEY];
    [self addObserver:self forKeyPath:@"config.leftBtnLeftMargin" options:options context:YYNAVIGATIONBARBACKLEFTMARGINKEY];
    [self addObserver:self forKeyPath:@"config.leftBtnType" options:options context:YYNAVIGATIONBARBACKTYPEKEY];
    [self addObserver:self forKeyPath:@"config.leftBtnWidth" options:options context:YYNAVIGATIONBARBACKSIZEKEY];
    [self addObserver:self forKeyPath:@"config.showBottomLine" options:options context:YYNAVIGATIONBARSHOWLINEKEY];
    [self addObserver:self forKeyPath:@"config.backgroundColor" options:options context:YYNAVIGATIONBARBGCOLORKEY];
    [self addObserver:self forKeyPath:@"config.bottomLineColor" options:options context:YYNAVIGATIONBARBOTTOMCOLORKEY];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == YYNAVIGATIONBARSHOWBACKBTNKEY) {
        BOOL showBackBtn = [change[@"new"] boolValue];
        self.leftView.hidden = !showBackBtn;
    }else if (context == YYNAVIGATIONBARTITLEKEY) {
        NSString *title = change[@"new"];
        self.titleLabel.text = title;
        [self addCustomTitleView:self.titleLabel layout:^(UIView * _Nonnull titleView, UIView * _Nonnull superView) {
            [titleView yy_makeLayout:^(YYLayoutMaker * _Nonnull make) {
                make.left.right.top.bottom.equalToSuperview();
            }];
        }];
    }else if (context == YYNAVIGATIONBARHIDDENKEY) {
        BOOL showNavigation = [change[@"new"] boolValue];
        CGFloat topMargin = [YYNavigationBar safeDistanceTop];
        CGFloat height = showNavigation ? topMargin + 44.f : CGFLOAT_MIN;
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, height);
        !self.needRelayoutCallback?:self.needRelayoutCallback(showNavigation);
    } else if (context == YYNAVIGATIONBARBACKCOLORKEY) {
        UIColor *color = change[@"new"];
        if (color) {
            UIView *backView = self.leftView.subviews.firstObject;
            for (UIView *subview in backView.subviews) {
                subview.backgroundColor = color;
            }
        }
    } else if (context == YYNAVIGATIONBARBACKLEFTMARGINKEY) {
        self.config.leftBtnType = self.config.leftBtnType;
    }else if (context == YYNAVIGATIONBARBACKTYPEKEY) {
        YYNavigationBarLeftBtnType type = [change[@"new"] intValue];
        UIView *leftview = self.leftView.subviews.firstObject;
        [leftview removeFromSuperview];
        [self.leftView addSubview:[self _leftViewWtihType:type]];
    }else if (context == YYNAVIGATIONBARBACKSIZEKEY) {
        self.config.leftBtnType = self.config.leftBtnType;
    }else if (context == YYNAVIGATIONBARSHOWLINEKEY) {
        BOOL show = [change[@"new"] boolValue];
        self.bottomLineView.hidden = !show;
    }else if (context == YYNAVIGATIONBARBGCOLORKEY) {
        UIColor *color = change[@"new"];
        if (color) {
            self.backgroundColor = color;
        }
    }else if (context == YYNAVIGATIONBARBOTTOMCOLORKEY) {
        UIColor *color = change[@"new"];
        if (color) {
            self.bottomLineView.backgroundColor = color;
        }
    }
}
- (void)leftViewClickAction {
    if (!self.config.showLeftBtn) { return; }
    !self.leftViewClickCallback?:self.leftViewClickCallback();
}
- (void)centerViewClickAction {
    !self.centerViewClickCallback?:self.centerViewClickCallback();
}
- (void)rightViewClickAction {
    !self.rightViewClickCallback?:self.rightViewClickCallback();
}

#pragma mark - Interface

- (void)addCustomTitleView:(UIView *)titleView
                    layout:(nullable void(^)(UIView *titleView, UIView *superView))layout {
    if (self.config.showNavigation == NO) {
        self.config.showNavigation = YES;
    }
    [self.centerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.centerView addSubview:titleView];
    if (layout) {
        layout(titleView, self.centerView);
    }
    [self relayout];
}
- (void)addRightItemView:(UIView*)rightView
              layout:(nullable void(^)(UIView *titleView, UIView *superView))layout {
    if (self.config.showNavigation == NO) {
        self.config.showNavigation = YES;
    }
    [self.rightView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightView addSubview:rightView];
    if (layout) {
        layout(rightView, self.rightView);
    }
    [self relayout];
}

@end
