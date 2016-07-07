//
//  ViewController.m
//  Cube
//
//  Created by Ari Chen on 7/6/16.
//  Copyright © 2016 Ari Chen. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define sideLength 150

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self drawCube];
    [self animateCube3D];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawCube {
    CATransformLayer *transformLayer = [CATransformLayer layer];
    
    CALayer *layer = [self sideLayerWithColor:[UIColor redColor]];
    [transformLayer addSublayer:layer];
    
    layer = [self sideLayerWithColor:[UIColor orangeColor]];
    CATransform3D transform = CATransform3DMakeTranslation(-sideLength/2, 0, -sideLength/2);
    layer.transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [transformLayer addSublayer:layer];
    
    layer = [self sideLayerWithColor:[UIColor purpleColor]];
    transform = CATransform3DMakeTranslation(sideLength/2, 0, -sideLength/2);
    layer.transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [transformLayer addSublayer:layer];
    
    layer = [self sideLayerWithColor:[UIColor greenColor]];
    transform = CATransform3DMakeTranslation(0, 0, -sideLength);
    layer.transform = transform;
    [transformLayer addSublayer:layer];
    
    layer = [self sideLayerWithColor:[UIColor yellowColor]];
    transform = CATransform3DMakeTranslation(0, -sideLength/2, -sideLength/2);
    layer.transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [transformLayer addSublayer:layer];
    
    layer = [self sideLayerWithColor:[UIColor brownColor]];
    transform = CATransform3DMakeTranslation(0, sideLength/2, -sideLength/2);
    layer.transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [transformLayer addSublayer:layer];
    
    self.view.layer.anchorPointZ = -sideLength/2;
    [self.view.layer addSublayer:transformLayer];
}

- (CALayer *)sideLayerWithColor:(UIColor *)color {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, sideLength, sideLength);
    layer.position = self.view.center;
    layer.backgroundColor = [color colorWithAlphaComponent:.7].CGColor;
    return layer;
}

- (void)animateCube3D {
    [CATransaction begin];
    
    CABasicAnimation *rotateX = [CABasicAnimation animation];
    rotateX.keyPath = @"sublayerTransform.rotation.x";
    rotateX.fromValue = @(0);
    rotateX.toValue = @(-M_PI * 2);
    
    CABasicAnimation *rotateY = [CABasicAnimation animation];
    rotateY.keyPath = @"sublayerTransform.rotation.y";
    rotateY.fromValue = @(0);
    rotateY.toValue = @(-M_PI * 2);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[rotateX, rotateY];
    animationGroup.duration = 8;
    animationGroup.repeatCount = HUGE_VAL;
    
    [self.view.layer addAnimation:animationGroup forKey:@"animation"];
    
    [CATransaction commit];
}

@end
