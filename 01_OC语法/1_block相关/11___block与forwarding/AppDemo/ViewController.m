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


@end
