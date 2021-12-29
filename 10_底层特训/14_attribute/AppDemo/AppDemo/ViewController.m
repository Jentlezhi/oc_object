//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMyHost:nil];
    [self getHost:nil];
}

- (int)addNum1:(int *)num1 num2:(int *)num2  __attribute__((nonnull (1,2))){//1,2表示第一个和第二个参数不能为空
    return  *num1 + *num2;
}

- (NSString *)getMyHost:(NSURL *)url{
    return url.host;
}

- (NSString *)getHost:(NSURL *)url __attribute__((nonnull (1))){//第一个参数不能为空
    return url.host;
}



@end
