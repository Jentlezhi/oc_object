//
//  JZMainViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZMainViewController.h"
#import "JZDetailViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JZMainViewController ()

@property(nonatomic, strong) UIButton *jumpBtn;

@property(nonatomic, strong) UIButton *btn1;

@property(nonatomic, strong) UIView *labelBgView;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation JZMainViewController
- (void)viewDidLoad {
    self.title = @"首页";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e2edf2"];
    [super viewDidLoad];
    [self.view addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(44.f);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20.f);
    }];
    [self.view addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.jumpBtn);
        make.bottom.equalTo(self.jumpBtn.mas_top).offset(-20.f);
    }];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20.f);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.btn1.mas_top).offset(-20.f);
    }];
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [self createBtnWithTitle:@"OC调用JS-带参数" fontSize:16.f titleColor:UIColor.blackColor action:@selector(ocInvoJSParams)];
    }
    return _jumpBtn;
}
- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [self createBtnWithTitle:@"OC调用JS" fontSize:16.f titleColor:UIColor.orangeColor action:@selector(ocInvoJS)];
    }
    return _btn1;
}

- (void)ocInvoJSParams {

    [self.webView evaluateJavaScript:@"IOSCallJsWithArgs('哈哈哈哈')" completionHandler:^(id _Nullable, NSError * _Nullable error) {

    }];
}
- (void)ocInvoJS {
    [self.webView evaluateJavaScript:@"IOSCallJs()" completionHandler:^(id _Nullable, NSError * _Nullable error) {
        
    }];
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
        _label.text = @"我是首页数据";
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font = [UIFont systemFontOfSize:16.f];
    }
    return _label;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:16.f];
        _textField.placeholder = @"请输入正向传值内容";
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
- (WKWebView *)webView {
    if (!_webView){
//        UIWebViewDelegate
//        UIWebView *webView;
//        webView.delegate =
        _webView = [WKWebView new];
        NSString *htmlPath=[[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
        NSURL *url=[NSURL fileURLWithPath:htmlPath];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        //提供js调用原生的配置
        WKUserContentController *userCC = _webView.configuration.userContentController;
        [userCC addScriptMessageHandler:self name: @"jsInvokeOCMethod"];
        [_webView loadRequest:request];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString: @"jsInvokeOCMethod"]) {
            NSLog(@"MessageBody: %@", message.body);
    }else if ([message.name isEqualToString: @"jsInvokeOCMethodArgs"]){
        NSLog(@"MessageBody: %@", message.body);
    }
}

@end

