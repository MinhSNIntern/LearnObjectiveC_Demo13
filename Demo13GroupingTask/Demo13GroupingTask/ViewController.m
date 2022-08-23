//
//  ViewController.m
//  Demo13GroupingTask
//
//  Created by vfa on 8/23/22.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
-(void) reloadTableView{
    
    NSLog(@"%s",__FUNCTION__);
}
-(void) reloadScrollView{
    
    NSLog(@"%s",__FUNCTION__);
}
-(void) reloadImageView{
    
    NSLog(@"%s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_group_t taskGroup = dispatch_group_create();
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    
    dispatch_group_async_f(taskGroup, mainQueue, (__bridge void *)self, reloadAllComponent);
    
    dispatch_group_notify(taskGroup, mainQueue, ^{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"All task are finished" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:actionOK];
            [self presentViewController: alert animated: YES completion:nil];
    });
    
}

void reloadAllComponent(void * context){
    //use __bridge to casting (void *) to viewcontroller
    ViewController *self = (__bridge ViewController *)context;
    if(self!=nil){
    [self reloadImageView];
    [self reloadTableView];
    [self reloadScrollView];
        
      
    }else{NSLog(@"seft null");}
    
}

@end
