//
//  Presenter.h
//  Architecture
//
//  Created by Jentle on 2019/12/25.
//  Copyright © 2019 Jentle. All rights reserved.
//  一个模块对应一个Presenter

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject

- (instancetype)initWithController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
