//
//  ViewController.m
//  Architecture
//
//  Created by Jentle on 2019/12/24.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()

/// ViewModel
@property(strong, nonatomic) ViewModel *viewModel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ViewModel alloc] initWithController:self];
}


@end
