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
/// mDict
@property(strong, nonatomic) NSMutableDictionary *mDict;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *getLabel;

@property (weak, nonatomic) IBOutlet UILabel *dicAddLabel;
@property (weak, nonatomic) IBOutlet UILabel *dicGetLabel;

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
    self.addLabel.text = [self.mArry componentsJoinedByString:@" "];
}

- (IBAction)getItem:(id)sender {
    
    static NSInteger time;
    ///'*** -[__NSArrayM objectAtIndex:]:
    ///index 0 beyond bounds for empty array'
    NSString *item = [self.mArry objectAtIndex:time];
    NSString *value = item == nil ? @"nil" : item;
    self.getLabel.text = [NSString stringWithFormat:@"%ld:%@",(long)time,value];
    time++;
    if (time > self.mArry.count + 3) {
        time = 0;
    }
}

- (NSMutableArray *)mArry {
    
    if (!_mArry) {
        _mArry = @[].mutableCopy;
    }
    return _mArry;
}

- (NSMutableDictionary *)mDict {
    
    if (!_mDict) {
        _mDict = @{}.mutableCopy;
    }
    return _mDict;
}

- (IBAction)dicAddItem:(id)sender {
    
    static NSInteger time;
    NSString *item = [NSString stringWithFormat:@"%ld",(long)time];
    BOOL random = arc4random()% 2 == 0;
    NSString *nilValue;
    NSString *key = @"value";
    ///[__NSDictionaryM setObject:forKey:]:
    ///object cannot be nil (key: value)'
    [self.mDict setObject:random ? item : nilValue forKey:key];
    ///当往数组添加nil时候，崩溃
    ///[__NSArrayM insertObject:atIndex:]: object cannot be nil'
    time++;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self.mDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.dicAddLabel.text = jsonString;
}

- (IBAction)dicGetItem:(id)sender {
    
    NSString *value = [self.mDict objectForKey:nil];
    self.dicGetLabel.text = [NSString stringWithFormat:@"%@",value ? value : @"nil"];
}

@end
