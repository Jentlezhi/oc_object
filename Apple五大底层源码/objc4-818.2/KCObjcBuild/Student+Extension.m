//
//  Student+Extension.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/10/25.
//

#import "Student+Extension.h"
#import "RuntimeTool.h"

@implementation Student (Extension)

+ (void)load {
    NSLog(@"%s",__func__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeTool methodSwizzlingWithClass:[self class] oriSel:@selector(alloc) swizzledSel:@selector(my_alloc)];
    });
}

+ (instancetype)my_alloc {
    NSLog(@"%s",__func__);
    return [self my_alloc];
}

//+ (void)initialize {
//    
//    NSLog(@"%s",__func__);
//}

@end
