//
//  ViewController.m
//  Demo13
//
//  Created by vfa on 8/22/22.
//

#import "ViewController.h"
#import "BlockDemo.h"
@interface ViewController ()

@end

@implementation ViewController
typedef struct{
    char *title;
    char *message;
    char *cancelButtonTitle;
    
} AlertData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    BlockDemo *block = [[BlockDemo alloc] init];
    [block runBlocks];
    
    
// if calling 2 alert methods at the same time ui doesn't show any alert however if put 1 alert in async GCD calls, ui will show that alert
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GCD" message:@"GCD is not amazing" preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//
//    [alert addAction:actionOK];
//    [self presentViewController:alert animated:YES completion:nil];
//
//    [self alert];
//
   // alert with async GCD call
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//
//    dispatch_async(mainQueue, ^{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GCD" message:@"GCD is amazing" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//
//        [alert addAction:actionOK];
//        [self presentViewController:alert animated:YES completion:nil];
//
//    });
//
    //Non-UI Related Task synchronously
//    void (^printFrom1To1000)(void) = ^{
//        for(int i=0;i<=1000;i++){
//            NSLog(@"Counter = %d, Thead = %@",i,[NSThread currentThread]);
//        }
//    };
//    dispatch_queue_t concurentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//
//    dispatch_sync(concurentQueue,printFrom1To1000);
//    dispatch_sync(concurentQueue,printFrom1To1000);
//
//    dispatch_sync_f(concurentQueue,NULL, printFrom1To10002);
//    dispatch_sync_f(concurentQueue,NULL, printFrom1To10002);
   //Dispatch only once per task
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //call 2 times of executeOnlyOnce block but that block only execute once
    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue, executeOnlyOnce);
    });
    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue, executeOnlyOnce);
    });
    
    // Do any additional setup after loading the view.
}

static dispatch_once_t onceToken;

void (^executeOnlyOnce)(void) = ^{
    static NSUInteger numberOfEntries = 0;
    numberOfEntries++;
    NSLog(@"Executed %lu time(s)",numberOfEntries);
};
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //Non-UI related task asynchronously

    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(concurrentQueue, ^{
        __block UIImage *image = [[UIImage alloc] init];

        dispatch_sync(concurrentQueue, ^{
            NSString *urlString = @"https://cdn.pixabay.com/photo/2020/05/25/17/21/link-5219567_960_720.jpg";
            NSURL *url = [NSURL URLWithString:urlString];

            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];

            if(imageData!=nil){
                image = [UIImage imageWithData:imageData];
                NSLog(@"Done%@",image);

            }else{
                NSLog(@"No data available");

            }

        });

        dispatch_sync(dispatch_get_main_queue(), ^{
            if(image !=nil){
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
                [imageView setImage:image];
                [imageView setContentMode:UIViewContentModeScaleAspectFit];


                [self.view addSubview:imageView];
            }else{

                self.view.backgroundColor = UIColor.greenColor;
            }
        });
    });
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 10.0*NSEC_PER_SEC);
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor orangeColor];
    });
}
void printFrom1To10002(void* context){
    for(int i=0;i<=1000;i++){
        NSLog(@"Counter = %d, Thead = %@",i,[NSThread currentThread]);
    }
}

@end
