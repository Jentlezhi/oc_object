//
//  ViewController.m
//  KVCDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    Person *p = Person.new;
    p->_age = 10;
    //kvc获取值:
    NSLog(@"_age = %@",[p valueForKey:@"_age"]);
    
    
}

- (void)basic {
    
        Person *p = Person.new;
    //    p->_age = 10;
        [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    //    [p setValue:@(20) forKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
}




@end
