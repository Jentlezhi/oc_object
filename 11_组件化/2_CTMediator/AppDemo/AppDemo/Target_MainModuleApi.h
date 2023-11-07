//
//  MainModuleApi.h
//  AppDemo
//
//  Created by Jentle on 2022/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_MainModuleApi : NSObject

- (NSString *)Action_greet:(NSDictionary *)par;

- (UIImageView *)Action_getImageView:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
