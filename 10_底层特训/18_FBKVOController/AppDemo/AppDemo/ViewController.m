//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "FBKVOController.h"
#import "Person.h"

@interface ViewController ()

@property(strong, nonatomic) Person *p;

@property(strong, nonatomic) FBKVOController *kvoController;

@end

@implementation ViewController

- (FBKVOController *)kvoController {
    
    if (!_kvoController) {
        _kvoController = [FBKVOController controllerWithObserver:self];
    }
    return _kvoController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [Person new];
    self.p = p;
    [self.kvoController observe:self.p keyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change);
    }];
    
    [self.kvoController observe:self.p keyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change);
    }];
    
    [self.kvoController observe:self.p keyPath:@"address" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change);
    }];
    
    UIView *view;
    [UIView animateWithDuration:1.f animations:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.p.name = @"Jentle";
    self.p.address = @"BeiJing";
}


@end
