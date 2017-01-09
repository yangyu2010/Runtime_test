//
//  NSObject+Runtime.h
//  Runtime_test
//
//  Created by Young on 2017/1/8.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

/**
 动态给模型设置属性

 @param dict 字典
 @return 返回对象
 */
+ (instancetype)objcetWithDict:(NSDictionary *)dict;

/**
 动态获取一个类的所有属性

 @return 所有属性的数组
 */
+ (NSArray *)getAllProperties;


@end
