//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "JZSecondViewController.h"


@interface ViewController ()

@property(nonatomic, strong) UIButton *jumpBtn;

@property(nonatomic, strong) UIButton *btn1;

@end

@implementation ViewController
- (void)viewDidLoad {
    self.title = @"首页";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [super viewDidLoad];
    [self.view addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20.f);
    }];
    [self.view addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.jumpBtn);
        make.bottom.equalTo(self.jumpBtn.mas_top).offset(-20.f);
    }];
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [self createBtnWithTitle:@"跳转" fontSize:16.f titleColor:UIColor.blackColor action:@selector(jumpAction)];
    }
    return _jumpBtn;
}
- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [self createBtnWithTitle:@"按钮1" fontSize:16.f titleColor:UIColor.orangeColor action:@selector(btn1Action)];
    }
    return _btn1;
}

- (void)jumpAction {
    JZSecondViewController *vc = [JZSecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btn1Action {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert Title" message:@"The message is ..." preferredStyle:UIAlertControllerStyleAlert];
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
    btn.layer.cornerRadius = 13;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = titleColor.CGColor;
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(3, 8, 3, 8);
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
