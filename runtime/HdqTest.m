
//
//  HdqTest.m
//  runtime
//
//  Created by Jie on 16/4/25.
//  Copyright © 2016年 com.fazhiwang. All rights reserved.
//

#import "HdqTest.h"
#import <objc/runtime.h>
#import "HdqTest+extision.h"
#import <objc/message.h>

@interface HdqTest ()<PersonDelegate,NSCoding>{
//    NSString *tips;
}
//@property (nonatomic, copy) NSString *tips;
@end

@implementation HdqTest
- (void)eat {
//    NSLog(@"tips-->%@ dataArray-->%@",tips,dataArray);
}
- (void)sleep {
    
}
- (void)work {
    
}
- (void)personDelegateToWork {
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([HdqTest class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        //因为某些类型无法使用kvc 所以以下方法暂停使用
//        NSString *propertyValue = [self valueForKey:propertyName];
//        [aCoder encodeObject:propertyValue forKey:propertyName];
        //以下方法仅对应于属性包含setter/getter方法的属性 但是并不包括成员变量
        //所以 如果想归档，要将归档的数据写成属性
        //tips:通过runtime添加的"属性"因为拥有setter/getter方法 所以也可以归档解档
        propertyName = [propertyName substringFromIndex:1];
        //获取getter方法
        SEL getter = NSSelectorFromString(propertyName);
        if([self respondsToSelector:getter]) {
            const void *typeEncoding = ivar_getTypeEncoding(ivar);
            NSString *type = [NSString stringWithUTF8String:typeEncoding];
            //const void *
            if([type isEqualToString:@"r^v"]) {
                const char *value = ((const void *(*)(id,SEL))(void*)objc_msgSend)((id)self,getter);
                NSString *utf8Value = [NSString stringWithUTF8String:value];
                [aCoder encodeObject:utf8Value forKey:propertyName];
                continue;
            } else if ([type isEqualToString:@"i"]) {
                int value = ((int (*)(id,SEL))(void *)objc_msgSend)((id)self,getter);
                [aCoder encodeObject:@(value) forKey:propertyName];
                continue;
            } else if ([type isEqualToString:@"f"]) {
                float value = ((float (*)(id,SEL))(void *)objc_msgSend)((id)self,getter);
                [aCoder encodeObject:@(value) forKey:propertyName];
                continue;
            }
            id value = ((id (*)(id,SEL))objc_msgSend)((id)self,getter);
            if (value != nil && [value respondsToSelector:@selector(encodeWithCoder:)]) {
                [aCoder encodeObject:value forKey:propertyName];
            }
        }
    }
    free(ivars);
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([HdqTest class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:name];
//        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
//        [self setValue:propertyValue forKey:propertyName];
        propertyName = [propertyName substringFromIndex:1];
        NSString *setterName = propertyName;
        if (![setterName hasPrefix:@"_"]) {
            NSString *firstLetter = [NSString stringWithFormat:@"%c",[setterName characterAtIndex:0]];
            setterName = [setterName substringFromIndex:1];
            setterName = [NSString stringWithFormat:@"%@%@",firstLetter.uppercaseString,setterName];
        }
        setterName = [NSString stringWithFormat:@"set%@:",setterName];
        SEL setter = NSSelectorFromString(setterName);
        if([self respondsToSelector:setter]) {
            const void *typeEncoding = ivar_getTypeEncoding(ivar);
            NSString *type = [NSString stringWithUTF8String:typeEncoding];
            //const char
            if ([type isEqualToString:@"r^v"]) {
                NSString *value = [aDecoder decodeObjectForKey:propertyName];
                if(value){
                    ((void (*)(id,SEL,const void *))objc_msgSend)(self,setter,value.UTF8String);
                }
                continue;
                //int
            } else if ([type isEqualToString:@"i"]) {
                NSNumber *value = [aDecoder decodeObjectForKey:propertyName];
                if (value != nil) {
                    ((void (*)(id,SEL,int))objc_msgSend)(self,setter,[value intValue]);
                }
                continue;
                //float
            } else if ([type isEqualToString:@"f"]) {
                NSNumber *value = [aDecoder decodeObjectForKey:propertyName];
                if (value != nil) {
                    ((void (*)(id,SEL,float))objc_msgSend)(self,setter,[value floatValue]);
                }
                continue;
            }
            //objct
            id value = [aDecoder decodeObjectForKey:propertyName];
            if (value != nil) {
                ((void (*)(id,SEL,id))objc_msgSend)(self,setter,value);
            }
        }
    }
    free(ivars);
    return self;
}
//增加方法
void love(id self,SEL sel) {
    NSLog(@"add Success --> %@  %@",self,NSStringFromSelector(sel));
}
void light(id self,SEL sel,NSString *name,NSString *position) {
    NSLog(@"%@ light %@",name,position);
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == @selector(love)) {
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->sel
        class_addMethod(self, @selector(love), love, "v%@");
    }
    if (sel == @selector(light)) {
        class_addMethod(self, sel, light, "v#:@@");
    }
    return [super resolveInstanceMethod:sel];
}

- (instancetype)init {
    self = [super init];
    SEL selector = NSSelectorFromString(@"setDataArray:");
    [self performSelector:selector withObject:@[@2L]];
    return self;
}

#pragma mark - set/get方法
static const void *s_Tips = "s_TipsKey";
- (void)setTips:(NSString *)string {
    objc_setAssociatedObject(self,s_Tips,string,OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)tips {
    return objc_getAssociatedObject(self, s_Tips);
}
@end
