//
//  ViewController.m
//  MyProject
//
//  Created by Jentle on 2021/6/7.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self toFlutter];
}

- (void)toFlutter {
    FlutterViewController *flutterVC = [[FlutterViewController alloc] init];
    //设置路由
    [flutterVC setInitialRoute:@""];
    //push 或者 present
    [self presentViewController:flutterVC animated:YES completion:nil];
    
}


@end
