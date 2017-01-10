//
//  Person.m
//  Runtime_test
//
//  Created by Young on 2017/1/8.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/objc.h>

void dynamicMethodIMP(id self , SEL _cmd) {
    
    
}

@implementation Person

//@dynamic indentifyNumber;

//+ (BOOL)resolveClassMethod:(SEL)sel {
//    //class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
//}

@end
