//
//  UITableViewCell+YYExtension.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import "UITableViewCell+YYExtension.h"

@implementation UITableViewCell (YYExtension)

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincompatible-pointer-types"
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
#pragma clang diagnostic pop

@end
