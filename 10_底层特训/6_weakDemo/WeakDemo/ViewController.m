//
//  ViewController.m
//  WeakDemo
//
//  Created by Jentle on 2021/11/4.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [Person new];
    __weak Person *weakP = p;
    NSLog(@"----------");
}


@end
