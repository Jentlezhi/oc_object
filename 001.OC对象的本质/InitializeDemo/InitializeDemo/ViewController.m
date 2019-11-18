//
//  ViewController.m
//  InitializeDemo
//
//  Created by Jentle on 2019/11/14.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"
#import "SubTestClass.h"
#import "GrandTestClass.h"
#import "TestClass+Y.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TestClass alloc];
    ///消息发送机制：等价于
    ///((void(*)(id,SEL))objc_msgSend)([TestClass class], @selector(alloc));
    
//    TestClass *class2 = [[TestClass alloc] init];
//    SubTestClass *subClass1 = [[SubTestClass alloc] init];
//    GrandTestClass *grandTestClass1 = [[GrandTestClass alloc] init];
//    GrandTestClass *grandTestClass2 = [[GrandTestClass alloc] init];
}


@end
