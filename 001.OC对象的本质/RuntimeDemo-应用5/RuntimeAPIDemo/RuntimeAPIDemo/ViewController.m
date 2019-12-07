//
//  ViewController.m
//  RuntimeAPIDemo
//
//  Created by Jentle on 2019/12/6.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/// mArry
@property(strong, nonatomic) NSMutableArray *mArry;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *getLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)addItem:(id)sender {
    
    static NSInteger time;
    NSString *item = [NSString stringWithFormat:@"%ld",(long)time];
    BOOL random = arc4random()% 2 == 0;
    NSString *nilValue;
    [self.mArry addObject:random ? item : nilValue];
    ///当往数组添加nil时候，崩溃
    ///[__NSArrayM insertObject:atIndex:]: object cannot be nil'
    time++;
}

- (IBAction)getItem:(id)sender {
    
    
}

- (NSMutableArray *)mArry {
    
    if (!_mArry) {
        _mArry = @[].mutableCopy;
    }
    return _mArry;
}

@end
