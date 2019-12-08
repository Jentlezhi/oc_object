//
//  main.m
//  ClassOrigin
//
//  Created by Jentle on 2019/9/6.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "XXClassInfo.h"


@interface Person : NSObject<NSCopying>
{
    @public
    int _age;
}

@property (nonatomic, assign) int height;

- (void)personMethod;
+ (void)personClassMethod;

@end

@implementation Person

- (void)personMethod {}
+ (void)personClassMethod {}

@end

/* Student */
@interface Student : Person <NSCoding>
{
@public
    int _no;
}

@property (nonatomic, assign) int score;

- (void)studentMethod;
+ (void)studentClassMethod;

@end

@implementation Student

- (void)studentMethod {}
+ (void)studentClassMethod {}

@end

void classObject(){
    
    NSObject *object = [[NSObject alloc] init];
    Person *person = [[Person alloc] init];
    Student *student = [[Student alloc] init];
    
    xx_objc_class *objectClass = (__bridge xx_objc_class *)[NSObject class];
    xx_objc_class *personClass = (__bridge xx_objc_class *)[Person class];
    xx_objc_class *studentClass = (__bridge xx_objc_class *)[Student class];
    
    
    class_rw_t *objectClassData = objectClass->data();
    class_rw_t *personClassData = personClass->data();
    class_rw_t *studentClassData = studentClass->data();

    xx_objc_class *objectMetaClass = objectClass->metaClass();
    xx_objc_class *personMetaClass = personClass->metaClass();
    xx_objc_class *studentMetaClass = studentClass->metaClass();
    
    class_rw_t *objectMetaClassData = objectMetaClass->data();
    class_rw_t *personMetaClassData = personMetaClass->data();
    class_rw_t *studentMetaClassData = studentMetaClass->data();
    
    // 0x00007ffffffffff8
    // p/x 0x001d800100001419 & 0x00007ffffffffff8  = 类对象的
    NSLog(@"%p %p %p %p %p %p %p %p %p %p %p %p",object, person, student,objectClass,personClass,studentClass,objectClassData, personClassData, studentClassData,
          objectMetaClassData, personMetaClassData, studentMetaClassData);
}

void isaAndObjectAddress() {
    
    Person *person = [[Person alloc] init];
    xx_objc_object *personObject = (__bridge xx_objc_object *)person;
    NSLog(@"person:%p isa:%p",person,personObject->isa);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        isaAndObjectAddress();
        
    }
    return 0;
}
