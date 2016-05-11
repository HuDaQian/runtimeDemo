//
//  main.m
//  runtime
//
//  Created by Jie on 16/4/25.
//  Copyright © 2016年 com.fazhiwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HdqTest.h"
#import <objc/runtime.h>
#import "HdqTest+extision.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //1.获取全部成员变量名
//        unsigned int count;
//        Ivar *ivars = class_copyIvarList([HdqTest class], &count);
//        for (int i=0; i<count; i++) {
//            Ivar ivar = ivars[i];
//            const char *name = ivar_getName(ivar);
//            NSString *key = [NSString stringWithUTF8String:name];
//            NSLog(@"%d==%@",i,key);
//        }
//        free(ivars);
        //2.获取全部属性名
//        unsigned int count;
//        objc_property_t *properties = class_copyPropertyList([HdqTest class], &count);
//        for (int i=0; i<count; i++) {
//            objc_property_t property = properties[i];
//            const char *propertyName = property_getName(property);
//            const char *propertyAttributes = property_getAttributes(property);
//            NSLog(@"propertyName-->%s propertyAttributes-->%s",propertyName,propertyAttributes);
//            //获取到针对某个属性的描述
//            unsigned int inCount;
//            objc_property_attribute_t *attributes = property_copyAttributeList(property, &inCount);
//            for (int j=0; j<inCount; j++) {
//                objc_property_attribute_t attribute = attributes[j];
//                const char *attributeName = attribute.name;
//                const char *attributeValue = attribute.value;
//                NSLog(@"name-->%s,value-->%s",attributeName,attributeValue);
//            }
//            free(attributes);
//        }
//        free(properties);
        //3.获取一个类的所有方法(只有对象方法没有类方法)
//        unsigned int count;
////        获取所有指向该类方法的指针
//        Method *methods = class_copyMethodList([HdqTest class], &count);
//        for (int i=0; i<count; i++) {
//            Method method = methods[i];
//            SEL methodSEL = method_getName(method);
//            const char *name = sel_getName(methodSEL);
//            NSString *methodName = [NSString stringWithUTF8String:name];
//            int arguments = method_getNumberOfArguments(method);
//            NSLog(@"%d == %@ %d",i,methodName,arguments);
//        }
//        free(methods);
        //4.获取一个类的所有协议
//        unsigned int count;
//        __unsafe_unretained Protocol **protocols = class_copyProtocolList([HdqTest class], &count);
//        for (int i=0; i<count; i++) {
//            Protocol *protocol = protocols[i];
//            const char *name = protocol_getName(protocol);
//            NSString *protocolName = [NSString stringWithUTF8String:name];
//            NSLog(@"%d == %@",i,protocolName);
//        }
//        free(protocols);
        //5.归档解档
//        HdqTest *hdqtest = [[HdqTest alloc] init];
//        hdqtest.name = @"胡大千";
//        hdqtest.sex = @"男";
//        hdqtest.age = 23;
//        hdqtest.height = 170.0;
//        hdqtest._floatValue = 3.141592657;
//        //两种方法所达到的效果是一样的都是通过setTips方法向runtime增加的“属性”tips赋值
//        [hdqtest setValue:@"提示" forKey:@"tips"];
////        SEL selector = NSSelectorFromString(@"setTips:");
////        [hdqtest performSelector:selector withObject:@"提示"];
//        SEL setData = NSSelectorFromString(@"setDataArray:");
//        [hdqtest performSelector:setData withObject:@[@2L]];
//        
//        [hdqtest eat];
//
//        NSString *path = [NSString stringWithFormat:@"%@/archive",NSHomeDirectory()];
//        [NSKeyedArchiver archiveRootObject:hdqtest toFile:path];
//        HdqTest *unarchiverHdqtest = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        NSLog(@"unarchiverHdqtest == %@ %@",path,unarchiverHdqtest);
//        NSLog(@"_floatValue --> %f",unarchiverHdqtest._floatValue);
//        
//        //关于三个输出 为什么前两个能输出出来 而第三个无法输出的原因
//        //关于kvc kvc实际上是走的类中的set/get方法，无论有没有声明（侧面证实oc中没有完全的私有方法以及私有属性）
//        //runtime添加的“属性”实际上是通过一个全局参量key来指向相应内存，而和类中的成员变量或者属性没有关系 这也就是为什么前面调用eat方法无法获取到数据的原因
//        //归档的时候 成员变量tips和dataArray的指针指向空值，所以没有数据 解档的时候，也就没有数据了
//        SEL getData = NSSelectorFromString(@"dataArray");
//        NSLog(@"%@",[hdqtest performSelector:getData]);
//        NSLog(@"%@",[hdqtest valueForKey:@"dataArray"]);
//        NSLog(@"dataArray --> %@",[unarchiverHdqtest valueForKey:@"dataArray"]);
//
//        SEL getTips = NSSelectorFromString(@"tips");
//        NSLog(@"%@",[hdqtest performSelector:getTips]);
//        NSLog(@"%@",[hdqtest valueForKey:@"tips"]);
//        NSLog(@"tips --> %@",[unarchiverHdqtest valueForKey:@"tips"]);
        //6.方法交换
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        [array addObject:@"get"];
//        [array addObject:@"set"];
//        //这里 不报错误的原因 已经通过category更改了addObject方法
//        [array addObject:nil];
//        NSLog(@"array --> %@",array);
        //7.增加方法／增加属性（具体实现在category里面）
//        HdqTest *hdqtest = [[HdqTest alloc] init];
//        //两种方法所达到的效果是一样的都是通过setTips方法向runtime增加的“属性”tips赋值
////        SEL setData = NSSelectorFromString(@"setTips:");
////        [hdqtest performSelector:setData withObject:@"提示"];
//        [hdqtest setValue:@"提示" forKey:@"tips"];
//        NSLog(@"-->%@",[hdqtest valueForKey:@"tips"]);
//        SEL selector = NSSelectorFromString(@"tips");
//        NSLog(@"-->%@",[hdqtest performSelector:selector]);
//        [hdqtest performSelector:@selector(love)];
//        [hdqtest performSelector:@selector(light) withObject:@"light" withObject:@"light"];
    }
    return 0;
}