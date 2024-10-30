//
//  YYBundleHelper.m
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/3.
//

#import "YYBundleHelper.h"

@implementation YYBundleHelper

/**
 获取指定bundle的图片
 @param imageName      图片名称
 @param bundleName     bundle名称
 @return               图片
 */
+ (nullable UIImage *)imageName:(nonnull NSString *)imageName
                     bundleName:(nonnull NSString *)bundleName {
    NSBundle *bundle = [self bundleWithName:bundleName];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIImage *)imageNamed:(NSString *)name {
    
    UIImage *image = [UIImage imageNamed:name
                                inBundle:[self currentBundle]
           compatibleWithTraitCollection:nil];
    return image;
}
/**
 获取当前Bundle
 */
+ (NSBundle *)currentBundle {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"YYResources" withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}
/**
 获取Bundle
 */
+ (NSBundle *)bundleWithName:(nonnull NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}


@end
