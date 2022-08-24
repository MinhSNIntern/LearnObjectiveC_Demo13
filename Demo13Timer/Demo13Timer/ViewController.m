//
//  ViewController.m
//  Demo13Timer
//
//  Created by vfa on 8/24/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIButton *stopBtn;
@property (nonatomic,strong) UIButton *resetBtn;
@end

@implementation ViewController
int timerTick = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.text = @"0";
    [self.secondLabel setFont:[UIFont systemFontOfSize:200]];
    [self.secondLabel sizeToFit];
    
    self.secondLabel.center = CGPointMake(self.view.frame.size.width/2, 200);
    
    self.startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startBtn setTitle:@"Start Timer" forState:UIControlStateNormal];
    [self.startBtn sizeToFit];
    
    self.startBtn.center = CGPointMake(self.view.frame.size.width/2, 400);
    self.stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.stopBtn setTitle:@"Stop Timer" forState:UIControlStateNormal];
    [self.stopBtn sizeToFit];
    
    self.stopBtn.center = CGPointMake(self.view.frame.size.width/2, 500);
    
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.resetBtn setTitle:@"Reset Timer" forState:UIControlStateNormal];
    [self.resetBtn sizeToFit];
    
    self.resetBtn.center = CGPointMake(self.view.frame.size.width/2, 600);
    [self.view addSubview:self.secondLabel];
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.stopBtn];
    [self.view addSubview:self.resetBtn];
    
    [self.startBtn addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.stopBtn addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.resetBtn addTarget:self action:@selector(resetTimer) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void) startTimer{
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ticking) userInfo:nil repeats:YES];
    NSLog(@"%@",self.timer);
}
-(void) ticking{
    timerTick++;
    self.secondLabel.text = [NSString stringWithFormat:@"%d",timerTick];
    [self.secondLabel sizeToFit];
    self.secondLabel.center = CGPointMake(self.view.frame.size.width/2, 200);

}
-(void) stopTimer{
    
    if(self.timer !=nil){
        [self.timer invalidate];
    }
}
-(void) resetTimer{
    
    [self stopTimer];
    timerTick=0;
    self.secondLabel.text = @"0";
}
@end
