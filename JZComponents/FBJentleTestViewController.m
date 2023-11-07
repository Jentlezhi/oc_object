//
//  FBJentleTestViewController.m
//  fenbeitong
//
//  Created by Jentle-Zhi on 2022/8/16.
//  Copyright © 2022 FinHub. All rights reserved.
//

#import "FBJentleTestViewController.h"
#import "FBTrainOrderCreateViewController.h"
#import "FBTrainOrderCreateTrainSeatView.h"
#import "FBHalfAlertView.h"
#import "FBTrainDetailDirectCardView.h"
#import "FBTrainOrderCreateCommitView.h"
#import "FBTrainRefuseAndChangeTrainCardView.h"
#import "FBCommonPopView.h"
#import "FBTrainRefuseChangeDetailView.h"
#import "FBTrainNavigationView.h"
#import "FBTrainNewCardView.h"
#import "FBScrollCalendarView.h"
#import "FBTimeCounterView.h"
#import "FBTrainDirectDetailCounterView.h"
#import "FBTrainTransferCardView.h"
#import "FBBookTrainTicketWithLoginAlertView.h"
#import "FBBookTrainTicketWithLoginAlertView.h"
#import "FBEnterpriseSelectAlertView.h"
#import "FBEnterpriseSwitchView.h"
#import "FBOrderNotifierView.h"
#import "FBPlaneApplyAlertView.h"
#import "FBTrainTransferCell.h"
#import "FBSkeletonView.h"
#import "FBTrainStationShowView.h"
#import "FBCommonModule-Swift.h"
#import "FBAttributedLabelString.h"
#import "FBCustomButtonsView.h"

@interface FBJentleTestViewController ()

@property(nonatomic, strong) UIButton *btn;
/// 卡片
@property(nonatomic, strong) FBTrainNewCardView *cardView;
@property(nonatomic, strong) FBScrollCalendarView *calendarView;

@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, strong) FBBookTrainTicketWithLoginAlertView *alertView;
/// <#注释#>
@property(nonatomic, strong) FBEnterpriseSelectAlertView *selectAlertView;
/// <#注释#>
@property(nonatomic, strong) FBEnterpriseSwitchView *switchView;
@end

@implementation FBJentleTestViewController

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btn setTitle:@"跳转到主视图" forState:UIControlStateNormal];
        @weakify(self);
        [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            FBTrainOrderCreateViewController *vc = FBTrainOrderCreateViewController.new;
//            vc.travelType = FBTrainTravelTypeTransfer;
//            UIViewController *vc = FBMessageViewController.new;
//            UIViewController *vc = FBTrainServiceViewController.new;
//            UIViewController *vc = FBScheduleHomeController.new;
//            UIViewController *vc = FBWorkbenchHomeV5Controller.new;
            [self.navigationController pushViewController:vc animated:YES];
//            FBTrainDetailInfoDirectDetailView *detail = FBTrainDetailInfoDirectDetailView.new;
//
//            detail.topMargin = 100.f;
//            [detail showAlertView];
            ///懒加载
//            [self.selectAlertView showOnView:self.view];
//            [self planeMakeChart];
        }];
    }
    return _btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"INJECTION_BUNDLE_NOTIFICATION" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self reloadViews];
     }];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
//    [self planeMakeChart];
//    [self reloadViews];
    
    return;

    FBEnterpriseSwitchView *switchView = [FBEnterpriseSwitchView new];
    switchView.backgroundColor = UIColor.randomColor;
    //内容间距
    switchView.contentInsets = UIEdgeInsetsMake(10.f, 16.f, 10.f, 16.f);
    switchView.clickCallback = ^{
        [self.view showHudText:@"切换企业"];
    };
    switchView.explanationButtonClickCallback = ^{
        [self.view showHudText:@"叹号的点击"];
    };
    switchView.enterpriseTitle = @"北京分贝通科技有限公司北京分贝通科技有限公司北京分贝通科技有限公司北京分贝通科技有限公司";
    [self.view addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
}
- (void)addBaseView {
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottomMargin);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self reloadViews];
}
- (FBBookTrainTicketWithLoginAlertView *)alertView {
    if (!_alertView) {
        _alertView = FBBookTrainTicketWithLoginAlertView.new;
        _alertView.leftBtnTitle = @"继续登录12306";
        _alertView.rightBtnTitle = @"免登录购票";
        @weakify(self);
        _alertView.rightBtnClickCallback = ^{
            @strongify(self);
            
        };
    }
    return _alertView;
}
- (void)reloadViews {
//    [self.view removeAllSubviews];
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FBLog(@"signalA");
//            [subscriber sendNext:@"signalA"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FBLog(@"signalB");
            [subscriber sendCompleted];
        });
        return nil;
    }];
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FBLog(@"signalC");
            [subscriber sendCompleted];
        });
        return nil;
    }];
    [[[signalA concat:signalB] concat:signalC] subscribeNext:^(id  _Nullable x) {
        FBLog(@"%@",x);
    }];
}
- (void)btnsView {
    FBCustomButtonsViewModel *viewModel = [FBCustomButtonsViewModel new];
    viewModel.contentInsets = UIEdgeInsetsMake(8, 24, 8, 24);
    viewModel.itemSpace = 10;
    FBCustomButtonsConfig *congfig = [FBCustomButtonsConfig new];
    congfig.backgroundColor = UIColor.whiteColor;
    congfig.text = @"取消";
    congfig.textFont = FBBoldFont(16);
    congfig.textColor = FBColorConst.textBlack;
    congfig.borderColor = FBColorConst.textLightGray;
    viewModel.buttonConfigs = @[congfig];
    
    FBCustomButtonsConfig *congfig1 = [FBCustomButtonsConfig new];
    congfig1.backgroundColor = FBColorConst.mainOrange;
    congfig1.text = @"确定";
    congfig1.textFont = FBBoldFont(16);
    congfig1.textColor = UIColor.whiteColor;
    congfig1.borderColor = FBColorConst.mainOrange;
    viewModel.buttonConfigs = @[congfig,congfig1];
    FBCustomButtonsView *view = [FBCustomButtonsView btnsWithViewModel:viewModel clickCallback:^(NSInteger index, FBCustomButtonsConfig * _Nonnull config) {
        [NSObject.currentTopVC.view showHudText:config.text];
    }];
    view.backgroundColor = UIColor.randomColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
}

