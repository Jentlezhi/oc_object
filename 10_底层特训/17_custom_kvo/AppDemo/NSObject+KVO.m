//
//  NSObject+KVO.m
//  AppDemo
//
//  Created by Jentle on 2022/2/5.
//

#import "NSObject+KVO.h"
#import <objc/message.h>

static NSString *const KVOAssiociateKey = @"KVOAssiociateKey";

@interface KVOInfo: NSObject

@property(weak, nonatomic) NSObject *observer;
@property(copy, nonatomic) NSString *keyPath;
@property(strong, nonatomic) id context;
@property(strong, nonatomic) id oldValue;
@property(copy, nonatomic) void(^kvoHandel)(NSString *keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> *change,void * context);

+ (instancetype)infoWithObserver:(NSObject *)observer
                         keyPath:(NSString *)keyPath
                         context:(id)context
                       kvoHandel:(void(^)(NSString *keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> *change,void * context))kvoHandel;

@end

@implementation KVOInfo

+ (instancetype)infoWithObserver:(NSObject *)observer
                         keyPath:(NSString *)keyPath
                         context:(id)context
                       kvoHandel:(void(^)(NSString *keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> *change,void * context))kvoHandel {
    KVOInfo *info = [[KVOInfo alloc] init];
    info.observer = observer;
    info.keyPath = keyPath;
    info.kvoHandel = kvoHandel;
    return info;
}

@end

@interface NSObject ()

@end

@implementation NSObject (KVO)

- (void)custom_addObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                   context:(nullable void *)context
                completion:(void(^)(NSString *keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> *change,void * context))block{

    //1.判断是否显示setter方法
    if (![self isOfferedMethodWithKeyPath:keyPath]) {
        NSString *info = [NSString stringWithFormat:@"不能观察未实现set%@:的成员变量",[self uppercaseFirstLatterWithString:keyPath]];
        NSLog(@"%@",info);
        return;
    }
    //2.创建子类
    Class kvoClass = [self createChildClassWithKeyPath:keyPath];
    //3.修改isa的指向
    object_setClass(self, kvoClass);
    //4.保存参数，以便于外部block被覆盖
    KVOInfo *info = [KVOInfo infoWithObserver:observer keyPath:keyPath context:(__bridge id)(context) kvoHandel:block];
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(KVOAssiociateKey));
    if (!observerArr) {
        observerArr = @[].mutableCopy;
        objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(KVOAssiociateKey), observerArr, OBJC_ASSOCIATION_RETAIN);
    }
    [observerArr addObject:info];
}

- (void)custom_removeObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(KVOAssiociateKey));
    if (!observerArr || observerArr.count == 0) return;
    NSMutableArray *removedArray = @[].mutableCopy;
    for (KVOInfo *info in observerArr) {
        if ([info.observer isEqual:observer] && [info.keyPath isEqualToString:keyPath]) {
            [removedArray addObject:info];
        }
    }
    [observerArr removeObjectsInArray:removedArray];
    //修改isa的指向
    if (observerArr.count == 0) {
        object_setClass(self, class_getSuperclass([self class]));
    }
}

#pragma mark - Method

- (BOOL)isOfferedMethodWithKeyPath:(NSString *)keyPath {
    
    NSString *methodName = [NSString stringWithFormat:@"set%@:",[self uppercaseFirstLatterWithString:keyPath]];
    Class cls = object_getClass(self);
    SEL sel = NSSelectorFromString(methodName);
    Method method = class_getInstanceMethod(cls, sel);
    return method != nil;
}

-  (Class)createChildClassWithKeyPath:(NSString *)keyPath {
    
    NSString *oldClassName = NSStringFromClass([self class]);
    Class newClass;
    BOOL kvoSubClassCreated = [oldClassName containsString:@"MyNSKVONotifying_"];
    if (!kvoSubClassCreated) {
        NSString *newClassName = [NSString stringWithFormat:@"MyNSKVONotifying_%@",oldClassName];
        if (newClass) return newClass;
        newClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    }else{
        newClass = [self class];
    }
    SEL sel  = NSSelectorFromString([NSString stringWithFormat:@"set%@:",[self uppercaseFirstLatterWithString:keyPath]]);
    Method method = class_getInstanceMethod([self class], sel);
    const char *types = method_getTypeEncoding(method);
    IMP imp = [self methodForSelector:@selector(impSetter:)];
    class_addMethod(newClass, sel, imp, types);
    if (!kvoSubClassCreated) {
        objc_registerClassPair(newClass);
    }
    return newClass;
}

//子类重写set方法
- (void)impSetter:(id)newValue {
    
    NSString *keyPath = [self keyPathFromSel:_cmd];
    //调用父类的setter方法
    void (*my_msgSendSuper)(void *,SEL , id) = (void *)objc_msgSendSuper;
    struct objc_super superStruct = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self)),
    };
    my_msgSendSuper(&superStruct, _cmd, newValue);
    //取出数组中的block
    NSMutableArray *observerArr = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(KVOAssiociateKey));
    for (KVOInfo *info in observerArr) {
        if ([info.keyPath isEqualToString:keyPath] && info.kvoHandel) {
            if (!info.oldValue) {
                info.oldValue = @"<null>";
            }
            info.kvoHandel(keyPath, self, @{@"newValue":newValue,@"oldValue":info.oldValue}, (__bridge void *)(info.context));
            info.oldValue = newValue;
        }
    }
}

- (NSString *)uppercaseFirstLatterWithString:(NSString *)str {
    if (str == nil || str.length == 0) {
        return nil;
    }
    NSString *keyFirst = [str substringToIndex:1];
    NSString *keyLast = [str substringFromIndex:1];
    return [NSString stringWithFormat:@"%@%@",keyFirst.uppercaseString,keyLast];
}

- (NSString *)keyPathFromSel:(SEL)sel {
    NSString *selName = NSStringFromSelector(sel);
    NSString *proName = [selName substringFromIndex:3];
    proName = [proName substringToIndex:proName.length-1];
    NSString *first = [proName substringToIndex:1];
    return  [NSString stringWithFormat:@"%@%@",first.lowercaseString,[proName substringFromIndex:1]];
}

@end
