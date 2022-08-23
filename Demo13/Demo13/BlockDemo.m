//
//  BlockDemo.m
//  Demo13
//
//  Created by vfa on 8/22/22.
//

#import "BlockDemo.h"

@implementation BlockDemo
-(void) runBlocks{
    //Create and calling block
    void (^MyBlock)(id ,NSInteger,BOOL*) = ^(id obj,NSInteger idx, BOOL *stop ){
        NSLog(@"Video game : %@", (NSString *)obj);
    };

    BOOL stop;
    
    //Invoking block
    MyBlock(@"God Of War",0,&stop);
    
    //Passing block to method
    NSArray *games =@[@"Fallout 2",@"Call of duty",@"CSGO"];
    
    [games enumerateObjectsUsingBlock:(void (^ _Nonnull)(id  _Nonnull __strong, NSUInteger, BOOL * _Nonnull))MyBlock];
    
    //Inline block and accessing variable in block
    NSString *favoriteGame = @"CSGO";
    __block NSInteger countOfGame = 0;
    [games enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * game = (NSString *)obj;
        if([game isEqualToString:favoriteGame]){
            NSLog(@"%@ is my favorite game",favoriteGame);
        }else{
        NSLog(@"Video game : %@", (NSString *)obj);
        }
        countOfGame++;
    }];
    
    NSLog(@"%ld", (long)countOfGame);
    
    //Calling method with block as a parameter
    [self doSomething:MyBlock];
    
    
}

-(void) doSomething: (void(^)(id,NSInteger,BOOL*))block{
    self.block = block;
    [self performSelector:@selector(afterOneSecond) withObject:nil afterDelay:1.0f];
}

-(void) afterOneSecond{
    BOOL stop;
    self.block(@"LOL",0,&stop);
}
@end
