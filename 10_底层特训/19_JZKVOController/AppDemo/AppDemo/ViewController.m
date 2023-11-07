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
    
    [self.kvoController observe:self.p keyPath:@"address" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self gcdInterView];

}

- (void)gcdInterView {
    
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            NSLog(@"1");
        });
        dispatch_async(queue, ^{
            NSLog(@"2");
        });
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"0");
        dispatch_async(queue, ^{
            NSLog(@"4");
        });
        dispatch_async(queue, ^{
            NSLog(@"5");
        });
        dispatch_async(queue, ^{
            NSLog(@"6");
        });
}


@end
