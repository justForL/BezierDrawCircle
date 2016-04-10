//
//  ViewController.m
//  贝塞尔曲线01
//
//  Created by James on 16/4/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"


#define kScreenSize self.view.frame.size

@interface ViewController ()
@property (nonatomic, strong) CircleView *myCycle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myCycle = [[CircleView alloc]initWithFrame:CGRectMake(kScreenSize.width/2 - 320/2, kScreenSize.height/2 - 320/2, 320, 320)];
    self.myCycle.circleLayer.progress = 0.5;
    [self.view addSubview:self.myCycle];
    
}


//slider值发生改变的时候调用这个方法
- (IBAction)slider:(UISlider *)sender {
    NSLog(@"%f",sender.value);
    
    self.myCycle.circleLayer.progress = sender.value;
}

@end
