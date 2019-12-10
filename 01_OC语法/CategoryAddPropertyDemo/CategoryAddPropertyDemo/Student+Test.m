//
//  Student+Test.m
//  CategoryAddPropertyDemo
//
//  Created by Jentle on 2019/11/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student+Test.h"
#import <objc/runtime.h>

@implementation Student (Test)

///key的写法1,没有值，导致多个关联对象时候，无法获取到正确的值。
//const void *StuNameKey;
//const void *StuGenderKey;

///key的写法2,外界通过extern const void *StuNameKey;可以随意修改值
///void *则为“无类型指针”，void *可以指向任何类型的数据。
//const void *StuNameKey = &StuNameKey;
//const void *StuGenderKey = &StuGenderKey;

///key的写法3,static确保只能内部使用，外界不得修改
//static const void *StuNameKey = &StuNameKey;
//static const void *StuGenderKey = &StuGenderKey;

///key的写法4,const void * _Nonnull key，说明需要一个地址（void *）值，所以没有必要给赋值，通过&StuNameKey访问地址即可
//static const void *StuNameKey;
static const void *StuGenderKey;

///key的写法5,key传一个字符串（@"name",直接写出来的字符串是放在内存中的常量区，它的地址是不会变的）,key实际上就是一个地址
#define StuNameKey @"name"
//objc_setAssociatedObject(self, StuNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//return objc_getAssociatedObject(self, StuNameKey);

///key的写法6,key传@selector(name)
//objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//return objc_getAssociatedObject(self, @selector(name));

- (void)setName:(NSString *)name {
//NSLog(@"%@:StuNameKey:%p",NSStringFromSelector(_cmd),StuNameKey);
/*
 objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
 id _Nullable value, objc_AssociationPolicy policy)
 object:关联的源对象
 key:关联对象的key，传空会清除关联
 policy: 关联策略
 */
    
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setGender:(NSString *)gender {
    
    objc_setAssociatedObject(self, &StuGenderKey, gender, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)gender {
    
    return objc_getAssociatedObject(self, &StuGenderKey);
}

@end
