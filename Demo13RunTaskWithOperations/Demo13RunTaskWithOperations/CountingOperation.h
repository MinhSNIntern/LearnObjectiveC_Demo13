//
//  CountingOperation.h
//  Demo13RunTaskWithOperations
//
//  Created by vfa on 8/23/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountingOperation : NSOperation
-(instancetype) initWithStartingCount:(NSInteger) startingCount endingCount: (NSInteger) endingCount;
@end

NS_ASSUME_NONNULL_END
