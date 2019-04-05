//
//  AIRacket.h
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class ViewController;

NS_ASSUME_NONNULL_BEGIN

@interface AIRacketView : UIView
@property (nonatomic, weak) ViewController *controller;
- (instancetype) initWithScreenFrame:(CGRect)screenFrame  indent:(double)indent width:(double)width height:(double)height ;
- (void) moveTo:(double)x;

@end

NS_ASSUME_NONNULL_END
