//
//  NKViewController.m
//  RecordScreen-iOS9-
//
//  Created by KyleWong on 03/23/2016.
//  Copyright (c) 2016 KyleWong. All rights reserved.
//

#import "NKViewController.h"

@interface NKViewController ()
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isCounting;
@property (nonatomic,assign) BOOL isRecoding;
@property (nonatomic,strong) NSNumber *num;
@end

@implementation NKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUIComponents];
    [self updateUIComponents];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_timer invalidate];
}

#pragma mark - Action
- (IBAction)onCountBtnPressed:(id)sender {
    [self setIsCounting:!self.isCounting];
    if(self.isCounting){
        [self startTimer];
    }
    else{
        [self stopTimer];
        [self setNum:nil];
    }
    [self updateUIComponents];
}

#pragma mark - Timer
- (void)startTimer{
    if(self.timer){
        [self.timer invalidate];
    }
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimerExpired:) userInfo:nil repeats:YES]];
}

- (void)stopTimer{
    [self.timer invalidate];
    [self setTimer:nil];
}

- (void)onTimerExpired:(NSTimer *)aTimer{
    [self setNum:@(self.num.longLongValue+1)];
    [self updateUIComponents];
}

#pragma mark - Others
- (void)initUIComponents{
    [self.infoLabel.layer setBorderWidth:1.f];
    [self.infoLabel.layer setBorderColor:[UIColor blackColor].CGColor];
}

- (void)updateUIComponents{
    NSString *title = self.isCounting?@"结束计数":@"开始计数";
    [self.countBtn setTitle:title forState:UIControlStateNormal];
    NSString *info = nil;
    if(self.num){
        long long number = self.num.longLongValue;
        info = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",number/3600,number/60%60,number%60];
    }
    [self.infoLabel setText:info];
}
@end
