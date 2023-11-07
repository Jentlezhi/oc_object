//
//  MyViewController.m
//  RunLoop
//
//  Created by Jentle on 2022/3/25.
//  Copyright © 2022 Jentle. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property(strong, nonatomic) NSTimer *timer;

@end

@implementation MyViewController

- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.orangeColor;
    [super viewDidLoad];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"---------------");
//    }];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(test) userInfo:nil repeats:YES];
    //即使没有self对timer强引用 也不能销毁
    
    
    //手动解决循环引用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
    });
    
    [self performSelector:@selector(test) withObject:nil afterDelay:1.f];
}


- (void)test {
    
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.timer invalidate];
    self.timer = nil;
}

@end
