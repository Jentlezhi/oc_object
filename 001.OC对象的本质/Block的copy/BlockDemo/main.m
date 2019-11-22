//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(void);

Block blockFunc(){
    
    int a = 100;
    Block block = ^{
      NSLog(@"blockFunc:%d",a);
    };
    NSLog(@"in blockFunc - %@",[block class]);
    ///block是NSStackBlock__，存放在栈中,copy之后block会从栈区复制到堆区。
    return [block copy];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ///MRC下，Block block = blockFunc();执行完之后，栈上的内存被回收了
        Block block = blockFunc();
        
        ///Thread 1: EXC_BAD_ACCESS (code=1, address=0x7ffeefc07570)
        block();
        NSLog(@"%@",[block class]);
        
    }
    return 0;
}


