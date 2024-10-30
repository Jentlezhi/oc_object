//
//  YYMethodSwizzling.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYMethodSwizzling : NSObject 

///=============================================================================
///
///=============================================================================
+ (void)yy_methodSwizzlingWithClass:(Class)cls
                        originalSEL:(SEL)originalSEL
                        swizzledSEL:(SEL)swizzledSEL;

@end

NS_ASSUME_NONNULL_END
