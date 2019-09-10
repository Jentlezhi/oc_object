//
//  main.m
//  CustomClass
//
//  Created by Jentle on 2019/8/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Student : NSObject
{
    @public
    int _no;
    int _age;
}

@end

@implementation Student

@end

/*
 struct Student_IMPL {
 struct NSObject_IMPL NSObject_IVARS;
 int _no;
 int _age;
 };
 */

///等价于
/*
 struct Student_IMPL {
 Class isa;
 int _no;
 int _age;
 };
 */
struct Student_IMPL {
    Class isa;
    int _no;
    int _age;
};

BOOL IsBigEndian(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *stu = [[Student alloc] init];
        stu->_no = 4;
        stu->_age = 5;
        
        struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)(stu);
        NSLog(@"[sutImpl]:_no=%d,_age=%d",stuImpl->_no,stuImpl->_age);
        size_t size = class_getInstanceSize([Student class]);
        NSLog(@"%zu",size);//16
        
        ///判断机器的字节序
        NSLog(@"bigEndian%d",IsBigEndian());
        
        
    }
    return 0;
}

BOOL IsBigEndian(void){
    
    int a = 0x1234;
    char b =  *(char *)&a;  //通过将int强制类型转换成char单字节，通过判断起始存储位置。即等于 取b等于a的低地址部分
    if( b == 0x12)
    {
        return TRUE;
    }
    return FALSE;
}
