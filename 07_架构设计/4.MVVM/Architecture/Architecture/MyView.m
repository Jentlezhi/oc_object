//
//  MyView.m
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "MyView.h"
#import "MyModel.h"
#import "NSObject+FBKVOController.h"
#import "ViewModel.h"

@interface MyView ()

/// icon
@property(strong, nonatomic) UIImageView *icon;
/// label
@property(strong, nonatomic) UILabel *label;

@end

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.icon];
        [self addSubview:self.label];
        
    }
    return self;
}


- (UIImageView *)icon {
    
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.frame = CGRectMake(0, 0, 50, 50);
    }
    return _icon;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = UIColor.grayColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame), 50, 30);
    }
    return _label;
}

- (void)setViewModel:(ViewModel *)viewModel {
    
    _viewModel = viewModel;
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:viewModel keyPath:@"model.title" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSString *text = change[NSKeyValueChangeNewKey];
        weakSelf.label.text = text;
    }];

    [self.KVOController observe:viewModel keyPath:@"model.iconName" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        weakSelf.icon.image = [UIImage imageNamed:change[NSKeyValueChangeNewKey]];
    }];
}


@end
