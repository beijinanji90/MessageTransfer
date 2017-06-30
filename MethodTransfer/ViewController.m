//
//  ViewController.m
//  MethodTransfer
//
//  Created by chenfenglong on 2017/6/30.
//  Copyright © 2017年 chenfenglong. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    /*
     1、Person对象调用run方法，虽然Person.h有run方法的申明，但是.m文件中没有run方法的实现
     2、Person类继承与YSObject
     3、YSObject里重写了forwardInvocation方法，然后在forwardInvocation将run方法的消息转发到YSException的handException方法
     */
    Person *person = [Person new];
    [person run];
}


@end
