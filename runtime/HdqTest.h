//
//  HdqTest.h
//  runtime
//
//  Created by Jie on 16/4/25.
//  Copyright © 2016年 com.fazhiwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PersonDelegate <NSObject>
@required
- (void)personDelegateToWork;
@end

@interface HdqTest : NSObject{
    NSString *tips;
    NSArray *dataArray;
}
#pragma mark - property
@property (nonatomic, assign) id<PersonDelegate> delegate;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float _floatValue;

#pragma mark - method
- (void)eat;
- (void)sleep;
- (void)work;
@end
