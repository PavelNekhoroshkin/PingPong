//
//  AIRacket.m
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "AIRacketView.h"

@implementation AIRacketView

- (instancetype) initWithScreenFrame:(CGRect)screenFrame  indent:(double)indent  width:(double)width height:(double)height
{
    
    self = [super init];
    
    if (self) {
        
        
        self.frame = CGRectMake(screenFrame.size.width/2 - width/2, indent, width, height);
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 3;
        self.backgroundColor = [UIColor yellowColor];
        self.userInteractionEnabled = YES;
        self.layer.shadowOffset =  CGSizeMake( 0.0,  0.0);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 2;
        
    }
    return self;
}

/**
 Анимация перемещения ракетки с AI

 @param x - новые еоординаты ракетки
 */
- (void) moveTo:(double)x
{
    [UIView animateWithDuration:0.7 animations:^{
        self.center = CGPointMake(x, self.center.y);

    }];
}


@end
