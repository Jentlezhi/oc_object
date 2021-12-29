//
//  Person+MyCategory.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/12/24.
//

#import "Person+MyCategory.h"
#import <objc/runtime.h>

@implementation Person (MyCategory)

+ (void)load {
    
    NSLog(@"%s",__func__);
}

- (void)categoryTest1 {
    
    NSLog(@"%s",__func__);
}

- (void)categoryTest2 {
    
    NSLog(@"%s",__func__);
}


- (void)setCategory_name:(NSString *)category_name {
    
    objc_setAssociatedObject(self, @selector(category_name), category_name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)category_name {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
