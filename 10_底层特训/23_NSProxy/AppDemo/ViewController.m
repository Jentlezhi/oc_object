//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Person.h"
#import "MyProxy.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [Person new];
    [p foo];
    [p other];
    //协议未继承nsobject时候
    [p description];
    
    NSMutableArray *array = [NSMutableArray array];
     NSMutableString *string = [NSMutableString string];
     
     id proxy = [[MyProxy alloc]initWithTarget1:array target:string];
     [proxy appendString:@"This "];
     
     [proxy appendString:@"is "];
     [proxy addObject:string];
     [proxy appendString:@"a "];
     [proxy appendString:@"test!"];
      NSLog(@"count should be 1,it is:%ld",[proxy count]);
     if ([[proxy objectAtIndex:0] isEqualToString:@"This is a test!"]) {
         NSLog(@"Appending successful: %@",proxy);
     }else
     {
         NSLog(@"Appending failed, got: %@", proxy);
     }
         NSLog(@"Example finished without errors.");
     //TargetProxy拥有了NSSting与NSArray俩个类的方法属性
}


@end
