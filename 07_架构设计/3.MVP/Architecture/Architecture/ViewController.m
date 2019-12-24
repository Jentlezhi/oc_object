//
//  ViewController.m
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Presenter.h"

@interface ViewController ()

/// presenter
@property(strong, nonatomic) Presenter *presenter;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[Presenter alloc] initWithController:self];
}


@end
