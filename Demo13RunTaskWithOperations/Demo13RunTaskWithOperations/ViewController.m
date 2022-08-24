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
@property (nonatomic,strong) UIButton *dependencyBtn;
@property (nonatomic,strong) CountingOperation *counterOperation;
@property (nonatomic,strong) SimpleOperation *firstSimpleOperation;
@property (nonatomic,strong) SimpleOperation *secondSimpleOperation;
@property (nonatomic,strong) NSOperationQueue *operationQueue;
@property (nonatomic,strong) NSInvocationOperation *firstOperation;
@property (nonatomic,strong) NSInvocationOperation *secondOperation;
@property (nonatomic,strong) NSOperationQueue *operationQueue1;
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
    
    self.dependencyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.dependencyBtn setTitle:@"Creating dependency between operation" forState:UIControlStateNormal];
    [self.dependencyBtn sizeToFit];
    self.dependencyBtn.center = CGPointMake(self.view.frame.size.width/2, 400);
    
    
    [self.view addSubview:self.syncBtn];
    [self.view addSubview:self.asyncBtn];
    [self.view addSubview:self.dependencyBtn];
    
    [self.syncBtn addTarget:self action:@selector(runSyncTask) forControlEvents:UIControlEventTouchUpInside];
    
    [self.asyncBtn addTarget:self action:@selector(runAsyncTask) forControlEvents:UIControlEventTouchUpInside];
    
    [self.dependencyBtn addTarget:self action:@selector(dependencyBetweenOperation) forControlEvents:UIControlEventTouchUpInside];
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

-(void) dependencyBetweenOperation{
    NSNumber *first = @111;
    NSNumber *second =@222;
    self.firstOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(firstOperationEntry:) object:first];
    
    self.secondOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(secondOperationEntry:) object:second];
    [self.secondOperation addDependency:self.firstOperation];
    
    self.operationQueue1 = [[NSOperationQueue alloc] init];
    
    [self.operationQueue1 addOperation:self.firstOperation];
    [self.operationQueue1 addOperation:self.secondOperation];
    
    NSLog(@"Main thread is here");
}

-(void) firstOperationEntry:(id) obj{
    
    NSLog(@"First operation - Parameter Object = %@", obj);
    
    NSLog(@"First operation - Main thread = %@",[NSThread mainThread]);
    
    NSLog(@"First operation -  Currnent thread = %@",[NSThread currentThread]);
}
-(void) secondOperationEntry:(id) obj{
    
    NSLog(@"Second operation - Parameter Object = %@", obj);
    
    NSLog(@"Second operation - Main thread = %@",[NSThread mainThread]);
    
    NSLog(@"Second operation -  Currnent thread = %@",[NSThread currentThread]);
}

@end
