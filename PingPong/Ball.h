//
//  Ball.h
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"
//@class ViewController;

NS_ASSUME_NONNULL_BEGIN

@interface Ball : UIView

- (instancetype) initWithScreenFrame:(CGRect)frame radius:(double)radius;
- (void) moveTo:(double)x :(double)y;

@end

NS_ASSUME_NONNULL_END
