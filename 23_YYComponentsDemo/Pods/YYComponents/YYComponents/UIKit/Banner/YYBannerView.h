//
//  YYBannerView.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2020/10/21.
//  底层逻辑：CollectionView，0和最大值修改偏移量

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YYBannerScrollDirection) {
    /// 垂直方向
    YYBannerScrollDirectionVertical,
    /// 水平方向
    YYBannerScrollDirectionHorizontal,
};

NS_ASSUME_NONNULL_BEGIN

@interface YYBannerConfig : NSObject
/// 滚动方向[默认值：水平方向]
@property(nonatomic, assign) YYBannerScrollDirection scrollDirection;
/// 默认索引[默认值为：0]
@property(nonatomic, assign) NSUInteger defaultIndex;
/// 是否支持自动滚动[默认：YES]
@property(nonatomic, assign) BOOL autoScroll;
/// 自动滚动时间间隔[默认2s]
@property(nonatomic, assign) CGFloat autoScrollTimeInterval;
/// 是否支持无限滚动[默认：YES]
@property(nonatomic, assign) BOOL inFiniteLoop;
/// 是否支持手动滚动，该值不影响点击[默认：YES]
@property(nonatomic, assign) BOOL scrollGestureEnable;
/// 内容间距
@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/// 背景颜色
@property(nonatomic, strong) UIColor *backgroundColor;

@end

@interface YYBannerView : UIView
///=============================================================================
/// 使用方法：banner横向滚动
///=============================================================================
/*
 YYBannerView *bannerView = [YYBannerView bannerWithConfig:^(YYBannerConfig * _Nonnull config) {
     config.defaultIndex = 1;//默认显示的位置
     config.scrollDirection = YYBannerScrollDirectionHorizontal; //滚动方向
     config.autoScroll = YES;//是否支持横向滚动
     config.autoScrollTimeInterval = 3;//滚动的时间间隔
     config.scrollGestureEnable = YES;//是否允许手势拖动
 }];
 NSMutableArray *array = @[].mutableCopy;
 for (NSInteger index = 0; index < 5; index++) {
     NSString *name = [NSString stringWithFormat:@"%.3ld",(long)index + 1];
     [array addObject:[UIImage imageNamed:name]];
 }
 bannerView.dataSource = array;//数据源
 ///自定义显示内容
 bannerView.contentForItemAtIndex = ^UIView * _Nonnull(NSInteger index, UIView * _Nonnull superView) {
     UIImageView *imageView = [UIImageView new];
     imageView.userInteractionEnabled = YES;
     imageView.frame = superView.bounds;
     imageView.image = array[index];
     return imageView;
 };
 ///点击回调
 bannerView.didClickItemAtIndex = ^(NSInteger index) {
     NSLog(@"点击了%ld",index);
 };
 @weakify(self);
 ///index实时回调
 bannerView.currentPageCallback = ^(NSInteger currentPageIndex) {
     @strongify(self);
     self.pageControl.text = [NSString stringWithFormat:@"%ld/5",currentPageIndex + 1];
 };
 [self.view addSubview:bannerView];
 [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.right.inset(10.f);
     make.height.mas_equalTo(200.f);
     make.centerY.equalTo(self.view);
 }];
 */
///=============================================================================
/// 使用方法：轮播文本
///=============================================================================
/**
 YYBannerView *textScollView = [YYBannerView bannerWithConfig:^(YYBannerConfig * _Nonnull config) {
     config.defaultIndex = 1;
     config.scrollDirection = YYBannerScrollDirectionVertical;
     config.autoScroll = YES;
     config.autoScrollTimeInterval = 3;
     config.contentEdgeInsets = YYEdgeInsetsMakeSymmetric(5.f, 10.f);
     config.backgroundColor = UIColor.grayColor.yy_setAlpha(0.1f);
 }];
 NSArray *array = @[@"破难题强弱项提品质，民生保障有力有效",
                    @"一张写了8年的公约——社区基层治理的破解之路",
                    @"\"老文化\"也能很\"年轻\":台湾教师在广东讲述\"妈祖\"故事",
                    @"今日辟谣 北京地区网站联合辟谣平台 互联网联合辟谣平台",
                    @"最高悬赏20万！公安机关公开通缉10名缅北地区重大涉毒逃犯",
                    @"专题｜学习贯彻习近平新时代中国特色社会主义思想主题教育",
                    @"以驻韩大使馆发布\"哈马斯袭击首尔\"虚构视频 被骂到下架",
                    @"士兵虐待平民视频在互联网流传，印度当局切断互联网服务",];
 textScollView.dataSource = array;
 textScollView.contentForItemAtIndex = ^UIView * _Nonnull(NSInteger index, UIView * _Nonnull superView) {
     UILabel *label = [UILabel yy_labelWithConfig:^(YYLabelConfig * _Nonnull config) {
         config.textColor = UIColor.blackColor.yy_setAlpha(0.7f);
         config.font = [UIFont systemFontOfSize:16.f];
         config.textAlignment = NSTextAlignmentLeft;
     }];
     label.text = array[index];
     return label;
 };
 textScollView.didClickItemAtIndex = ^(NSInteger index) {
     NSLog(@"点击了:%@",array[index]);
 };
 [self.view addSubview:textScollView];
 [textScollView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.right.inset(10.f);
     make.height.mas_equalTo(40.f);
     make.top.equalTo(50.f);
 }];
 */
/**
 初始化
 @param config      配置文件
 */
+ (instancetype)bannerWithConfig:(void(^)(YYBannerConfig *config))config;
/// 数据源
@property(nonatomic, strong) NSArray *dataSource;
/// item显示内容
@property(nonatomic, copy) UIView *(^contentForItemAtIndex)(NSInteger index, UIView *superView);
/// 点击回调
@property(nonatomic, copy) void(^didClickItemAtIndex)(NSInteger index);
/// 当前index实时回调[从0开始计数]
@property(nonatomic, copy) void(^currentPageCallback)(NSInteger currentPageIndex);

@end

NS_ASSUME_NONNULL_END
