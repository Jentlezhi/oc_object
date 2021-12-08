//
//  NSObject+EXT.m
//  method_swizzing
//
//  Created by Jentle on 2021/11/3.
//

#import "NSObject+EXT.h"
#import "RuntimeTool.h"

@implementation NSObject (EXT)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [RuntimeTool betterMethodSwizzlingWithClass:self oriSel:@selector(personInstanceMethod) swizzledSel:@selector(studentInstanceMethod)];
//        [RuntimeTool betterMethodSwizzlingWithClass:self oriSel:@selector(class) swizzledSel:@selector(my_class)];
        [RuntimeTool betterMethodSwizzlingWithClass:self oriSel:@selector(alloc) swizzledSel:@selector(my_alloc)];
    });

}

- (Class)my_alloc {
    NSLog(@"%s",__func__);
    return [self my_alloc];
}

- (Class)my_class {
    return [self my_class];
}

@end
