//
//  DataStore.m
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "DataStore.h"
#import "BallState.h"

@interface DataStore()

@end

@implementation DataStore

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        _racketHalfWidth = 40;
        _aiCalculated = NO;
        _aiRacketCalculatedCentrerX = 0;
        _count = 0;
        _time = 0.016;
        
        
        
        _speedX = 5;
        _speedY = 8;
        
        _dX = 5;
        _dY = 10;
        
        _ballCenterX = self.width/2;
        _ballCenterY = self.height/2;
        _ballRadius = 15;
        _ballState = BallStriked;
        
        _aiRacketCenterX = self.width/2;
        _aiRacketHeight = 30;
        _aiRacketIndent = 20;

        _playerRacketCenterX = self.width/2;
        _playerRacketHeight = 30;
        _playerRacketIndent = 60;
        
        _penaltyForLoosingBall = 10;
        _bonusForStrikedBall = 1;
        
        _score = 0;
        
    }
    return self;
}

@end

