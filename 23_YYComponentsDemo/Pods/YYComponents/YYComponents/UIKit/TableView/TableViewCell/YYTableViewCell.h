//
//  YYTableViewCell.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTableViewCell : UITableViewCell
/**
 提供快速添加内容的方法
 @param contentView     内容视图
 @param edgeInsets      内边距
 @param reuseIdentifier 复用标识
 @return                cell
 */
+ (instancetype)cellWithContentView:(nonnull UIView *)contentView
                         edgeInsets:(UIEdgeInsets)edgeInsets
                    reuseIdentifier:(nonnull NSString *)reuseIdentifier;
/**
 初始化方法
 */
- (void)initCell;

@end

NS_ASSUME_NONNULL_END
