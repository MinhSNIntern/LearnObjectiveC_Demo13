//
//  ViewController.m
//  Demo13ConcurencrWithThread
//
//  Created by vfa on 8/24/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void) downloadNewFile:(id) obj{
    @autoreleasepool {
        NSString *fileURL = (NSString *)obj;
        NSURL *url = [NSURL URLWithString:fileURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if([data length] > 0 ){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
                imageView.contentMode = UIViewContentModeScaleToFill;
                imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
                UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
                [controller.view addSubview:imageView];
            });
        }else{
            
            //Nothing was downloaded
        }
    }
}

-(void) count1To1000{

    @autoreleasepool {
        NSUInteger counter =0;
        for(counter = 0;counter<=1000;counter++){
            NSLog(@"%lu",(unsigned long)counter);
        }
    }}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //run task in background
    [self performSelectorInBackground:@selector(count1To1000) withObject:nil];
    NSString *fileToDownload = @"https://cdn.oreillystatic.com/oreilly/images/the_cost_of_doing_nothing_screenshot.png";
    //run concurrency with thread
    [NSThread detachNewThreadSelector:@selector(downloadNewFile:) toTarget:self withObject:fileToDownload];
    // Do any additional setup after loading the view.
}


@end
