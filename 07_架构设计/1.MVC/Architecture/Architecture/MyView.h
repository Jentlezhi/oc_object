//
//  MyView.h
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView



/// icon
@property(strong, nonatomic, readonly) UIImageView *icon;
/// label
@property(strong, nonatomic, readonly) UILabel *label;

@end

NS_ASSUME_NONNULL_END
