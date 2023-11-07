//
//  ViewController.m
//  method_swizzing
//
//  Created by Jentle on 2021/10/27.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"
#import "Student2.h"
#import "MyTest.h"
#import "RuntimeTool.h"
//#import "Student+EXT.h"

@interface ViewController ()


@property(assign, nonatomic) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test2];
}

- (void)test2 {
    
    MyTest *test = [MyTest new];
    [test test];
    //开始交换方法
    [RuntimeTool betterMethodSwizzlingWithClass:[MyTest class] oriSel:@selector(test) swizzledSel:@selector(otherTest)];
    [test test];
    
}

- (void)vcFunc {
    
    NSLog(@"%s",__func__);
}

- (void)test1 {
    
    //    self.name = @"Jentle";
    //    NSLog(@"%@",self.name);
        
    //    Person *p = [[Person alloc] init];
    //    [p personInstanceMethod];
        
        Student *s = [Student alloc];
    //    Student *s = [[Student alloc] init];
        [s personInstanceMethod];
    //    [s helloworld];
        
        Student2 *s2 = [Student2 alloc];
        [s2 personInstanceMethod];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    NSLog(@"%@",self.name);
//}


@end
