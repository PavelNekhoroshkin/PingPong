//
//  Ball.m
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "Ball.h"
#import "ViewController.h"

@interface Ball()

@property (nonatomic) double radius;
@property (nonatomic, weak) ViewController *controller;

@end

@implementation Ball

- (instancetype) initWithScreenFrame:(CGRect)frame radius: (double) radius
{
    self = [super init];

    if (self) {
        
        _radius = radius;
        self.frame = CGRectMake(frame.size.width/2-radius, frame.size.height/2-radius, 2*self.radius, 2*self.radius);
        self.layer.cornerRadius = self.radius;
        self.backgroundColor = [UIColor blueColor];
        self.layer.shadowOffset =  CGSizeMake( 0.0,  0.0);
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 4;

    }
    return self;
}


- (void) moveTo:(double)x :(double)y
{
//    self.layer.shadowOffset =  CGSizeMake( (self.center.x - x)/3,  (self.center.y - y)/3);
    self.center = CGPointMake(x, y);
}
@end
