//
//  ViewController.m
//  AspectsDemo
//
//  Created by Jentle on 2021/10/8.
//

#import "ViewController.h"
#import "Aspects.h"
#import <BlockHook/BlockHook.h>
#import "TestObject.h"
#import "MyView.h"

@interface ViewController ()

@property(copy, nonatomic) NSString *name;

@property(assign, nonatomic) TestObject *object;

@end


//切面编程：这种在运行时，动态地将代码切入到类的指定方法、指定位置上的编程思想就是面向切面的编程。
@implementation ViewController

@synthesize name = _name;

- (void)setName:(NSString *)name {
    
    _name = name;
}

- (NSString *)name {
    
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hook_block];
//    [self aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionInstead usingBlock:^() {
//        NSLog(@"**********");
//    } error:nil];
    [self testAssign];
    [self test];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSLog(@"%s",__func__);
}

- (void)hook_block {
    
    NSObject *z = NSObject.new;
    int(^block)(int x, int y) = ^int(int x, int y) {
        int result = x + y;
        NSLog(@"%d + %d = %d, z is a NSObject: %@", x, y, result, z);
        return result;
    };
        
    BHToken *token = [block block_hookWithMode:BlockHookModeDead|BlockHookModeBefore|BlockHookModeInstead|BlockHookModeAfter usingBlock:^(BHInvocation *invocation, int x, int y) {
        int ret = 0;
        [invocation getReturnValue:&ret];
        switch (invocation.mode) {
            case BlockHookModeBefore:
                // BHInvocation has to be the first arg.
                NSLog(@"hook before block! invocation:%@", invocation);
                break;
            case BlockHookModeInstead:
                [invocation invokeOriginalBlock];
                NSLog(@"let me see original result: %d", ret);
                // change the block imp and result
                ret = x * y;
                [invocation setReturnValue:&ret];
                NSLog(@"hook instead: '+' -> '*'");
                break;
            case BlockHookModeAfter:
                // print args and result
                NSLog(@"hook after block! %d * %d = %d", x, y, ret);
                break;
            case BlockHookModeDead:
                // BHInvocation is the only arg.
                NSLog(@"block dead! token:%@", invocation.token);
                break;
            default:
                break;
        }
    }];
        
    NSLog(@"hooked block");
    int ret = block(3, 5);
    NSLog(@"hooked result:%d", ret);
    // remove token.
    [token remove];
    NSLog(@"remove tokens, original block");
    ret = block(3, 5);
    NSLog(@"original result:%d", ret);

}

- (void)testAssign {
    //obj是个临时变量，仅在这个作用域内有效
    TestObject *obj = [TestObject new];
    self.object = obj;
    self.object.property = @"x";
}

- (void)test {
    
    MyView *view = MyView.new;
    view.backgroundColor = UIColor.redColor;
    view.frame = CGRectMake(0, 0, 200, 200);
    view.center = self.view.center;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    [self.view addSubview:view];
    
}

- (void)tapAction {
    
    NSLog(@"%s",__func__);
    [self performSelector:<#(nonnull SEL)#> onThread:<#(nonnull NSThread *)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>



@end
