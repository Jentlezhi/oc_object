//
//  JZBaseTableViewCell.m
//  fenbeitong
//
//  Created by Jentle-Zhi on 2022/11/15.
//  Copyright © 2022 FinHub. All rights reserved.
//

#import "JZBaseTableViewCell.h"

@implementation JZBaseTableViewCell
#pragma mark - Lefe Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self config];
    }
    return self;
}

- (void)config {
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Methods
/**
 cell的创建方法[无需tableView注册]
 */
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    JZBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
