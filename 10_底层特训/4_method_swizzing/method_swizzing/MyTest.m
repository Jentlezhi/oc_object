//
//  MyTest.m
//  method_swizzing
//
//  Created by Jentle on 2022/3/23.
//

#import "MyTest.h"

@implementation MyTest

- (void)test {
    
    NSLog(@"%s",__func__);
}

//- (void)otherTest {
//
//    NSLog(@"%s",__func__);
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == @selector(otherTest)) {
        NSLog(@"otherTest");
    }
    return YES;
}

@end
