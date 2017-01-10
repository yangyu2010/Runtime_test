//
//  ViewController.m
//  Runtime_test
//
//  Created by Young on 2017/1/8.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self setProperty];
    
    [self setImage];
    
    //[self testExchangeMethod];
}


- (void)setProperty {
    
    //1.
    NSArray *arr = [Person getAllProperties];
    NSLog(@"viewDidLoad == %@",arr);
    

    //2.
    Person *p = [Person objcetWithDict:@{
                                        @"name" : @"zhangsan",
                                        @"age" : @18,
                                        @"height" : @1.99,
                                        @"daxigua" : @"xxx"
                                        }];
    
    NSLog(@"%@",p);
    
}

- (void)setImage {

    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    img.center = self.view.center;
    
    [self.view addSubview:img];
    
    img.image = [UIImage imageNamed:@"test222.jpg"];
    //相当于调用img的 setImage方法
    //[img setImage:[UIImage imageNamed:@"test222.jpg"]];
}

- (void)testExchangeMethod {
    
    Person *p = [[Person alloc] init];

    Method m1 = class_getClassMethod([Person class], @selector(classPrint));
    Method m2 = class_getInstanceMethod([p class], @selector(instancePrint));
    
    NSLog(@"测试前");
    [p instancePrint];
    [Person classPrint];
    
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"测试后");
    [p instancePrint];
    [Person classPrint];
    
}


@end
