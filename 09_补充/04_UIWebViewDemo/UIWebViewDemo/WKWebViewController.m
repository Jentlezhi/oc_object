//
//  WKWebViewController.m
//  UIWebViewDemo
//
//  Created by Jentle on 2021/10/11.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()

@property(strong, nonatomic) WKWebView *webView;

@property(strong, nonatomic) UILabel *label;

@end

@implementation WKWebViewController

- (WKWebView *)webView {
    
    if (!_webView) {
        WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
        conf.processPool = [WKProcessPool new];
        _webView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds configuration:conf];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    }
    return _webView;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = UILabel.new;
        _label.backgroundColor = UIColor.redColor;
        _label.text = @"WKWebView";
        _label.frame = CGRectMake(10, 0, 100, 30);
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.label];
    
    WKHTTPCookieStore *store;
    NSHTTPCookie *cookie;
    [store setCookie:cookie completionHandler:nil];
    
    
}

- (void)setCookie {
    WKHTTPCookieStore *store;
    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:@{}];
    [store setCookie:cookie completionHandler:^{
        NSURLRequest *req;
        [self.webView loadRequest:req];
    }];
}

@end
