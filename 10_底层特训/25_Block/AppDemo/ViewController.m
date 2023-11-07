//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"


@interface ViewController ()

@property(copy, nonatomic) void(^myBlock)(void);


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block NSObject *obj = [NSObject new];
    _myBlock = ^{
        NSLog(@"%@",obj);
    };
    obj = nil;
    _myBlock();
}


@end
