//
//  MyViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/16.
//

#import "MyViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JZScrollViewDataSet.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray <NSString*> *list;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.dataSet = [JZScrollViewDataSet dataSetWithEmptyView:^UIView * _Nullable{
//        UILabel *label = [UILabel new];
//        label.text = @"-- 无数据 --";
//        label.textAlignment = NSTextAlignmentCenter;
//        return label;
////        UIView *view = [UIView new];
////        UIView *sub = [UIView new];
////        sub.backgroundColor = UIColor.randomColor;
////        [view addSubview:sub];
////        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.width.height.mas_equalTo(self.view.width*0.4);
////            make.edges.equalTo(view);
////        }];
////        return view;
//    }];
    self.tableView.dataSet = [JZScrollViewDataSet dataSetWithEmptyView:^UIView * _Nullable{
        UILabel *label = [UILabel new];
        label.text = @"-- 无数据 --";
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    } tap:^{
        NSLog(@"点我干嘛！！！");
    }];
//    self.tableView.dataSet = [JZScrollViewDataSet dataSetWithEmptyView:^UIView * _Nonnull{
//        UILabel *label = [UILabel new];
//        label.text = @"-- 无数据 --";
//        label.textAlignment = NSTextAlignmentCenter;
//        return label;
//    } errorView:^UIView * _Nonnull{
//        UILabel *label = [UILabel new];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = @"-网络错误-";
//        UIButton *btn = [UIButton new];
//        [btn setTitle:@"-网络错误-" forState:UIControlStateNormal];
//        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//        return btn;
//    } config:nil tap:^{
//        NSLog(@"点我干嘛！！！");
//    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataWithTime:3.f completion:^(NSArray<NSString *> *data) {
            static NSInteger count = 0;
            weakSelf.tableView.dataSetType = JZScrollViewDataSetTypeError;
            count++;
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.list = @[];
//            [weakSelf.tableView reloadEmptyDataSet];
            [weakSelf.tableView reloadData];
        }];
        
    }];

    
    
    [self requestDataWithTime:0.f completion:^(NSArray<NSString *> *data) {
//        self.list = @[@"1",@"2"];
        [self.tableView reloadData];
    }];
}

- (void)test {
    NSLog(@"%s",__func__);
}

- (void)requestDataWithTime:(CGFloat)timeSec
                 completion:(void(^)(NSArray <NSString*> *data))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeSec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int count = arc4random() % 10;
        if (count < 7) {
            count = 0;
        } else if (count < 7) {
            count+=10;
        }
        NSMutableArray *list = @[].mutableCopy;
        for (int index = 0; index < count; index++) {
            [list addObject:[NSString stringWithFormat:@"%d",index]];
        }
        !completion?:completion(list);
    });
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        UIView *header = [UIView new];
        header.frame = CGRectMake(0, 0, 0.f, CGFLOAT_MIN);
        _tableView.tableHeaderView = header;
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0.f;
        }
    }
    return _tableView;
}

#pragma mark - Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}
@end
