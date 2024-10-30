//
//  YYBundleHelper.h
//  LookinServer
//
//  Created by Jentle-Zhi on 2021/2/3.
//  加载bundle资源文件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYBundleHelper : NSObject

/**
 获取指定bundle的图片
 @param imageName      图片名称
 @param bundleName     bundle名称
 @return               图片
 */
+ (nullable UIImage *)imageName:(nonnull NSString *)imageName
                     bundleName:(nonnull NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
