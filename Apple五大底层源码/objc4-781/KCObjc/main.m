//
//  main.m
//  KCObjc
//
//  Created by Cooci on 2020/7/24.
//

#import <Foundation/Foundation.h>
#import "LGPerson.h"
#import "LGStudent.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        LGStudent *student = [LGStudent new];
        [student run];
    }
    return 0;
}
