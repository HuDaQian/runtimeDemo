//
//  NSMutableArray+Extension.m
//  runtime
//
//  Created by Jie on 16/4/26.
//  Copyright © 2016年 com.fazhiwang. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)
+ (void)load {
    Method orginalMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method newMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(gp_addObject:));
    method_exchangeImplementations(orginalMethod, newMethod);
}
- (void)gp_addObject:(id)object {
    
    if (object != nil) {
        [self gp_addObject:object];
    }
}
@end
