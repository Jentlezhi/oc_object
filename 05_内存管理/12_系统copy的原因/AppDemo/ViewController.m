//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField *textField;
    textField.text = @"124";
    
    NSMutableString *content  = [[NSMutableString alloc] initWithString:@"123"];
    textField.text = content;
    //修改content,
    [content appendString:@"456"];
    
    UIView *v;
    UIButton *b;
    UIControl *c;
    
    
}


@end
