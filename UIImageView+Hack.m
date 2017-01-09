//
//  UIImageView+Hack.m
//  Runtime_test
//
//  Created by Young on 2017/1/9.
//  Copyright © 2017年 YuYang. All rights reserved.
//

#import "UIImageView+Hack.h"
#import <objc/runtime.h>

@implementation UIImageView (Hack)

+ (void)load {

    /// 获取当前class的实例方法
    //class_getInstanceMethod(__unsafe_unretained Class cls, <#SEL name#>)
    /// 获取当前class的类方法
    //class_getClassMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    
    Method setImg = class_getInstanceMethod([self class], @selector(setImage:));
    Method replaceSetImg = class_getInstanceMethod([self class], @selector(yy_setImage:));
    
    /// 交换方法 setImage 和 yy_setImage 交换完成后
    /// 调用setImage 相当于 调用 yy_setImage
    /// 调用yy_setImage 相当于 调用 setImage
    method_exchangeImplementations(setImg, replaceSetImg);
    
}

- (void)yy_setImage:(UIImage *)image {

    NSLog(@"111%@",image);
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [image drawInRect:self.bounds];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSLog(@"222%@",newImg);
    
    [self yy_setImage:newImg];
}

@end
