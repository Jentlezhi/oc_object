//
//  main.m
//  NSMutableArray-Analylysis
//
//  Created by Jentle on 2021/6/7.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "MyMutableArray.h"

Class typeOfNSMutableArray(){
    NSMutableArray *mArray = NSMutableArray.new;
    /*
     OBJC_EXPORT Class _Nullable
     objc_getClass(const char * _Nonnull name)
         OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0, 2.0);
     */
    Class c = object_getClass(mArray);
    NSLog(@"%@",c);/*__NSArrayM*/
    return c;
}

void membersOfNSMutableArray(){
    
    unsigned int count = 0;
    /*
     class_copyIvarList(Class _Nullable cls, unsigned int * _Nullable outCount)
     */
    NSMutableArray *obj = NSMutableArray.new;
    Ivar *members = class_copyIvarList(obj.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = members[i];
        NSLog(@"%s",ivar_getName(ivar));
        /*cow/storage*/
    }
}

/// 获取 arrayM 描述信息
NSString* getArrayDesc(NSMutableArray *list) {
    assert([NSStringFromClass([list class]) isEqualToString:@"__NSArrayM"]);
    MyMutableArray *array = (MyMutableArray *)list;
    NSMutableString *description = [[NSMutableString alloc] init];
    int offset = array->storage.offset;
    int size = array->storage.size;
//    [description appendFormat:@"cow:%@", array->cow];
    [description appendFormat:@"offset:%d", offset];
    [description appendFormat:@",size:%d", size];
    [description appendFormat:@",used:%u", array->storage.state.used];
    [description appendFormat:@",mutations:%llu", array->storage.state.mutations];
    [description appendFormat:@",muts:%u\n", array->storage.state.muts];
    for (int i = 0; i < size; i++) {
//        if (i==0) {
//            [description appendString:@"\r\n"];
//        }
        //
        [description appendFormat:@"[%d]%@,%p  |  ", i
        , array->storage.list[i], array->storage.list[i]];
    }
    return description;
}

void testMArray(){
    
    NSString *obj1 = @"A";
    NSString *obj2 = @"B";
    NSString *obj3 = @"C";
    NSString *obj4 = @"D";
    NSString *obj5 = @"E";
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:1];
    NSLog(@"1.init_%@",getArrayDesc(list));
    
    [list addObject:obj1];
    [list addObject:obj2];
    NSLog(@"2.add object:_%@",getArrayDesc(list));
    
    [list insertObject:obj3 atIndex:0];
    NSLog(@"3.insertObject atIndex:0:_%@",getArrayDesc(list));
    
    [list removeObjectAtIndex:0];
    NSLog(@"4.removeObjectAtIndex:0:_%@",getArrayDesc(list));

}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testMArray();
    }
    return 0;
}
