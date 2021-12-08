//
//  ViewController.m
//  method_swizzing
//
//  Created by Jentle on 2021/10/27.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"
#import "Student+EXT.h"

@interface ViewController ()


@property(assign, nonatomic) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.name = @"Jentle";
//    NSLog(@"%@",self.name);
    
//    Person *p = [[Person alloc] init];
//    [p personInstanceMethod];
    
    Student *_s = [Student alloc];
//    Student *s = [[Student alloc] init];
//    [s personInstanceMethod];
//    [s helloworld];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",self.name);
}


@end
