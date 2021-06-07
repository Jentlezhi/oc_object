//
//  MyMutableArray.h
//  NSMutableArray-Analylysis
//
//  Created by Jentle on 2021/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
     //id = void * 缓冲区元素数组首地址指针
    void *_Nullable*list;
    //首元素位置
    unsigned int offset;
    //总大小
    unsigned int size;
    union {
        unsigned long long mutations;
        struct {
            //总大小
            unsigned int muts;
            //使用的大小
            unsigned int used;
        } ;
    } state;
} CDStruct_a6934631;

@interface MyMutableArray : NSObject {
    
@public void *cow;
@public CDStruct_a6934631 storage;
    
}

@end

NS_ASSUME_NONNULL_END
