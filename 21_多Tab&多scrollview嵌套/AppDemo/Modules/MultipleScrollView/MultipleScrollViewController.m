//
//  MultipleScrollViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/13.
//

#import "MultipleScrollViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "JXPagerView.h"
#import "SubViewController.h"
#import "UserHeaderView.h"

@interface MultipleScrollViewController ()<JXPagerViewDelegate,JXCategoryViewDelegate>

@property(nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXPagerView *pagerView;
@property(nonatomic, strong) UserHeaderView *headerView;
@property(nonatomic, strong) NSArray <NSString*>*titles;

@end

@implementation MultipleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [self addSubComponents];
    [self requsetHeaderData];
}

- (void)addSubComponents {
    [self.view addSubview:self.pagerView];
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)requsetHeaderData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.headerView.height = 100.f;
        NSTimeInterval duration = 0.3f;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self.headerView reSetFrame:self.headerView.frame];
        } completion:nil];
        [self.pagerView resizeTableHeaderViewHeightWithAnimatable:YES duration:duration curve:UIViewAnimationCurveLinear];
    });
}
- (UserHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200.f)];
    }
    return _headerView;
}
- (JXCategoryTitleView *)categoryView {
    if(!_categoryView) {
        _categoryView = [JXCategoryTitleView new];
        _categoryView.frame = CGRectMake(0, 0, self.view.height, 50.f);
        _categoryView.delegate = self;
        _categoryView.titles = self.titles;
        _categoryView.titleLabelZoomEnabled = YES;
        ///点击tab切换，取消动画
        _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        _categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//        lineView.indicatorColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
        lineView.indicatorWidth = 30;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}
- (JXPagerView *)pagerView {
    if (!_pagerView) {
        _pagerView = [[JXPagerView alloc] initWithDelegate:self];
    }
    return _pagerView;
}
- (NSArray<NSString *> *)titles {
    if (!_titles) {
        _titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果"];
    }
    return _titles;
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.headerView.height;
}
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView.height;
}
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    SubViewController *sub = [SubViewController new];
    sub.rowTitle = self.titles[index];
    return sub;
}
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView scrollViewDidScroll:scrollView.contentOffset.y];
}


@end
