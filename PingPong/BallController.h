//
//  BallController.h
//  PingPong
//
//  Created by Павел Нехорошкин on 04.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//
#import "DataStore.h"
#import "ScoreController.h"
#import "Ball.h"

@protocol ScoreController;

@protocol BallController
- (void) mooveBall:(Ball *)ball;
- (void) moveBallOnPlayerRacketMovement:(double)x;
- (instancetype)initWithDataStore:(DataStore *)dataStore scoreController:(id<ScoreController>)scoreControllerDelegate;
@end
