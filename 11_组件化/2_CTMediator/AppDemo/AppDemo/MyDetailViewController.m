//
//  MyDetailViewController.m
//  AppDemo
//
//  Created by Jentle on 2022/3/6.
//

#import "MyDetailViewController.h"

@interface MyDetailViewController ()

@property(strong, nonatomic) UILabel *infoLabel;

@end

@implementation MyDetailViewController

- (UILabel *)infoLabel {
    
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
    }
    return _infoLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.infoLabel.frame = CGRectMake(0, 0, 200, 30);
    self.infoLabel.center = self.view.center;
    [self.view addSubview:self.infoLabel];
}

- (void)setPar:(NSDictionary *)par {
    _par = par;
    self.infoLabel.text = [par valueForKey:@"firstName"];
}

- (void)dealloc
{
    //反向传值：
    NSLog(@"%s",__func__);
}

@end
