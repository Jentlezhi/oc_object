//
//  YYComponentsMacro.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2020/06/08.
//  Copyright © 2018 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifndef _YYCOMPONENTSMACRO_
  #define _YYCOMPONENTSMACRO_

//设备的尺寸
#define YY_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define YY_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
///延迟执行
#define YYDelayExecute(t, Stuff) \
^{\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
    Stuff;\
});\
}()
//单次执行
#define YYExecuteOnce(Stuff) \
^{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        Stuff;\
    });\
}()
//主队列异步执行
#define YYExecuteOnMainQueue(Stuff) \
^{\
    dispatch_async(dispatch_get_main_queue(), ^{\
         Stuff;\
    });\
}()
///=============================================================================
///关联属性：key传@selector(propertyName)，policy根据类型传值
///OBJC_ASSOCIATION_ASSIGN：给关联对象指定弱引用 相当于@property(assign)或@property(unsafe_unretained)
///
///OBJC_ASSOCIATION_RETAIN_NONATOMIC：给关联对象指定非原子的强引用,相当于@property(nonatomic,strong)或@property(nonatomic,retain)
///
///OBJC_ASSOCIATION_COPY_NONATOMIC：给关联对象指定非原子的copy特性,相当于@property(nonatomic,copy)
///
///OBJC_ASSOCIATION_RETAIN：给关联对象指定原子强引用,相当于@property(atomic,strong)或@property(atomic,retain)
///
///OBJC_ASSOCIATION_COPY：给关联对象指定原子copy特性,相当于@property(atomic,copy)
///=============================================================================
#define YYSetAssociatedObject(key, value, policy) \
^{\
objc_setAssociatedObject(self, key, value, policy);\
}()

#define YYGetAssociatedObject() \
^{\
return objc_getAssociatedObject(self, _cmd);\
}()

#endif /* _YYCOMPONENTSMACRO_ */
