//
//  MyProxy.m
//  AppDemo
//
//  Created by Jentle on 2022/3/14.
//

#import "MyProxy.h"

@interface MyProxy ()

@end

@implementation MyProxy
{
     id realObject1;
     id realObject2;
}
- (id)initWithTarget1:(id)t1 target:(id)t2
 {
       realObject1 = t1;
       realObject2 = t2;
       return self;
 }

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
 {
      NSMethodSignature *signature;
      signature = [realObject1 methodSignatureForSelector:sel];
      if (signature) {
           return signature;
      }
      signature = [realObject2 methodSignatureForSelector:sel];
      return signature;
 }

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    id target = [realObject1 methodSignatureForSelector:invocation.selector]?realObject1:realObject2;
            [invocation invokeWithTarget:target];
}


-(BOOL)respondsToSelector:(SEL)aSelector
{
     if ([realObject1 respondsToSelector:aSelector]) {
        return YES;
     }
     if ([realObject2 respondsToSelector:aSelector]) {
        return YES;
      }
    return NO;
}

@end
