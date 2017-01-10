Runtime 的初体验 

一. 动态获取类的属性列表,给属性赋值

		1. 动态获取类的属性列表
		objc_property_t *proList = class_copyPropertyList([self class], &count);
		
		2.从属性列表中取出属性
		const char *cAttributes = property_getAttributes(pty);
		
		3. 运行时关联对象提高效率
		/// 动态添加属性
		objc_setAssociatedObject(self, kPropertyListKey, nameArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		/// 取出属性列表,第一次没有值,要手动取出属性列表,然后设置属性列表
		NSArray *list = objc_getAssociatedObject(self, kPropertyListKey);
		
		
二. 交叉方法
	
1.交叉方法在AFN中的使用
	
	//AFURLSessionManager.h
	static inline void af_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    	   Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
   		   Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    	   method_exchangeImplementations(originalMethod, swizzledMethod);
	}


2.调用

    + (void)swizzleResumeAndSuspendMethodForClass:(Class)theClass {
    
   			Method afResumeMethod = class_getInstanceMethod(self, @selector(af_resume));
    		Method afSuspendMethod = class_getInstanceMethod(self, @selector(af_suspend));

   		   if (af_addMethod(theClass, @selector(af_resume), afResumeMethod)) {
        		af_swizzleSelector(theClass, @selector(resume), @selector(af_resume));
   	 		}

   		   if (af_addMethod(theClass, @selector(af_suspend), afSuspendMethod)) {
     		   af_swizzleSelector(theClass, @selector(suspend), @selector(af_suspend));
	       }
	}
	
	//交叉了下面两个方法
	/// NSURLSession.h
	- (void)suspend;		//暂停任务
	- (void)resume;		//启动任务




我重写了UIImageView的setImage方法

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
    
方法实现
	
	- (void)yy_setImage:(UIImage *)image {
    	 NSLog(@"111%@",image);
   		 [self yy_setImage:newImg];
	}
    
    