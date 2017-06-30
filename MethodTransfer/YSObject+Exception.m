//
//  YSObject+Exception.m
//  MethodTransfer
//
//  Created by chenfenglong on 2017/6/30.
//  Copyright © 2017年 chenfenglong. All rights reserved.
//

#import "YSObject+Exception.h"
#import "YSException.h"

/*
 1、消息转发的三个步骤
 2、resolveInstanceMethod，runtime看调用者能不能动态的把方法添加进来。
 3、forwardingTargetForSelector，把消息转发给其他对象的同名方法。
 4、forwardInvocation，把消息转发给其他对象的同名方法或者转发给其他方法。
 */

@implementation YSObject (Exception)

////看调用者，自己能不能动态的通过运行时的方法把方法添加进来
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    //    NSString *selString = NSStringFromSelector(sel);
//    //    if ([selString isEqualToString:@"run"]) {
//    //        class_addMethod(self, sel, class_getMethodImplementation(self, @selector(replaceRun)), NULL);
//    //    }
//    NSLog(@"%@",NSStringFromSelector(sel));
//    return NO;
//}
//
////看其他对象能否处理同sel的能力
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    return [super forwardingTargetForSelector:aSelector];
//    //    Student *student = [Student new];
//    //    return student;
//}

/*
 1、methodSignatureForSelector是返回需要转发对象的“方法签名”
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    YSException *exceptionDef = [YSException new];
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        SEL newSelector = NSSelectorFromString(@"handException");
        signature = [exceptionDef methodSignatureForSelector:newSelector];
    }
    return signature;
}

/*
 1、如果想让runtime调用forwardInvocation方法，必须要重写methodSignatureForSelector方法，要不然forwardInvocation不会调用
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSMethodSignature *methodSignature = [YSException instanceMethodSignatureForSelector:NSSelectorFromString(@"handException")];
    NSInvocation *newInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [newInvocation setSelector:NSSelectorFromString(@"handException")];
    
    YSException *exceptionDef = [YSException new];
    if ([exceptionDef respondsToSelector:[newInvocation selector]]) {
        [newInvocation invokeWithTarget:exceptionDef];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

@end
