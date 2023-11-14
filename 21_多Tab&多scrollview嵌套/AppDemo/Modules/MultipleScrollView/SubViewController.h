//
//  SubViewController.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/13.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : UIViewController<JXPagerViewListViewDelegate>

@property(nonatomic, copy) NSString *rowTitle;

@end

NS_ASSUME_NONNULL_END
