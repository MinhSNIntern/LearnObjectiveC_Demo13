//
//  CountingOperation.m
//  Demo13RunTaskWithOperations
//
//  Created by vfa on 8/23/22.
//

#import "CountingOperation.h"
@interface CountingOperation ()
@property (nonatomic,unsafe_unretained) NSUInteger startingCount;
@property (nonatomic,unsafe_unretained) NSUInteger endingCount;
@property (nonatomic,unsafe_unretained,getter=isFinished) BOOL finished;
@property (nonatomic,unsafe_unretained,getter=isExecuting) BOOL executing;
@end
@implementation CountingOperation
@synthesize finished;
@synthesize executing;
- (instancetype)init{
    return ([self initWithStartingCount:0 endingCount:1000]);
}

- (instancetype)initWithStartingCount:(NSInteger)startingCount endingCount:(NSInteger)endingCount{
    self = [super init];
    if(self != nil){
        _startingCount = startingCount;
        _endingCount = endingCount;
    }
    return self;
}
- (void)main{
    @try {
        @autoreleasepool {
            
            BOOL taskIsFinished = NO;
            
            while (taskIsFinished == NO && [self isCancelled] == NO) {
                NSLog(@"Main Thread = %@", [NSThread mainThread]);
                NSLog(@"Current Thead = %@",[NSThread currentThread]);
                for(NSUInteger i =_startingCount;i<_endingCount;i++){
                    NSLog(@"Count = %lu",(unsigned long)i);
                }
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
@end
