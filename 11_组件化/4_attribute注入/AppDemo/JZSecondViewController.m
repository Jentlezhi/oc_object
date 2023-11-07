//
//  JZSecondViewController.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZSecondViewController.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>

#define HMAnnotationDATA(storeName) __attribute((used, section("__DATA,"#storeName" ")))

/**
 *  Use this to annotation a `module`
 *  like this: @HMSectionStoreModule()
 */
#define HMSectionStoreModule(storeName,modName) \
char * kHMSectionStoreModule_##modName HMAnnotationDATA(storeName) = "M:"#modName"";

NSArray<NSString *>* HMSectionStoreReadConfigFromSection(const char *sectionName){
    #ifndef __LP64__
        const struct mach_header *mhp = NULL;
    #else
        const struct mach_header_64 *mhp = NULL;
    #endif
        
        NSMutableArray *configs = [NSMutableArray array];
        Dl_info info;
        if (mhp == NULL) {
            dladdr(HMSectionStoreReadConfigFromSection, &info);
    #ifndef __LP64__
            mhp = (struct mach_header*)info.dli_fbase;
    #else
            mhp = (struct mach_header_64*)info.dli_fbase;
    #endif
        }
        
    #ifndef __LP64__
        unsigned long size = 0;
     // 找到之前存储的数据段的一片内存
        uint32_t *memory = (uint32_t*)getsectiondata(mhp, SEG_DATA, sectionName, & size);
    #else /* defined(__LP64__) */
        unsigned long size = 0;
        uint64_t *memory = (uint64_t*)getsectiondata(mhp, SEG_DATA, sectionName, & size);
    #endif /* defined(__LP64__) */
        
        for(int idx = 0; idx < size/sizeof(void*); ++idx){
            char *string = (char*)memory[idx];
            // 把特殊段里面的数据都转换成字符串存入数组中
            NSString *str = [NSString stringWithUTF8String:string];
            if(!str)continue;
            if(str) [configs addObject:str];
        }
        return configs;
}

/**
编译的时候，存储数据到.data中
*/
HMSectionStoreModule(__jentle__,1111)
HMSectionStoreModule(__jentle__,2222)
HMSectionStoreModule(__jentle__,3333)
HMSectionStoreModule(__data,111)
HMSectionStoreModule(__data,222)
HMSectionStoreModule(__data,333)

@interface JZSecondViewController ()

@end

@implementation JZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#afa9e5"];
    
    //获取注入的数据
    NSArray<NSString *> *dataListInSection = HMSectionStoreReadConfigFromSection("Jentle");
    for (NSString *dataString in dataListInSection) {
        NSLog(@"获取section中存储的数据--> %@",dataString);
    }
}

@end
