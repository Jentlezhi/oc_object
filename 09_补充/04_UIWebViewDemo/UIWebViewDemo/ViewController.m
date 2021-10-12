//
//  ViewController.m
//  UIWebViewDemo
//
//  Created by Jentle on 2021/10/11.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static NSInteger count = 0;
    if (count % 2 == 0) {
        UIWebViewController *web = UIWebViewController.new;
        [self presentViewController:web animated:YES completion:nil];
    }else{
        WKWebViewController *web = WKWebViewController.new;
        [self presentViewController:web animated:YES completion:nil];
    }
    count++;
    
}


@end
