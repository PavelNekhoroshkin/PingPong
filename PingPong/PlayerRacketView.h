//
//  PlayerRacket.h
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlayerRacketView : UIView

@property (nonatomic, weak) ViewController *controller;

- (instancetype) initWithController:(ViewController *)controller screenFrame:(CGRect)screenFrame  indent:(double)indent width:(double)width height:(double)height;
- (void) moveTo:(double)x;

@end

NS_ASSUME_NONNULL_END
