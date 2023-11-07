//
//  JZMainViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZDetailViewController.h"

@interface JZDetailViewController ()

@property(nonatomic, strong) UIButton *backBtn;

@property(nonatomic, strong) UIButton *btn1;

@property(nonatomic, strong) UIView *labelBgView;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UITextField *textField;

@end

@implementation JZDetailViewController
- (void)viewDidLoad {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [super viewDidLoad];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(44.f);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20.f);
    }];
    [self.view addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.backBtn);
        make.bottom.equalTo(self.backBtn.mas_top).offset(-20.f);
    }];
    [self.view addSubview:self.labelBgView];
    [self.labelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.centerY.equalTo(self.view);
    }];
    [self.labelBgView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20.f);
        make.right.mas_lessThanOrEqualTo(-20.f);
        make.bottom.mas_equalTo(-20.f);
    }];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.labelBgView);
        make.height.mas_equalTo(50.f);
        make.top.equalTo(self.labelBgView.mas_bottom).offset(20.f);
    }];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [self createBtnWithTitle:@"返回并传值" fontSize:16.f titleColor:UIColor.blackColor action:@selector(backAction)];
    }
    return _backBtn;
}
- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [self createBtnWithTitle:@"按钮1" fontSize:16.f titleColor:UIColor.orangeColor action:@selector(btn1Action)];
    }
    return _btn1;
}

- (void)backAction {
    !self.backBlock?:self.backBlock(self.textField.text);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)btn1Action {
    NSMutableString *content = [NSMutableString new];
    if (self.textField.text.length) {
        [content appendString:@"回传值内容："];
        [content appendString:self.textField.text];
        [content appendString:@"\n"];
    }
    if (self.label.text.length) {
        [content appendString:@"传入的内容："];
        [content appendString:self.label.text];
    }
    if (!content.length) {
        [content appendString:@"无传值"];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel");
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UIButton *)createBtnWithTitle:(NSString *)title
                        fontSize:(CGFloat)fontSize
                      titleColor:(UIColor *)titleColor action:(SEL)action {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.layer.cornerRadius = 6;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = titleColor.CGColor;
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (UIView *)labelBgView {
    if (!_labelBgView) {
        _labelBgView = [UIView new];
        _labelBgView.layer.borderColor = UIColor.randomColor.CGColor;
        _labelBgView.layer.borderWidth = 1.f;
    }
    return _labelBgView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"我是详情数据";
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font = [UIFont systemFontOfSize:16.f];
    }
    return _label;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:16.f];
        _textField.placeholder = @"请输入要回传的内容";
        UIColor *color = UIColor.randomColor;
        _textField.layer.borderColor = color.CGColor;
        _textField.layer.borderWidth = 1.f;
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 20.f, 1.f);
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.tintColor = color;
    }
    return _textField;
}

- (void)setInfo:(NSString *)info {
    _info = info;
    if (info.length == 0) {return;}
    self.label.text = info;
}

- (void)dealloc {
    NSLog(@"%@已被释放",[self class]);
}

@end

