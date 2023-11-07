//
//  MyDetailViewController.m
//  AppDemo
//
//  Created by Jentle on 2022/3/6.
//

#import "MyDetailViewController.h"
#import "Masonry.h"

@interface MyDetailViewController ()

@property(nonatomic, strong) UITextField *textField;

@property(nonatomic, strong) UIButton *backBtn;

@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.textField];
    [self.view addSubview:self.label];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.backBtn.mas_top).offset(-20.f);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.textField.mas_top).offset(-20.f);
    }];
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = UIColor.lightGrayColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"请输入回传值";
    }
    return _textField;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (void)back:(UIResponder *)res {
    !self.backBlock?:self.backBlock(self.textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
