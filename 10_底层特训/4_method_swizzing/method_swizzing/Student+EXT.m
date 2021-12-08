//
//  Student+EXT.m
//  method_swizzing
//
//  Created by Jentle on 2021/11/2.
//

#import "Student+EXT.h"
#import "RuntimeTool.h"

@implementation Student (EXT)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [RuntimeTool betterMethodSwizzlingWithClass:self oriSel:@selector(personInstanceMethod) swizzledSel:@selector(studentInstanceMethod)];
        [RuntimeTool betterMethodSwizzlingWithClass:self oriSel:@selector(helloworld) swizzledSel:@selector(studentInstanceMethod)];
    });

}

- (void)studentInstanceMethod {
    [self class];
    NSLog(@"%s",__func__);
}

@end
