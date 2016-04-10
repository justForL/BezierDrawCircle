//
//  CycleLayer.m
//  贝塞尔曲线01
//
//  Created by James on 16/4/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>
typedef enum MovingPoint{  //此处MovingPoint可省略
    POINT_D,
    POINT_B,
}MovingPoint;

#define outsideRectSize 90

@interface CircleLayer ()
/**
 *  外接矩形
 */
@property (nonatomic, assign) CGRect outsideRect;
@property (nonatomic, assign) MovingPoint movePoint;
@end

@implementation CircleLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    //A-C1 B-C2 的距离画弧线,当设置为正方形边长的1/3.6倍时,画出来的圆弧最贴近圆
    CGFloat offset = self.outsideRect.size.width / 3.6;
    
    //movedDistance为最大值：滑动到两端时,值最大 「外接矩形宽度的1/5」.
    //系数为滑块偏离中点0.5的绝对值再乘以2
    CGFloat movedDistance = (self.outsideRect.size.width / 5 ) * fabs(self.progress - 0.5) * 2;
    
    //先计算出外接矩形中心点的坐标
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width * 0.5 , self.outsideRect.origin.y + self.outsideRect.size.height * 0.5);
    
    //计算ABCD各点
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.movePoint == POINT_D ? rectCenter.x + self.outsideRect.size.width * 0.5 : rectCenter.x + self.outsideRect.size.width * 0.5 + movedDistance * 2 , rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height * 0.5 - movedDistance);
    CGPoint pointD = CGPointMake(self.movePoint == POINT_D ? self.outsideRect.origin.x - movedDistance * 2 : self.outsideRect.origin.x, rectCenter.y);
    
    //c1 c2 A - B 的控制点 以此类推
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance);
    CGPoint c3 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset);
    CGPoint c7 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    
    //画圆
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextDrawPath(ctx, kCGPathFillStroke); //同时给线条和内部填充颜色

}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    //只要外接矩形在左侧，则改变B点；在右边，改变D点
    if (progress <= 0.5) {
        
        self.movePoint = POINT_B;
        NSLog(@"B点动");
        
    }else{
        
        self.movePoint = POINT_D;
        NSLog(@"D点动");
    }

    CGFloat origin_x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}
@end
