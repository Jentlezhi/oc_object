//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Person.h"


@interface ViewController ()

@property(strong, nonatomic) Person *p;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *address;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.p = [Person new];
    self.name = [NSString stringWithFormat:@"Jentle"];
    self.address = @"BeiJing";
    
    self.p.name = self.name;
    self.p.address = self.address;
    
    Person *p1 = [self.p copy];
    NSLog(@"%@",p1);
    
    id x = [NSProxy alloc];
    id n = [NSNumber numberWithInt:1];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}




@end
