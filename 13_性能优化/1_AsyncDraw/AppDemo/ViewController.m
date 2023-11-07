//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "AsyncDrawLabel.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AsyncDrawLabel *label = [[AsyncDrawLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"异步绘制text";
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    [label.layer setNeedsDisplay]; // 不调用的话不会触发displayLayer方法
}


@end
