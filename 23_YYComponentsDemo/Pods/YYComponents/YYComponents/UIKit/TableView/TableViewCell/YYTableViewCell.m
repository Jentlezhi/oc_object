//
//  YYTableViewCell.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/12/4.
//

#import "YYTableViewCell.h"
#import "Masonry.h"

@implementation YYTableViewCell

+ (instancetype)cellWithContentView:(nonnull UIView *)contentView
                         edgeInsets:(UIEdgeInsets)edgeInsets
                    reuseIdentifier:(nonnull NSString *)reuseIdentifier {
    YYTableViewCell *cell = [[YYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [cell.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgeInsets);
    }];
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initCell];
    }
    return self;
}
/**
 初始化方法
 */
- (void)initCell {
    
}

@end
