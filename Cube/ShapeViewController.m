//
//  ShapeViewController.m
//  Cube
//
//  Created by Ari Chen on 7/7/16.
//  Copyright © 2016 Ari Chen. All rights reserved.
//

#import "ShapeViewController.h"

@interface ShapeViewController ()
@property (nonatomic) CALayer *shapeLayer;
@end

@implementation ShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"N Animation";
    self.view.layer.backgroundColor = [UIColor blackColor].CGColor;
    
    [self drawShape];
    [self animateShape];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawShape {
    UIColor *darkRedColor = [UIColor colorWithRed:177.f/256 green:6.f/256 blue:15.f/256 alpha:1];
    UIColor *redColor = [UIColor colorWithRed:229.f/256 green:9.f/256 blue:20.f/256 alpha:1];
    UIColor *shadowColor = [UIColor colorWithRed:130.f/256 green:2.f/256 blue:13.f/256 alpha:.2];
    
    CALayer *shapeLayer = [CALayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 138, 250);
    shapeLayer.position = self.view.center;
    
    // 1st - left
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0, 250)];
    [path addCurveToPoint:CGPointMake(50, 246) controlPoint1:CGPointMake(10, 247) controlPoint2:CGPointMake(40, 245)];
    [path addLineToPoint:CGPointMake(50, 0)];
    [path closePath];
    
    CAShapeLayer *layer = [self shapeWithPath:path.CGPath withColor:darkRedColor];
    [shapeLayer addSublayer:layer];
    
    // 2nd - right
    CGAffineTransform transform = CGAffineTransformMakeScale(-1, 1);
    transform = CGAffineTransformTranslate(transform, -138, 0);
    [path applyTransform:transform];
    
    layer = [self shapeWithPath:path.CGPath withColor:darkRedColor];
    [shapeLayer addSublayer:layer];
    
    // 3rd - middle
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(88, 246)];
    [path addCurveToPoint:CGPointMake(138, 250) controlPoint1:CGPointMake(98, 245) controlPoint2:CGPointMake(128, 247)];
    [path addLineToPoint:CGPointMake(50, 0)];
    [path closePath];
    
    layer = [self shapeWithPath:path.CGPath withColor:redColor];
    [shapeLayer addSublayer:layer];
    
    // shadow mask
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-3, 0)];
    [path addLineToPoint:CGPointMake(85, 250)];
    [path addLineToPoint:CGPointMake(141, 250)];
    [path addLineToPoint:CGPointMake(53, 0)];
    [path closePath];
    
    CAShapeLayer *shadow = [self shapeWithPath:path.CGPath withColor:shadowColor];
    [shapeLayer insertSublayer:shadow below:layer];
    
    [self.view.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
}

- (CAShapeLayer *)shapeWithPath:(CGPathRef)path withColor:(UIColor *)color {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = color.CGColor;
    layer.path = path;
    return layer;
}

- (void)animateShape {
    [CATransaction begin];

    // 1st animation
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation.z";
    rotate.fromValue = @(0);
    rotate.toValue = @(-M_PI * 6);
    
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.values = @[ @0, @.5, @1 ];
    scale.keyTimes = @[ @0, @.8, @1 ];
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.animations = @[rotate, scale];
    animation.duration = .6;
    
    [_shapeLayer addAnimation:animation forKey:@"animation1"];
    
    // 2nd animation
    scale = [CAKeyframeAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.values = @[ @1, @1.1, @.9, @1 ];
    scale.keyTimes = @[ @0, @.3, @.6, @1 ];
    scale.beginTime = CACurrentMediaTime() + .7;
    scale.duration = .4;
    [_shapeLayer addAnimation:scale forKey:@"animation2"];
    
    [CATransaction commit];
}

@end
