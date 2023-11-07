//
//  MyViewController.m
//  KVO_basic
//
//  Created by Jentle on 2022/3/13.
//  Copyright © 2022 Jentle. All rights reserved.
//

#import "MyViewController.h"
#import <objc/runtime.h>

@interface MyViewController ()

@property(assign, nonatomic) int age;

@property(strong, nonatomic) NSTimer *timer;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *aString = @"iphone 8";
    NSString *bString = [NSString stringWithFormat:@"iphone %i", 8];
    NSLog(@"%d", [aString isEqual:bString]);
    NSLog(@"%d", [aString isEqualToString:bString]);
    NSLog(@"%d", aString == bString);
    self.view.backgroundColor = UIColor.orangeColor;
    [self addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer - block");
        static int age = 18;
        weakSelf.age = age;
        age++;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//添加了观察者，未实现该方法也会崩溃
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",change);

}

- (void)dealloc
{
    [self.timer invalidate];
    //移除未注册的观察者会崩溃
//    [self removeObserver:self forKeyPath:@"name"];
}


@end
