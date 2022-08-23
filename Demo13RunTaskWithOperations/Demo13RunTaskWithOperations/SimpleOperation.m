//
//  SimpleOperation.m
//  Demo13RunTaskWithOperations
//
//  Created by vfa on 8/23/22.
//

#import "SimpleOperation.h"
@interface SimpleOperation()
@property (nonatomic,unsafe_unretained) NSObject *obj;
@property (nonatomic,unsafe_unretained,getter=isFinished) BOOL finished;
@property (nonatomic,unsafe_unretained,getter=isExecuting) BOOL executing;
@end
@implementation SimpleOperation
@synthesize finished;
@synthesize executing;

- (instancetype)init{
    return ([self initWithObject:@123]);
}

- (instancetype)initWithObject:(NSObject *)obj{
    self = [super init];
    if(self != nil){
        _obj = obj;
    }
    return self;
}
- (void)main{
    @try {
        @autoreleasepool {
            
            BOOL taskIsFinished = NO;
            
            while (taskIsFinished == NO && [self isCancelled] == NO) {
                
                NSLog(@"%s",__FUNCTION__);
                NSLog(@"Parameter Object = %@",_obj);
                NSLog(@"Main Thread = %@", [NSThread mainThread]);
                NSLog(@"Current Thead = %@",[NSThread currentThread]);
                
                taskIsFinished = YES;
            }
            
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            finished = YES;
            executing = NO;
            
            [self didChangeValueForKey:@"isFinished"];
            [self didChangeValueForKey:@"isExecuting"];
            
            
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception %@",exception);
    }
    
}

- (BOOL)isConcurrent{
    return YES;
    
}

@end
