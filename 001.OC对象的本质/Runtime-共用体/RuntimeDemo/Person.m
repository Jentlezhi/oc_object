//
//  Person.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

///掩码 一般用来按位与运算
//#define TallMask 1
//#define RichMask 2
//#define HnadsomeMask 4

//#define TallMask 0b00000001
//#define RichMask 0b00000010
//#define HandsomeMask 0b00000100

#define TallMask (1<<0)
#define RichMask (1<<1)
#define HandsomeMask (1<<2)

///位域

#import "Person.h"

@interface Person ()
{
    union {
        char bits;
        ///增加可读性：
        struct{
            char tall : 1;
            char rich : 1;
            char handsome : 1;
        };
    }_tallRichHandsome;
}

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        ///二进制
//        _tallRichHandsome = 0b00000000;
    }
    return self;
}

#pragma mark - Setter

- (void)setTall:(BOOL)tall {
    
    if (tall) {
        ///把首位置为1,其他位不变
        //   00000001
        // | 00000001
        _tallRichHandsome.bits |= TallMask;
    }else{
        ///把首位置为0
      //   00000001
      // & 11111110
        _tallRichHandsome.bits &= ~TallMask;
    }
}

- (void)setRich:(BOOL)rich {
    
    if(rich){
        _tallRichHandsome.bits |= RichMask;
    }else{
        _tallRichHandsome.bits &= ~RichMask;
    }
}

- (void)setHandsome:(BOOL)handsome {
    
    if(handsome){
        _tallRichHandsome.bits |= HandsomeMask;
    }else{
        _tallRichHandsome.bits &= ~HandsomeMask;
    }
}



#pragma mark - Getter

- (BOOL)isTall {
    ///双感叹号!!作用就是非0值转成1，而0值还是0.双感叹号!!是为了把"非0值"转换成1，而0值还是0。
    return !!(_tallRichHandsome.bits & TallMask);
}

- (BOOL)isRich {
    return !!(_tallRichHandsome.bits & RichMask);
}

- (BOOL)isHandsome {
  
    return !!(_tallRichHandsome.bits & HandsomeMask);
}

@end
