//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"

@interface ViewController ()

@property(strong, nonatomic) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [Person new];
    self.p = p;
    NSLog(@"%@",[self getSubClass:[p class]]);
    /*
     2022-01-25 11:09:42.246083+0800 AppDemo[77457:27868737] (
         Student
     )
     */
    [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
    NSLog(@"%@",[self getSubClass:[p class]]);
    /*
     2022-01-25 11:09:42.247756+0800 AppDemo[77457:27868737] (
         "NSKVONotifying_Person",
         Student
     )
     */
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.p.age = 10;
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
