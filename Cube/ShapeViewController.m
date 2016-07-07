//
//  ShapeViewController.m
//  Cube
//
//  Created by Ari Chen on 7/7/16.
//  Copyright © 2016 Ari Chen. All rights reserved.
//

#import "ShapeViewController.h"

@interface ShapeViewController ()

@end

@implementation ShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShape];
    [self animateShape];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawShape {
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
    
    CAShapeLayer *layer = [self shapeWithPath:path.CGPath];
    [shapeLayer addSublayer:layer];
    
    // 2nd - right
    CGAffineTransform transform = CGAffineTransformMakeScale(-1, 1);
    transform = CGAffineTransformTranslate(transform, -138, 0);
    [path applyTransform:transform];
    
    layer = [self shapeWithPath:path.CGPath];
    [shapeLayer addSublayer:layer];
    
    // 3rd - middle
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(88, 246)];
    [path addCurveToPoint:CGPointMake(138, 250) controlPoint1:CGPointMake(98, 245) controlPoint2:CGPointMake(128, 247)];
    [path addLineToPoint:CGPointMake(50, 0)];
    [path closePath];
    
    layer = [self shapeWithPath:path.CGPath];
    [shapeLayer addSublayer:layer];
    
    // shadow
    CALayer *shadow = [CALayer layer];
    shadow.frame = CGPathGetBoundingBox(path.CGPath);
    shadow.backgroundColor = [UIColor grayColor].CGColor;
    shadow.mask = layer;
    [shapeLayer addSublayer:shadow];
    
    [self.view.layer addSublayer:shapeLayer];
}

- (CAShapeLayer *)shapeWithPath:(CGPathRef)path {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor redColor].CGColor;
    layer.path = path;
    return layer;
}

- (void)animateShape {
    
}

@end
