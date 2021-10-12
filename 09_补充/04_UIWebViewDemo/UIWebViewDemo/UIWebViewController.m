//
//  WebViewController.m
//  UIWebViewDemo
//
//  Created by Jentle on 2021/10/11.
//

#import "UIWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebViewController ()<UIWebViewDelegate>

@property(strong, nonatomic) UIWebView *webView;

@property(strong, nonatomic) UILabel *label;

@end

@implementation UIWebViewController

- (UIWebView *)webView {
    
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = UIScreen.mainScreen.bounds;
        _webView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    }
    return _webView;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = UILabel.new;
        _label.backgroundColor = UIColor.redColor;
        _label.text = @"UIWebView";
        _label.frame = CGRectMake(10, 0, 100, 30);
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.label];
    
//    JSContext *context = [[JSContext alloc] init];
//    [context evaluateScript:@"var a = 1;var b = 2;"];
//    JSValue *value = [context evaluateScript:@"a + b"];
//    NSInteger sum = [value toInt32];//sum=3
//    NSLog(@"sum = %ld",(long)sum);
    
    JSContext *context = [[JSContext alloc] init];
    context[@"myFunc"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"拿到了参数:%@", obj);
         }
    };
    context[@"myFuncPar"] = @"我是个参数";
    [context evaluateScript:@"myFunc(myFuncPar)"];//console输出：“拿到了参数:全局变量字符串”
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //一个 Context 就是一个 JavaScript 代码执行的环境，也叫作用域。
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSLog(@"%@",context);
    return YES;
}

- (void)dealloc{
    
    NSLog(@"%s",__func__);
}

@end
