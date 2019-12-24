//
//  MyView.h
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewModel;


NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView

/// viewModel
@property(weak, nonatomic) ViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
