//
//  JZMainViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZDetailViewController.h"
#import "JZSubview.h"

@interface JZDetailViewController ()

@property(nonatomic, strong) UIButton *backBtn;

@property(nonatomic, strong) UIButton *btn1;

@property(nonatomic, strong) UIView *labelBgView;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UITextField *textField;

@property(strong, nonatomic) JZSubview *subview;

@property(copy, nonatomic) void(^myBlock1)(void);

@property(copy, nonatomic) void(^myBlock2)(void);

@property(copy, nonatomic) void(^myBlock3)(void);

@property(copy, nonatomic) void(^myBlock4)(void);

@property(copy, nonatomic) void(^myBlock5)(void);

@property(copy, nonatomic) void(^myBlock6)(void);

@property(copy, nonatomic) NSString *propertyName;

@end

@implementation JZDetailViewController
- (void)viewDidLoad {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [super viewDidLoad];
    [self setupviews];
    self.propertyName = @"TEST";
    [self blockTest];
}
- (void)setupviews {
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

- (void)blockTest {
    /*
     1.使用__weak 定义变量weakSelf，block内部使用的是weakSelf
       可以解决循环引用
     */
    __weak typeof(self) weakSelf = self;
    self.myBlock1 = ^{
        NSLog(@"%@",weakSelf.propertyName);
    };
    /*
     2.使用weakify 创建了一个对self的弱引用，但是在block内部任然使用了self
       实际上还是通过强引用的方式访问propertyName，不可解决循环引用。
       weakify的本质是创建了一个self_weak_ = self，要想解决循环引用要么
       直接使用self_weak_去访问propertyName，要么使用strongify(self)给
       变量self重新赋值self = self_weak_,这样也可以解决循环引用
       
     */
    @weakify(self);
    self.myBlock2 = ^{
        ///这里直接使用weakify(self)创建的变量self_weak_
        NSLog(@"%@",self_weak_.propertyName);
    };
    self.myBlock3 = ^{
        ///使用strongify(self)给变量self重新赋值self = self_weak_
        @strongify(self);
        NSLog(@"%@",self.propertyName);
    };
    /*
     3.1 block的嵌套，内部直接都使用weakSelf，这样可以解决循环引用（不安全）
     */
    self.myBlock4 = ^{
        weakSelf.subview.subBlock = ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%@",weakSelf.propertyName);
            });
        };
        weakSelf.subview.subBlock();
    };
    self.myBlock4();
    
    /*
     3.2 block的嵌套，使用__strong或__weak变量既解决循环引用又防止self被提前释放
     */
    self.myBlock5 = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",strongSelf.propertyName);///将weakSelf提升为strongSelf，确保在block执行期间，self不会被释放
        ///这里的 weakSelf 不会直接持有对 self 的强引用，从而避免了循环引用
        weakSelf.subview.subBlock = ^{
            __strong typeof(weakSelf) strongSelf1 = weakSelf;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%@",strongSelf1.propertyName);
            });
        };
        weakSelf.subview.subBlock();
    };
    self.myBlock5();
    /*
     3.3 使用weakify和strongify结合来解决循环引用
     */
    self.myBlock6 = ^{
        @strongify(self);// 将 weakSelf 提升为 strongSelf
        NSLog(@"%@",self.propertyName);// 确保在 block 执行期间，self 不会被释放
        self.subview.subBlock = ^{
            @strongify(self);// 在子 block 中提升 weakSelf
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%@",self.propertyName);// 使用 self
            });
        };
        self.subview.subBlock();
    };
    self.myBlock6();
    
}
- (JZSubview *)subview {
    if (!_subview){
        _subview = [JZSubview new];
    }
    return _subview;
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

