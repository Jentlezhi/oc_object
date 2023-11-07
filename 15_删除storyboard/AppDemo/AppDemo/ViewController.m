//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2022/5/23.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AppDemo";
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleButton setTitle:@"跳转" forState:UIControlStateNormal];
    [cancleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleButton];
}

- (void)jump {
    
}


@end
