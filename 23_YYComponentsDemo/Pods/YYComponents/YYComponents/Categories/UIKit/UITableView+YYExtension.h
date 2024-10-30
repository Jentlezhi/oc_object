//
//  UITableView+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (YYExtension)

/**
 设置tableview的tableHeaderView
 该方法会自动设置tableHeaderView的高度
 请保证tableview已添加完布局，并且布局中可以拿到tableView的width（可以使用以下两种方法）
 1.给tableHeaderView添加宽度的约束
 [tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
 }];
 2.使用YYTableContainer
 */
@property(nonatomic, strong) UIView *yy_tableHeaderView;
/**
 设置tableview的tableFooterView
 请确保tableFooterView内部的约束能把tableFooterView撑开
 */
@property(nonatomic, strong) UIView *yy_tableFooterView;

/**
 更新TableHeaderView
 通常在TableHeaderView内视图变化或数据变化时调用，与setYy_tableHeaderView：配套使用
 */
- (void)yy_updateTableHeaderView;
/**
 更新TableFooterView
 通常在TableFooterView内视图变化或数据变化时调用，与setYy_tableFooterView：配套使用
 */
- (void)yy_updateTableFooterView;

@end

NS_ASSUME_NONNULL_END
