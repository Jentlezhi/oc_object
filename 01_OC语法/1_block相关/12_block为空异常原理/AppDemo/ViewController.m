//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Person.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}

- (void)test {
    __block int val = 10;

    printf("&val:%p, val:%d \n", &val, val);
    
    void (^blk)(void) = ^{
        printf("inBlock    &val:%p, val:%d \n", &val, val);
        ++val;
    };
    
//    printf("&val:%p, val:%d \n", &val, val);
//    blk();
//    printf("&val:%p, val:%d \n", &val, val);
//    ++val;
//    printf("&val:%p, val:%d \n", &val, val);
}

- (void)test1 {
    ///1.p不为空，而block为空会报地址找不到的异常，底层是call *0x10(rax)
    ///2.p为空时，
//    Person *p = [Person new];
    Person *p;
    p.myBlock();
}


@end
