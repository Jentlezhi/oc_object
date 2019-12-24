//
//  ViewController.m
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "MyModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *view = [[MyView alloc] init];
    view.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:view];
    
    MyModel *model = [[MyModel alloc] init];
    model.iconName = @"wechat-1024x1024.png";
    model.title = @"微信";
    
    
    view.model = model;

}


@end
