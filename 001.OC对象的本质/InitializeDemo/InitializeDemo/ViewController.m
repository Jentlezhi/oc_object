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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestClass *class1 = [[TestClass alloc] init];
    TestClass *class2 = [[TestClass alloc] init];
    SubTestClass *subClass1 = [[SubTestClass alloc] init];
    GrandTestClass *grandTestClass1 = [[GrandTestClass alloc] init];
    GrandTestClass *grandTestClass2 = [[GrandTestClass alloc] init];
}


@end
