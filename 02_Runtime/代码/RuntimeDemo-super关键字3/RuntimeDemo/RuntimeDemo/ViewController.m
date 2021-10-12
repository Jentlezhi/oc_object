//
//  ViewController.m
//  RuntimeDemo
//
//  Created by Jentle on 2021/6/4.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id cls = [Person class];
    void *obj = &cls;
    [(__bridge id)obj run];
    NSLog(@"--------------------");
//    [Person run];
    
    
}


@end
