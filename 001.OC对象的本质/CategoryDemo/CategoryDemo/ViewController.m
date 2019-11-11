//
//  ViewController.m
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Eat.h"
#import "Person+Test.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = Person.new;
    [p run];
    [p eat];
    [p test];
    ///实质是发送消息
    
}


@end
