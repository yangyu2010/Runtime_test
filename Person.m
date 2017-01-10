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

@implementation Person

+(Person *)sharedManager {
    static Person *sharedManager;
    static dispatch_once_t onceTest;
    dispatch_once(&onceTest, ^{
        sharedManager = [[Person alloc] init];
    });
    NSLog(@"+ method");
    return sharedManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [super init];
        self.height = 1.88f;
        self.age = 19;
        self.name = @"DAXIGUA";
    }
    return self;
}

+ (void)classPrint {
    NSLog(@"this is a class method");
}

- (void)instancePrint {
    NSLog(@"this is a instance method");
}


//@dynamic indentifyNumber;

//+ (BOOL)resolveClassMethod:(SEL)sel {
//    //class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
//}

@end
