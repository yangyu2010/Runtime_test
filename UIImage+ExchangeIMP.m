//
//  UIImage+ExchangeIMP.m
//  Runtime_test
//
//  Created by Young on 2017/1/10.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import "UIImage+ExchangeIMP.h"
#import <objc/message.h>

@implementation UIImage (ExchangeIMP)

// 这是交换UIImage的imageNamed:方法

//+ (void)load {
//
//    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
//    Method m2 = class_getClassMethod([self class], @selector(yy_setImage:));
//    
//    method_exchangeImplementations(m1, m2);
//}

+ (UIImage *)yy_setImage:(NSString *)imageName {

    UIImage *image = [UIImage yy_setImage:imageName];
    
    NSLog(@"加载image");
    
    return image;
}

@end
