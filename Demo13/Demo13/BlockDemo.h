//
//  BlockDemo.h
//  Demo13
//
//  Created by vfa on 8/22/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockDemo : NSObject
@property (nonatomic,copy) void(^block)(id,NSInteger,BOOL*);
-(void) runBlocks;
@end

NS_ASSUME_NONNULL_END
