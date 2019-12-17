//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  串行队列保证线程同步

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [[Person alloc] init];
    p.data = [NSMutableArray array];
    NSMutableArray *array = p.data;
    ///atomic只保证getter和setter方法内部线程安全
    ///array addObject添加元素，不能保证线程安全
    [array addObject:@1];
    [array addObject:@2];
    [array addObject:@3];
    
}



@end
