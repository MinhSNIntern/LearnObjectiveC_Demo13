//
//  ViewController.m
//  Demo13ExitThreadAndTimer
//
//  Created by vfa on 8/24/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSThread *myThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntryPoint) object:nil];
    
    [self performSelector:@selector(stopThread) withObject:nil afterDelay:3.0];
    
    [self.myThread start];
    // Do any additional setup after loading the view.
}

-(void) threadEntryPoint{
    @autoreleasepool {
        NSLog(@"thread entry point");
        while ([[NSThread currentThread] isCancelled] == NO) {
            [NSThread sleepForTimeInterval:4.0];
            
            if([[NSThread currentThread] isCancelled]== NO){
                NSLog(@"Thread loop");
            }
            
            NSLog(@"Thread finished");
        }
    }
}
-(void) stopThread{
    
    NSLog(@"Cancelling the thread");
    [self.myThread cancel];
    NSLog(@"Release the thread");
    self.myThread = nil;
}

@end
