//
//  ViewController.m
//  BitOperationDemo
//
//  Created by Jentle on 2019/11/27.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    OptionsOne = 1<<0, ///0b0001
    OptionsTwo = 1<<1,///0b0010
    OptionsThree = 1<<2,///0b0100
    OptionsFour = 1<<3,///0b1000
} Options;

@interface ViewController ()


@property(assign, nonatomic) Options options;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
 OptionsOne     0b0001
 OptionsTwo     0b0010
 OptionsThree   0b0100
 OptionsFour    0b1000
 ------------------------
  或
                0b1111
 
 取当前值：
 按位与          0b0001
 ------------------------
                0b0001
 */
   
    
    self.options = OptionsTwo | OptionsThree | OptionsFour;
    
}

- (void)setOptions:(Options)options {
    
    _options = options;
    ///如何获取？
    if (options & OptionsOne) {
        NSLog(@"OptionsOne");
    }
    if (options & OptionsTwo) {
        NSLog(@"OptionsTwo");
    }
    if (options & OptionsThree) {
        NSLog(@"OptionsThree");
    }
    if (options & OptionsFour) {
        NSLog(@"OptionsFour");
    }
}


@end
