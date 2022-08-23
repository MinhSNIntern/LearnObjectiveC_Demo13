//
//  ViewController.m
//  Demo13MyOwnDispatchQueues
//
//  Created by vfa on 8/23/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
void FirstInteraction (void * context){
    for(int i =0 ;i<5;i++){
        NSLog(@"First interaction, counter = %d",i);
    }
}
void SecondInteraction (void * context){
    for(int i =0 ;i<5;i++){
        NSLog(@"Second interaction, counter = %d",i);
    }
}
void ThirdInteraction (void * context){
    for(int i =0 ;i<5;i++){
        NSLog(@"Third interaction, counter = %d",i);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_queue_t firstSerialQueue = dispatch_queue_create("com.demo.Demo13MyOwnDispatchQueues.serialQueue1", 0);
    
    dispatch_async_f(firstSerialQueue, NULL, FirstInteraction);
    dispatch_async_f(firstSerialQueue, NULL, SecondInteraction);
    dispatch_async_f(firstSerialQueue, NULL, ThirdInteraction);
    // Do any additional setup after loading the view.
}


@end