- (void)attributedLabelString {
    YYLabel *label = [YYLabel new];
    label.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*2;
    label.numberOfLines = 0;
    label.attributedText = [FBAttributedLabelString attributedStringWithConfig:^FBAttributedLabelContentModel * _Nonnull(FBAttributedLabelContentModel * _Nonnull model) {
        ///内容的属性设置
        model.text = @"北京分贝通科技有限公司北京分贝通科技有限公司北京分贝通科技有限公司";
        model.textColor = FBColorConst.textGrayBlack;
        ///标签的属性设置[支持添加多个标签]
        FBAttributedLabelModel *label1 = [FBAttributedLabelModel new];
        label1.text = @"授权企业";
        FBAttributedLabelModel *label2 = [FBAttributedLabelModel new];
        label2.text = @"当前企业";
        label2.textColor = FBColorConst.mainOrange;
        label2.borderColor = FBColorConst.mainOrange;
        model.labels = @[label1,label2];
        return model;
    }];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
    }];
}
- (void)newCardView {
    FBTrainNewCardView *cardView = [FBTrainNewCardView new];
    cardView.backgroundColor = UIColor.randomColor;
    FBTrainNewCardViewModel *viewModel = [FBTrainNewCardViewModel new];
    viewModel.index = @"1";
    viewModel.title = @"7月7日 周四 出发";
    viewModel.startTime = @"09:15";
    viewModel.arriveTime = @"22:33";
    viewModel.startStation = @"北京西";
    viewModel.arriveStation = @"武汉北";
    viewModel.consumingTime = @"24时18分";
    viewModel.trainNo = @"G86G86G86";
    viewModel.idCardSupport = NO;
    viewModel.timeTableSupport = YES;
    [cardView reloadDataWithModel:viewModel];
    cardView.trainNoClickCallback = ^(FBTrainNewCardViewModel * _Nonnull adapterModel) {
        [self.view showHudText:adapterModel.trainNo];
    };
    UILabel *label = [UILabel jz_labelWithText:@"退款说明" textColor:FBColorConst.textBlack font:FBFont(16.f)];
    label.textAlignment = NSTextAlignmentCenter;
    [cardView appendCustomView:label customViewLayout:^(UIView *customView, UIView * _Nonnull fatherView) {
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(fatherView);
            make.top.mas_equalTo(16.f);
            make.bottom.mas_equalTo(-16.f);
        }];
    }];
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
}
- (void)navView {
    FBTrainNavigationView *view = [FBTrainNavigationView new];
    view.backBtnClickCallback = ^{
        [self.view showHudText:@"返回"];
    };
    [view addRightBtnWithTitle:@"退出" textColor:FBColorConst.textBlack textFont:FBFont(16.f) clickBlock:^{
        [self.view showHudText:@"退出"];
    }];
    [view addRightBtnWithTitle:@"选择" textColor:FBColorConst.textBlack textFont:FBFont(16.f) clickBlock:^{
        [self.view showHudText:@"选择"];
    }];
    UIView *titleView = [UIView new];
    titleView.backgroundColor = UIColor.randomColor;
    [view addTitleView:titleView clickBlock:^{
        [self.view showHudText:@"点击了titleView"];
    }];
    view.backgroundColor = UIColor.randomColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];

}
- (void)scrollCalendarView {
    FBScrollCalendarView *view = [FBScrollCalendarView new];
    self.calendarView = view;
    FBScrollCalendarViewModel *viewModel = view.adapterModel;
    viewModel.startDate = [NSDate dateWithDaysFromNow:1];
    viewModel.endDate = [NSDate dateWithDaysFromNow:10];
    view.didSelectDateCallback = ^(NSDate * _Nonnull date) {
        [self.view showHudText:NSString.jz_parse(@(date.day))];
    };
    [view reloadData];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
}
- (void)customCollectionView {
    
}
- (UIView *)containerView {
    if (!_containerView){
        _containerView = [UIView new];
    }
    return _containerView;

}
- (FBEnterpriseSelectAlertView *)selectAlertView {
    if (!_selectAlertView){
        _selectAlertView = [FBEnterpriseSelectAlertView new];
    }
    return _selectAlertView;
}
- (void)planeMakeChart {
   FBPlaneApplyAlertView *alertView = [FBPlaneApplyAlertView new];
    ///航班信息
    FBPlaneFlightInfoModel *i1 = [FBPlaneFlightInfoModel new];
    i1.face_price = 1299;
    //[NSString handleAmount:i1.face_price HasRMB:YES AmountFontSize:0]
    i1.airline_name = @"北方航空";
    i1.flight_no = @"CZ8669";
    i1.departure_time = 1675122900000;
    //is_middle_stop 经停
    //前后
//            [NSDate convenienceDateFromTimestamp:departure_time
//                                                       formatterString:@""]
    i1.departure_airport_name = @"北京机场T1";
    i1.arrive_airport_name = @"天津滨海机场";
    
    
    FBPlaneFlightInfoModel *i2 = [FBPlaneFlightInfoModel new];
    i2.face_price = 1899;
    //[NSString handleAmount:i1.face_price HasRMB:YES AmountFontSize:0]
    i2.airline_name = @"南方航空";
    i2.flight_no = @"CZ786";
    i2.departure_time = 1675122900000;
//            [NSDate convenienceDateFromTimestamp:departure_time
//                                                       formatterString:@""]
    i2.departure_airport_name = @"大兴机场";
    i2.arrive_airport_name = @"天河机场";
    NSArray <FBPlaneFlightInfoModel *> *flightList = @[i1,i2];
    
    FBPlaneApplyAlertViewModel *viewModel = FBPlaneApplyAlertViewModel.new;
    ///起飞前多少小时
    viewModel.timeXInterval = 16;
    ///最高价格
    viewModel.maxPrice = 4000;
    ///最低价格
    viewModel.minPrice = 500;
    ///默认展示最大/最小【可不传，默认最小】
    viewModel.showType = FBPlaneApplyChartShowTypeShowBig;
    ///预定的数据模型【pointType、price、startTime必传】
    FBPlaneChartPointModel *bookModel = [FBPlaneChartPointModel new];
    bookModel.pointType = FBPlaneChartPointTypeBook;
    bookModel.price = 1980;
    bookModel.startTime = [NSDate newDateWithYear:2023 month:1 day:13 hour:1 minute:00 second:0];
    bookModel.flightList = flightList;
    viewModel.bookModel = bookModel;
    
    FBPlaneChartPointModel *m0 = [FBPlaneChartPointModel new];
    m0.pointType = FBPlaneChartPointTypeLowest;
    m0.price = 600;
    m0.startTime = [NSDate newDateWithYear:2023 month:1 day:12 hour:9 minute:0 second:0];
    
    
    FBPlaneChartPointModel *m1 = [FBPlaneChartPointModel new];
    m1.pointType = FBPlaneChartPointTypeNormal;
    m1.price = 800;
    m1.startTime = [NSDate newDateWithYear:2023 month:1 day:12 hour:6 minute:50 second:0];
    
    
    m1.flightList = flightList;
    
    FBPlaneChartPointModel *m2 = [FBPlaneChartPointModel new];
    m2.pointType = FBPlaneChartPointTypeNormal;
    m2.price = 1500;
    m2.startTime = [NSDate newDateWithYear:2023 month:1 day:12 hour:9 minute:50 second:0];
    
    FBPlaneChartPointModel *m3 = [FBPlaneChartPointModel new];
    m3.pointType = FBPlaneChartPointTypeLowest;
    m3.price = 500;
    m3.startTime = [NSDate newDateWithYear:2023 month:1 day:13 hour:10 minute:30 second:0];
    m3.flightList = flightList;
    
    FBPlaneChartPointModel *m4 = [FBPlaneChartPointModel new];
    m4.pointType = FBPlaneChartPointTypeHighest;
    m4.price = 4000;
    m4.startTime = [NSDate newDateWithYear:2023 month:1 day:13 hour:11 minute:10 second:0];
    ///点模型数据，用来画曲线图
    viewModel.pointModelList = @[m0,m1,m2,bookModel,m3,m4];
    
    alertView.viewModel = viewModel;
    [alertView showAlertView];
}
@end
