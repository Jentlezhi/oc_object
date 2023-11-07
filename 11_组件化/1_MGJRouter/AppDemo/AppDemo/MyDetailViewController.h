//
//  MyDetailViewController.h
//  AppDemo
//
//  Created by Jentle on 2022/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyDetailViewController : UIViewController

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, copy) void(^backBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END
