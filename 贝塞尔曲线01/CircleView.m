//
//  CycleView.m
//  贝塞尔曲线01
//
//  Created by James on 16/4/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CircleView.h"
#import "CircleLayer.h"

@implementation CircleView

//告知UIView使用CircLayer类
+ (Class)layerClass {
    return [CircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.circleLayer = [CircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        // contentsScale属性定义了寄宿图的像素尺寸和视图大小的比例，默认情况下它是一个值为1.0的浮点数。
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
