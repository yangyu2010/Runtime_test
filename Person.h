//
//  Person.h
//  Runtime_test
//
//  Created by Young on 2017/1/8.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{

    NSString *daxigua;
}

@property (nonatomic , copy) NSString *name;

@property (nonatomic , assign) int age;

@property (nonatomic , assign) double height;

@property (nonatomic , copy) NSString *indentifyNumber;

@end
