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


@property(strong, nonatomic) UIView *topView;

@property(strong, nonatomic) UIView *middleView;

@property(strong, nonatomic) UIStackView *stackView;

@property(strong, nonatomic) UIView *normalView;

@property(strong, nonatomic) UIView *bottomView;

@property(strong, nonatomic) UILabel *bottomLabel;

@property(assign, nonatomic) BOOL bottomLabelHidden;

@property(strong, nonatomic) NSMutableArray *subViewsArray;

@property(strong, nonatomic) MASConstraint *constraint;

@property(strong, nonatomic) MASConstraint *topConstraint;

@property(strong, nonatomic) MASConstraint *middleConstraint;

@property(strong, nonatomic) MASConstraint *botomConstraint;


@end

@implementation JZDetailViewController
- (void)viewDidLoad {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [super viewDidLoad];
    [self stackViewFunc];
}

/**
 普通视图的动画效果
 */
- (void)testnormalView {
    self.normalView = [UIView new];
    self.normalView.backgroundColor = UIColor.randomColor;
    [self.view addSubview:self.normalView];
    [self.normalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10.f);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];

    UIView *topView = [UIView new];
    topView.backgroundColor = UIColor.yy_randomColor;
    [self.normalView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10.f);
        make.top.equalTo(self.normalView);
        make.height.mas_equalTo(90.f);
    }];

    UIView *middleView = [UIView new];
    middleView.backgroundColor = UIColor.yy_randomColor;
    [self.normalView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10.f);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(120.f);
    }];

    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = @"好的！如果你想要实现多个子视图，并且每个子视图的内容高度是动态的（根据内部子视图的内容调整），那么可以继续使用 Masonry 布局和 UIView 的 alpha 属性来实现丝滑的显示与隐藏动画。";
    [self.normalView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(10.f);
        make.top.equalTo(middleView.mas_bottom);
        make.bottom.equalTo(self.normalView);
    }];

    __block BOOL hidden = YES;

    [middleView yy_addTapAction:^{
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(10.f);
            make.top.equalTo(middleView.mas_bottom);
            if (hidden){
                make.height.mas_equalTo(0.f);
            }
            make.bottom.equalTo(self.normalView);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            hidden = !hidden;
        }];
    }];

}

- (void)stackViewFunc {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.topConstraint = make.height.mas_equalTo(50.f);
    }];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.inset(10.f);
    }];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.middleConstraint = make.height.mas_equalTo(90.f);
    }];
    self.bottomView.hidden = NO;
}
- (UIView *)topView {
    if (!_topView){
        _topView = [UIView new];
        _topView.backgroundColor = UIColor.randomColor;
        @weakify(self);
        [_topView yy_addTapAction:^{
            @strongify(self);
            
//            [UIView animateWithDuration:0.25 animations:^{
//                self.middleView.hidden = !self.middleView.hidden;
//            }];
        }];
        [self.stackView addArrangedSubview:_topView];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView){
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.randomColor;
        [_bottomView addSubview:self.bottomLabel];
        [self.stackView addArrangedSubview:_bottomView];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(YYEdgeInsetsMakeAll(10.F));
        }];
        @weakify(self);
        [_bottomView yy_addTapAction:^{
            @strongify(self);
            self.topView.tag = 1;
            [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.topView.tag == 1 ? 50.f : 0.f);
            }];
            self.topView.tag = 0;
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
//            [UIView animateWithDuration:0.25 animations:^{
//                self.topView.hidden = !self.topView.hidden;
//            }];
        }];
    }
    return _bottomView;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel){
        _bottomLabel = [UILabel new];
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.text = @"好的！如果你想要实现多个子视图，并且每个子视图的内容高度是动态的（根据内部子视图的内容调整），那么可以继续使用 Masonry 布局和 UIView 的 alpha 属性来实现丝滑的显示与隐藏动画。好的！如果你想要实现多个子视图，并且每个子视图的内容高度是动态的（根据内部子视图的内容调整），那么可以继续使用 Masonry 布局和 UIView 的 alpha 属性来实现丝滑的显示与隐藏动画。";
    }
    return _bottomLabel;
}
- (UIView *)middleView {
    if (!_middleView){
        _middleView = [UIView new];
        _middleView.backgroundColor = UIColor.randomColor;
        [self.stackView addArrangedSubview:_middleView];
        @weakify(self);
        [_middleView yy_addTapAction:^{
            @strongify(self);
//            [UIView animateWithDuration:0.25 animations:^{
//                self.bottomView.hidden = !self.bottomView.hidden;
//            }];
        }];
    }
    return _middleView;
}
- (UIStackView *)stackView {
    if(!_stackView){
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 10;
//        _stackView.alignment = UIStackViewAlignmentLeading;
        _stackView.backgroundColor = UIColor.randomColor;
        [self.view addSubview:_stackView];
        
    }
    return _stackView;
}


- (void)origin {
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

