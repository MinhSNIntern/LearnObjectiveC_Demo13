//
//  ViewController.m
//  Demo13RunTaskWithOperations
//
//  Created by vfa on 8/23/22.
//

#import "ViewController.h"
#import "CountingOperation.h"
#import "SimpleOperation.h"
@interface ViewController ()
@property (nonatomic,strong) UIButton *syncBtn;
@property (nonatomic,strong) UIButton *asyncBtn;
@property (nonatomic,strong) CountingOperation *counterOperation;
@property (nonatomic,strong) SimpleOperation *firstSimpleOperation;
@property (nonatomic,strong) SimpleOperation *secondSimpleOperation;
@property (nonatomic,strong) NSOperationQueue *operationQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.syncBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.syncBtn setTitle:@"Running Task Synchronous" forState:UIControlStateNormal];
    [self.syncBtn sizeToFit];
    self.syncBtn.center = CGPointMake(self.view.frame.size.width/2, 200);
    
    self.asyncBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.asyncBtn setTitle:@"Running Task Asynchronous" forState:UIControlStateNormal];
    [self.asyncBtn sizeToFit];
    self.asyncBtn.center = CGPointMake(self.view.frame.size.width/2, 300);
    
    [self.view addSubview:self.syncBtn];
    [self.view addSubview:self.asyncBtn];
    
    [self.syncBtn addTarget:self action:@selector(runSyncTask) forControlEvents:UIControlEventTouchUpInside];
    
    [self.asyncBtn addTarget:self action:@selector(runAsyncTask) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void) runSyncTask{
    
    self.counterOperation = [[CountingOperation alloc] init];
    
    [self.counterOperation start];
    
    NSLog(@"Main thread is here");
}

-(void) runAsyncTask{
    NSNumber *first = @111;
    NSNumber *second =@222;
    self.firstSimpleOperation = [[SimpleOperation alloc] initWithObject:first];
    self.secondSimpleOperation = [[SimpleOperation alloc] initWithObject:second];
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    [self.operationQueue addOperation:self.firstSimpleOperation];
    [self.operationQueue addOperation:self.secondSimpleOperation];
    
    NSLog(@"Main thread is here");
}

@end
