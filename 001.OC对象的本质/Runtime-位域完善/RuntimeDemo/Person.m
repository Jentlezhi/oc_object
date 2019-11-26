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
//    char _tallRichHandsome;
    struct {
        char tall : 1;
        char rich : 1;
        char handsome : 1;
    } tallRichHandsome;
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
    
    tallRichHandsome.tall = tall;
//    if (tall) {
//        ///把首位置为1,其他位不变
//        //   00000001
//        // | 00000001
//        _tallRichHandsome |= TallMask;
//    }else{
//        ///把首位置为0
//      //   00000001
//      // & 11111110
//        _tallRichHandsome &= ~TallMask;
//    }
}

- (void)setRich:(BOOL)rich {
    
    tallRichHandsome.rich = rich;
//    if(rich){
//        _tallRichHandsome |= RichMask;
//    }else{
//        _tallRichHandsome &= ~RichMask;
//    }
}

- (void)setHandsome:(BOOL)handsome {
    tallRichHandsome.handsome = handsome;
//    if(handsome){
//        _tallRichHandsome |= HandsomeMask;
//    }else{
//        _tallRichHandsome &= ~HandsomeMask;
//    }
}



#pragma mark - Getter

- (BOOL)isTall {
    ///双感叹号!!作用就是非0值转成1，而0值还是0.双感叹号!!是为了把"非0值"转换成1，而0值还是0。
    return !!tallRichHandsome.tall;
//    return !!(_tallRichHandsome & TallMask);
}

- (BOOL)isRich {
    
    return !!tallRichHandsome.rich;
//    return !!(_tallRichHandsome & RichMask);
}

- (BOOL)isHandsome {
    
    return !!tallRichHandsome.handsome;
//    return !!(_tallRichHandsome & HandsomeMask);
}

@end
