//
//  HdqTest+extision.m
//  runtime
//
//  Created by Jie on 16/4/27.
//  Copyright © 2016年 com.fazhiwang. All rights reserved.
//

#import "HdqTest+extision.h"
#import <objc/runtime.h>

@implementation HdqTest (extision)
//扩展属性
static const void *s_dataArrayKey = "s_dataArrayKey";
- (void)setDataArray:(NSArray *)array {
    objc_setAssociatedObject(self,s_dataArrayKey,array,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)dataArray {
    return objc_getAssociatedObject(self, s_dataArrayKey);
}
@end
