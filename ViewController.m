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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    
    img.center = self.view.center;
    
    [self.view addSubview:img];
    
    img.image = [UIImage imageNamed:@"test222.jpg"];
}


- (void)setProperty {
    //
    //NSLog(@"viewDidLoad == %@",arr);
    
    
    
    //NSArray *arr = [Person getAllProperties];

    //    Person *p = [Person objcetWithDict:@{
    //                                         @"name" : @"zhangsan",
    //                                         @"age" : @18,
    //                                         @"height" : @1.99,
    //                                         @"daxigua" : @"xxx"
    //                                         }];
    //
    //    NSLog(@"%@",p);
    
    
}


@end
