//
//  UserHeaderView.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderView : UIView

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

- (void)reSetFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
