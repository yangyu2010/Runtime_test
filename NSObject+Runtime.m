//
//  NSObject+Runtime.m
//  Runtime_test
//
//  Created by Young on 2017/1/8.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

const void *kPropertyListKey = "kPropertyListKey";


+ (instancetype)objcetWithDict:(NSDictionary *)dict {

    id objcet = [[self alloc] init];
    
    /// 获取属性
    NSArray *proList = [self getAllProperties];
    
    /// 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        /// 属性里如果有这个值,就赋值
        if ([proList containsObject:key]) {
            [objcet setValue:obj forKey:key];
        }
        
    }];
    
    return objcet;
}

+ (NSArray *)getAllProperties {

    /// 获取关联对象,取出pro数组,第一次没有值,要走下面的方法手动设置objc_setAssociatedObject
    NSArray *list = objc_getAssociatedObject(self, kPropertyListKey);
    if (list.count > 0) {
        return list;
    }
    
    unsigned int count = 0;
    /// 获取属性列表
    objc_property_t *proList = class_copyPropertyList([self class], &count);
    /// 获取成员变量列表
    //class_copyIvarList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    /// 方法列表
    //class_copyMethodList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    /// 协议
    //class_copyProtocolList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    
    NSMutableArray *nameArray = [NSMutableArray array];
    
    /// 遍历属性列表,取出属性值
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t pty = proList[i];
        const char *cName =  property_getName(pty);
        const char *cAttributes = property_getAttributes(pty);
        
        NSLog(@"%s === %s",cName,cAttributes);
        
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [nameArray addObject:name];
    }
    /// C 语言的 copy要释放
    free(proList);
    
    /// 利用关联对象,动态添加属性
    //objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    /**
     1. id object           对象 self
     2. const void *key     动态添加属性的 key 获取的时候要使用
     3. id value            动态设置的属性值
     4. objc_AssociationPolicy    枚举值
     */
    objc_setAssociatedObject(self, kPropertyListKey, nameArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return nameArray.copy;
}



// Class 其实是指向 objc_class 结构体的指针。objc_class 的数据结构如下：
/*
struct objc_class {
    Class isa  OBJC_ISA_AVAILABILITY;
    
#if !__OBJC2__
    Class super_class                            父类指针     OBJC2_UNAVAILABLE;
    const char *name                              类名       OBJC2_UNAVAILABLE;
    long version                                             OBJC2_UNAVAILABLE;
    long info                                                OBJC2_UNAVAILABLE;
    long instance_size                                       OBJC2_UNAVAILABLE;
    struct objc_ivar_list *ivars               成员变量列表    OBJC2_UNAVAILABLE;
    struct objc_method_list **methodLists       方法列表      OBJC2_UNAVAILABLE;
    struct objc_cache *cache                    缓存         OBJC2_UNAVAILABLE;
    struct objc_protocol_list *protocols        协议         OBJC2_UNAVAILABLE;
#endif
    
} OBJC2_UNAVAILABLE;
 
 */


@end
