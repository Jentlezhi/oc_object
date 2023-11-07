//
//  ViewController.m
//  KVCDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)setViewIfLoaded:(id)viewIfLoaded {
    
    objc_setAssociatedObject(self, @selector(viewDidLoad), viewIfLoaded, OBJC_ASSOCIATION_ASSIGN);
}

- (id)viewIfLoaded {
    
    return objc_getAssociatedObject(self, _cmd);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self basic];
//    Person *p = Person.new;
//    [p setValue:@"Hello" forKey:@"name"];
//    NSLog(@"%@",p->name);
//
//    self.viewIfLoaded = @"HHHH";
//    NSLog(@"%@",self.viewIfLoaded);
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
//    NSArray *apps = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@",apps);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Person *p = Person.new;
//    p->_age = 10;
    //kvc获取成员变量（实例变量）:
//    NSLog(@"_age = %@",[p valueForKey:@"_age"]);
    //kvc获取属性：
    NSLog(@"self.age = %@",[p valueForKey:@"age"]);
    
}

- (void)basic {
    
    Person *p = Person.new;
    [p setValue:@"value" forKey:@"hhh"];
//    p->_age = 10;
    [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
    
//        [p setValue:@(20) forKey:@"age"];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
//    
//}

- (void)other {
    
    UIResponder *r = UIResponder.new;
    UIView *v;
    UIControl *c;
    UIViewController *vc;
}



@end
