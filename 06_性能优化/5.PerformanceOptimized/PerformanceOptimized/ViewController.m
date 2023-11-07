//
//  ViewController.m
//  PerformanceOptimized
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//  通过添加环境变量可以打印出APP的启动时间分析（Edit scheme -> Run -> Arguments）
//  DYLD_PRINT_STATISTICS设置为1
//  如果需要更详细的信息，那就将DYLD_PRINT_STATISTICS_DETAILS设置为1


#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>


@interface ViewController ()

@property(nonatomic, strong) CATextLayer *layer;

@end

@implementation ViewController

- (void)textLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"输入你想显示的文字";
    textLayer.fontSize = 14;
    textLayer.contentsScale = 2;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
    textLayer.font = (__bridge CFTypeRef)(@"HiraKakuProN-W3");
    textLayer.alignmentMode = @"center";
    CGFloat margin = 20.f;
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 2 * margin;
    CGFloat originY = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top + 20.f;
    textLayer.frame = CGRectMake(margin, originY, width, 40);
    [self.view.layer addSublayer:textLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
