//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"


@interface ViewController ()

@property(strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController
{
    int num;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)fireHome {
    num++;
    NSLog(@"hello word - %d",num);
}

@end
