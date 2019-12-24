//
//  Presenter.m
//  Architecture
//
//  Created by Jentle on 2019/12/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Presenter.h"
#import "MyView.h"
#import "MyModel.h"

@interface Presenter ()

/// controller
@property(weak, nonatomic) UIViewController *controller;

@end

@implementation Presenter

- (instancetype)initWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        MyView *view = [[MyView alloc] init];
        view.frame = CGRectMake(100, 100, 100, 50);
        [controller.view addSubview:view];
    
        MyModel *model = [[MyModel alloc] init];
        model.iconName = @"wechat-1024x1024.png";
        model.title = @"微信";
        view.model = model;
    }
    return self;
}



@end
