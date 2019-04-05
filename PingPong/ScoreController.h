//
//  ScoreController.h
//  PingPong
//
//  Created by Павел Нехорошкин on 04.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "DataStore.h"
#import "Score.h"
#import "ViewController.h"

@class ViewController;

@protocol ScoreController
- (void) checkScore:(BallState)ballState;
- (instancetype)initWithDataStore:(DataStore *)dataStore controller:(ViewController *)controller;
@end

