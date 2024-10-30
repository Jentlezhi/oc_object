//
//  NSObject+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YYExtension)

/**
 转成字符串
 */
- (NSString *)yy_toString;
/**
 把模型中存在的所有值赋值给另一个model
 @param toModel      目标model
 */
- (void)yy_setAllPropertiesValueToModel:(nonnull id)toModel;

/// 获取类的所有属性
@property(nonatomic, strong, class, readonly) NSArray<NSString *> *yy_allProperties;


@end

NS_ASSUME_NONNULL_END
