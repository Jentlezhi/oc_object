//
//  UITableView+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UITableView+YYExtension.h"
#import <objc/message.h>
#import <Masonry/Masonry.h>

@implementation UITableView (YYExtension)

- (void)setYy_tableHeaderView:(UIView *)yy_tableHeaderView {
    objc_setAssociatedObject(self, @selector(yy_tableHeaderView), yy_tableHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    ///获取tableView的宽度
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat tableViewWidth = self.bounds.size.width;
    ///tableHeaderView强制布局
    [yy_tableHeaderView setNeedsLayout];
    [yy_tableHeaderView layoutIfNeeded];
    self.tableHeaderView = yy_tableHeaderView;
    [yy_tableHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(tableViewWidth);
    }];
    CGFloat headerHeight = [yy_tableHeaderView systemLayoutSizeFittingSize:CGSizeMake(tableViewWidth, CGFLOAT_MAX)].height;
    ///tableHeaderView只需要指定高度即可，宽度随tableView
    yy_tableHeaderView.frame = CGRectMake(0, 0, tableViewWidth, headerHeight);
    self.tableHeaderView = yy_tableHeaderView;
    ///修复当tableView的style == UITableViewStyleGrouped时，headerView空白的问题
    if (self.style == UITableViewStyleGrouped && headerHeight <= 1.f) {
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
}
- (UIView *)yy_tableHeaderView {
    return objc_getAssociatedObject(self, _cmd);
}
/**
 更新TableHeaderView
 通常在TableHeaderView内视图变化或数据变化时调用，与setYy_tableHeaderView：配套使用
 */
- (void)yy_updateTableHeaderView {
    UIView *headerView = self.yy_tableHeaderView;
    if (headerView == nil) { return;}
    self.yy_tableHeaderView = headerView;
}

- (void)setYy_tableFooterView:(UIView *)yy_tableFooterView {
    objc_setAssociatedObject(self, @selector(yy_tableFooterView), yy_tableFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    ///获取tableView的宽度
    [self layoutIfNeeded];
    CGFloat tableViewWidth = self.bounds.size.width;
    self.tableFooterView = yy_tableFooterView;
    NSLog(@"%@",NSStringFromCGRect(yy_tableFooterView.frame));
    [yy_tableFooterView layoutIfNeeded];
    CGSize size = [yy_tableFooterView systemLayoutSizeFittingSize:CGSizeMake(tableViewWidth, CGFLOAT_MAX)];
    yy_tableFooterView.frame = CGRectMake(0, 0, size.width, size.height);
    self.tableFooterView = yy_tableFooterView;
}
- (UIView *)yy_tableFooterView {
    return objc_getAssociatedObject(self, _cmd);
}
/**
 更新TableFooterView
 通常在TableFooterView内视图变化或数据变化时调用，与setYy_tableFooterView：配套使用
 */
- (void)yy_updateTableFooterView {
    UIView *footerView = self.yy_tableFooterView;
    if (footerView == nil) { return;}
    self.yy_tableFooterView = footerView;
}

@end
