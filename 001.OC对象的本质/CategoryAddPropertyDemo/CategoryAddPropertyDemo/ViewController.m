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

//extern const void *StuNameKey;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAssociated];
    
//    NSLog(@"StuNameKey:%p",StuNameKey);
//    StuNameKey = @"123";
//    NSLog(@"StuNameKey:%p",StuNameKey);
}

- (void)setAssociated {
    
    Student *s = Student.new;
    s.name = @"Jack";
    s.gender = @"男";
    
    Student *s1 = Student.new;
    s1.name = @"Rose";
    s1.gender = @"女";
    
    //s.name=男 s.gender=男 s1.name=女
    NSLog(@"s.name=%@ s.gender=%@ s1.name=%@ s1.gender=%@",s.name,s.gender, s1.name,s1.gender);
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
