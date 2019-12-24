//
//  MyView.h
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView

/// model
@property(strong, nonatomic) MyModel *model;

@end

NS_ASSUME_NONNULL_END
