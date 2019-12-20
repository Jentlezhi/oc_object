//
//  main.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 在10_14以后苹果对TaggedPointer进行了混淆,与objc_debug_taggedpointer_obfuscator进行了异或运算
 */
extern uintptr_t objc_debug_taggedpointer_obfuscator;
uintptr_t _objc_decodeTaggedPointer_(id  ptr) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wformat"
      NSString *p = [NSString stringWithFormat:@"%ld",ptr];
    #pragma clang diagnostic pop
    
    return [p longLongValue] ^ objc_debug_taggedpointer_obfuscator;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //在10_14以后苹果对TaggedPointer进行了混淆:
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wformat"
        NSNumber *number1 = @3;
        NSNumber *number2 = @4;
        NSNumber *number3 = @5;
        NSLog(@"number1=%p",_objc_decodeTaggedPointer_(number1));
        //number1=0x327
        NSLog(@"number2=%p",_objc_decodeTaggedPointer_(number2));
        //number2=0x427
        NSLog(@"number3=%p",_objc_decodeTaggedPointer_(number3));
        //number3=0x527
        
    #pragma clang diagnostic pop
        
    }
    return 0;
}
