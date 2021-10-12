//
//  ViewController.m
//  RuntimeDemo-窥探组件内部成员变量
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.placeholder = @"请输入姓名";
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([UITextField class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s - %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    
//    _placeholderLabel - @"UITextFieldLabel"
    
//    UILabel *label = [self.nameTextField valueForKey:@"_placeholderLabel"];
//    label.textColor = UIColor.redColor;
}


@end
