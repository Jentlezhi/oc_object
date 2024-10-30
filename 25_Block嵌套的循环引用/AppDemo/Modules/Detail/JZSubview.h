//
//  JZSubview.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2024/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZSubview : UIView

@property(copy, nonatomic) void(^subBlock)(void);

@end

NS_ASSUME_NONNULL_END
