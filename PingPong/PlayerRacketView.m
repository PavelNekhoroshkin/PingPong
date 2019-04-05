//
//  PlayerRacket.m
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "PlayerRacketView.h"

@implementation PlayerRacketView

- (instancetype) initWithController:(ViewController *)controller screenFrame:(CGRect)screenFrame indent:(double)indent width:(double)width height:(double)height
{

    self = [super init];
    
    if (self)
    {
        _controller = controller;
        

        CGRect frame = CGRectMake(20, 0, width, height);
        UIView *racket = [[UIView alloc] initWithFrame:frame];
        racket.layer.cornerRadius = 5;
        racket.layer.borderColor = [UIColor lightGrayColor].CGColor;
        racket.layer.borderWidth = 3;
        racket.backgroundColor = [UIColor yellowColor];
        racket.userInteractionEnabled = YES;
        racket.layer.shadowOffset =  CGSizeMake( 0.0,  0.0);
        racket.layer.shadowOpacity = 0.3;
        racket.layer.shadowRadius = 2;
        [self addSubview:racket];

        self.frame = CGRectMake(screenFrame.size.width/2 - width/2 - 20, screenFrame.size.height - height - indent, width + 40, height + indent);

    }
    
    return self;
}

- (void) moveTo:(double)x
{
    self.center = CGPointMake(x, self.center.y);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
    UITouch *touch =  touches.anyObject;

    CGPoint point = [touch locationInView:self];

    double x = self.frame.origin.x + point.x;
    
    [self.controller playerMovedRacketTo:x];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch =  touches.anyObject;

    CGPoint point = [touch locationInView:self];

    double x = self.frame.origin.x + point.x;

    [self.controller playerMovedRacketTo:x];

}

@end
