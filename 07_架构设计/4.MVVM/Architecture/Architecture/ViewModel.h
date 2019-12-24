//
//  ViewModel.h
//  Architecture
//
//  Created by Jentle on 2019/12/25.
//  Copyright © 2019 Jentle. All rights reserved.
//  一个模块对应一个ViewModel

#import <UIKit/UIKit.h>

@class MyModel;

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

- (instancetype)initWithController:(UIViewController *)controller;

/// model
@property(strong, nonatomic) MyModel *model;

@end

NS_ASSUME_NONNULL_END
