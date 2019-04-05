//
//  DataStore.h
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallState.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataStore : NSObject
@property (nonatomic) double width;
@property (nonatomic) double height;

@property (nonatomic) double racketHalfWidth;
@property (nonatomic) double count;
@property (nonatomic) double time;
@property (nonatomic) double aiRacketCalculatedCentrerX;

//признак, что выполнен рассчет нового положения ракетки AI,
//чтобы не выполнять расчет часто
//в дальнейшем событие расчета нужно связать с отскоком от стен или от ракетки пользователя
@property (nonatomic) BOOL aiCalculated;

@property (nonatomic) double ballCenterX;
@property (nonatomic) double ballCenterY;
@property (nonatomic) double ballRadius;
@property (nonatomic) enum BallState ballState;

@property (nonatomic) double aiRacketCenterX;
@property (nonatomic) double aiRacketHeight;
@property (nonatomic) double aiRacketIndent;

@property (nonatomic) double playerRacketCenterX;
@property (nonatomic) double playerRacketHeight;
@property (nonatomic) double playerRacketIndent;

@property (nonatomic) double speedX;
@property (nonatomic) double speedY;

@property (nonatomic) double dX;
@property (nonatomic) double dY;

@property (nonatomic) double penaltyForLoosingBall;
@property (nonatomic) double bonusForStrikedBall;

@property (nonatomic) int score;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

typedef enum BallState EOCConnectionState;


NS_ASSUME_NONNULL_END
