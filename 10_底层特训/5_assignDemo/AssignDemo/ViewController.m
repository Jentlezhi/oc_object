//
//  ViewController.m
//  AssignDemo
//
//  Created by Jentle on 2021/11/4.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()


@property(assign, nonatomic) Person *p;

@property(strong, nonatomic) NSString *address;

@property(assign, nonatomic) NSString *name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.address = @"Beijing";
    self.name = [NSString stringWithFormat:@"Jentle"];
    NSLog(@"%@",self.name);
    
//    self.p = [Person new];
//    self.p.name = @"Jentle";
//    NSLog(@"%@",self.p.name);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"address = %@",self.address);
    NSLog(@"name = %@",self.name);
}


@end
