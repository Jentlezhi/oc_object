//
//  MyView.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/10/16.
//

#import "MyView.h"
#import "Masonry.h"

@interface MyView()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation MyView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame: frame]) {
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.bgView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5.f);
            make.right.mas_equalTo(-5.f);
        }];
    }
    return self;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
        _bgView.layer.shadowOpacity = 0.08f;
        _bgView.layer.shadowRadius = 4;
        _bgView.layer.shadowOffset = CGSizeMake(0, 0.5);
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColor.whiteColor;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@",self.title);
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%@ - hitTest",self.title);
//    return [super hitTest:point withEvent:event];
//}

@end
