//
//  JZMainViewController.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZDetailViewController : UIViewController

@property(nonatomic, copy) NSString *info;

@property(nonatomic, copy) void(^backBlock)(NSString *info);

@end

NS_ASSUME_NONNULL_END
