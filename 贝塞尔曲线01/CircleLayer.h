//
//  CycleLayer.h
//  贝塞尔曲线01
//
//  Created by James on 16/4/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CircleLayer : CALayer
//进度 用于每次值变化 调用重绘方法
@property (nonatomic, assign) CGFloat progress;
@end
