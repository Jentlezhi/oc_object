//
//  JZBaseTableViewCell.h
//  fenbeitong
//
//  Created by Jentle-Zhi on 2022/11/15.
//  Copyright © 2022 FinHub. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZBaseTableViewCell : UITableViewCell
/**
 cell的创建方法[无需tableView注册]
 */
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
