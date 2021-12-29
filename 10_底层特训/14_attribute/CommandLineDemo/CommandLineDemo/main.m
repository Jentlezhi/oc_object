//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}

__attribute__((constructor))
static void tes1(void) {
    NSLog(@"beforeMain");
};

__attribute__((destructor))
static void tes2(void) {
    NSLog(@"afterMain");
};


