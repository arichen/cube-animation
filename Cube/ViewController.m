//
//  ViewController.m
//  Cube
//
//  Created by Ari Chen on 7/6/16.
//  Copyright © 2016 Ari Chen. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawCube];
//    [self animateCube];
    [self animateCube3D];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawCube {
    const CGFloat LENGTH = 100;
    const CGColorRef strokeColor = [UIColor lightGrayColor].CGColor;
    
    CGRect bound = self.view.layer.bounds;
    CGPoint center = CGPointMake(bound.origin.x + bound.size.width/2, bound.origin.y + bound.size.height/2);
    
    // first surface
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    CGRect rect1 = CGRectMake(center.x - LENGTH/2, center.y - LENGTH/2, LENGTH, LENGTH);
    layer1.path = [UIBezierPath bezierPathWithRect:rect1].CGPath;
    layer1.fillColor = [UIColor greenColor].CGColor;
    layer1.strokeColor = strokeColor;
    [self.view.layer addSublayer:layer1];
    
    // second surface
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    CGRect rect2 = CGRectApplyAffineTransform(rect1, CGAffineTransformMakeTranslation(LENGTH/2, -LENGTH/2));
    layer2.path = [UIBezierPath bezierPathWithRect:rect2].CGPath;
    layer2.fillColor = [UIColor redColor].CGColor;
    layer2.strokeColor = strokeColor;
    [self.view.layer insertSublayer:layer2 atIndex:0];
    
    // side surface
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, rect1.origin.x, rect1.origin.y);
    CGPathAddLineToPoint(path, NULL, rect2.origin.x, rect2.origin.y);
    CGPathAddLineToPoint(path, NULL, rect2.origin.x, rect2.origin.y + rect2.size.height);
    CGPathAddLineToPoint(path, NULL, rect1.origin.x, rect1.origin.y + rect1.size.height);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    layer3.fillColor = [UIColor yellowColor].CGColor;
    layer3.strokeColor = strokeColor;
    layer3.path = path;
    CGPathRelease(path);
    
    [self.view.layer insertSublayer:layer3 below:layer1];
    
    // side surface
    path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, rect1.origin.x + rect1.size.width, rect1.origin.y);
    CGPathAddLineToPoint(path, NULL, rect2.origin.x + rect2.size.width, rect2.origin.y);
    CGPathAddLineToPoint(path, NULL, rect2.origin.x + rect1.size.width, rect2.origin.y + rect2.size.height);
    CGPathAddLineToPoint(path, NULL, rect1.origin.x + rect2.size.width, rect1.origin.y + rect1.size.height);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *layer4 = [CAShapeLayer layer];
    layer4.fillColor = [UIColor yellowColor].CGColor;
    layer4.strokeColor = strokeColor;
    layer4.path = path;
    CGPathRelease(path);
    
    [self.view.layer insertSublayer:layer4 below:layer1];
}

- (void)animateCube {
    [CATransaction begin];
    
    for (CALayer *layer in self.view.layer.sublayers) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.y";
        animation.values = @[ @0, @10, @-10, @10, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 2;
        
        animation.additive = YES;
        
        [layer addAnimation:animation forKey:@"shake"];
    }
    
    [CATransaction commit];
}

- (void)animateCube3D {
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"sublayerTransform";
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 1)];
    animation.duration = 2;
    [self.view.layer addAnimation:animation forKey:@"animation"];
//    for (CALayer *layer in self.view.layer.sublayers) {
////        layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
//        
//        CATransform3D transform = CATransform3DMakeTranslation(100 / 2.0, 0.0, 100 / -2.0);
//        CABasicAnimation *animation = [CABasicAnimation animation];
//        animation.keyPath = @"transform";
//        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI_2, 0, 1, 0)];
//        animation.duration = 1;
//        
////        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
////        animation.fromValue = @(0);
////        animation.toValue = @(M_PI_4);
////        animation.duration = 5;
//        
//        [layer addAnimation:animation forKey:@"transform"];
//        break;
//    }
    
    [CATransaction commit];
    
}

@end
