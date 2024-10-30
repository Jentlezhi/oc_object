//
//  YYTableContainer.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2020/11/1.
//

#import <UIKit/UIKit.h>
#import "YYTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYTableContainerConfig : NSObject

///=========================================================
/// 默认UITableViewStyleGrouped
/// 
///=========================================================
/// 背景颜色
@property(nonatomic, strong) UIColor *backgroundColor;
/// 表格背景颜色
@property(nonatomic, strong) UIColor *tableBackgroundColor;
/// 表格样式[UITableViewStylePlain:sectionHeader悬停效果，UITableViewStyleGrouped：分组样式，内部已处理多余的间隔]
@property(nonatomic, assign) UITableViewStyle tableViewStyle;

@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;

@property(nonatomic, assign) UIEdgeInsets tableEdgeInsets;

@property(nonatomic, strong) UIView *tableHeaderView;

@property(nonatomic, strong) UIView *tableFooterView;

@property(nonatomic, assign) BOOL showsVerticalScrollIndicator;

/// 估值高度，设置合适的高度，在性能优化上提供一些帮助[默认44.f]
@property(nonatomic, assign) CGFloat estimatedRowHeight;
/// section数量，默认返回1
@property(nonatomic, copy) NSInteger (^numberOfSections)(UITableView *tableView);

@property(nonatomic, copy) NSInteger (^numberOfRowsInSection)(UITableView *tableView, NSInteger section);

@property(nonatomic, copy) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

@property(nonatomic, copy) UIView *(^viewForHeaderInSection)(UITableView *tableView, NSInteger section);

@property(nonatomic, copy) UIView *(^viewForFooterInSection)(UITableView *tableView, NSInteger section);

@end

@interface YYTableContainer : UIView

@property(nonatomic, strong, readonly) UITableView *tableView;
/**
 创建表格
 @param configBlock     配置文件
 @return                表格
 */
+ (instancetype)containerWithConfig:(void(^)(YYTableContainerConfig *config))configBlock;
/**
 创建表格
 @param itemNumber        数量
 @param contentEdgeInsets 间距
 @param itemSpacing       子视图间距
 @param itemBuild         创建子视图
 @return                  表格
 */
+ (instancetype)containerWithItemNumber:(NSInteger)itemNumber
                      contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
                            itemSpacing:(CGFloat)itemSpacing
                    showScrollIndicator:(BOOL)showScrollIndicator
                              itemBuild:(nonnull UIView* (^)(NSIndexPath * _Nonnull indexPath))itemBuild;
/**
 刷新
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
