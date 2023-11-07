//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"
#import "NSObject+KVO.h"

@interface ViewController ()

@property(strong, nonatomic) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.p = [Person new];
//    [self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
//    [self.p removeObserver:nil forKeyPath:nil];
    
    [self.p custom_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL completion:^(NSString * _Nonnull keyPath, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change, void * _Nonnull context) {
        NSLog(@"%@",change);
    }];
    
    [self.p custom_addObserver:self forKeyPath:@"address" options:NSKeyValueObservingOptionNew context:NULL completion:^(NSString * _Nonnull keyPath, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change, void * _Nonnull context) {
        NSLog(@"%@",change);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.p.name = @"Jentle";
    self.p.address =  @"BeiJing";
    [self.p custom_removeObserver:self forKeyPath:@"address"];
    self.p.name = @"JentleZhi";
    self.p.address =  @"Nanjing";
    [self.p custom_removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    NSLog(@"%@",change);
}

- (NSArray *)getSubClass:(Class)cls{
    int numClasses = objc_getClassList(NULL,0);;
    Class* classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    objc_getClassList(classes, numClasses);
    NSMutableArray *mArray =  @[].mutableCopy;
    for (int index = 0; index < numClasses; index++) {
        if (cls == class_getSuperclass(classes[index])) {
            [mArray addObject:classes[index]];
        }
    }
    return mArray;
}


@end
