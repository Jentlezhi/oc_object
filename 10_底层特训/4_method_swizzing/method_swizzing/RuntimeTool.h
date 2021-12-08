//
//  RuntimeTool.h
//  method_swizzing
//
//  Created by Jentle on 2021/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTool : NSObject

+ (void)methodSwizzlingWithClass:(Class)cls oriSel:(SEL)oriSel swizzledSel:(SEL)swizzledSel;
+ (void)betterMethodSwizzlingWithClass:(Class)cls oriSel:(SEL)oriSel swizzledSel:(SEL)swizzledSel;

@end

NS_ASSUME_NONNULL_END
