//
//  ViewController.m
//  CategoryAddPropertyDemo
//
//  Created by Jentle on 2019/11/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Test.h"
#import "Student.h"
#import "Student+Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setValueWithDict {
    
    Person *p1 = Person.new;
    p1.age = 10;
    p1.weight = 150;
    NSLog(@"age = %ld - weight = %f",(long)p1.age,p1.weight);
    
    Person *p2 = Person.new;
    p2.age = 10;
    p2.weight = 120;
    NSLog(@"age = %ld - weight = %f",(long)p2.age,p2.weight);
}


@end
