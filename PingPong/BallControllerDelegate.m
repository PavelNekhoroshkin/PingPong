//
//  BallController.m
//  PingPong
//
//  Created by Павел Нехорошкин on 03.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "BallControllerDelegate.h"



@interface BallControllerDelegate()
@property (nonatomic, weak)  DataStore *dataStore;
@property (nonatomic, strong)  id<ScoreController> scoreControllerDelegate;
@end

@implementation BallControllerDelegate
- (instancetype)initWithDataStore:(DataStore *)dataStore scoreController:(id<ScoreController>)scoreControllerDelegate
{
    self = [super init];
    if (self) {
        _dataStore = dataStore;
        _scoreControllerDelegate = scoreControllerDelegate;
    }
    return self;
}

/**
 
 Случаи отскока мяча от ракетки пользователя
  -----------------------------------
 |1.1 |    2 отступ на радиус   | 4.1|
 |----###########################----|
 |    #    2 верх ракетки       #    |
 |1.2 #-------------------------# 4.2|
 |    #    3 низ ракетки        #    |
 |----###########################----|
 |1.3 |    3 отступ на радиус   | 4.3|
  -----------------------------------
 1 - левая сторона ракетки, центр мяча ближе чем радиус мяча - отскок влево
 2 - верхняя сторона ракетки, центр мяча ниже чем радиус мяча и половина толщины ракетки - отскок вверх
 3 - нижняя сторона ракетки, центр мяча ближе чем радиус мяча и половина толщины ракетки - отскок вниз
 4 - правая сторона ракетки, центр мяча ближе чем радиус мяча - отскок вправо
 */
- (void) mooveBall:ball
{
    double x = self.dataStore.ballCenterX + self.dataStore.dX;
    double y = self.dataStore.ballCenterY + self.dataStore.dY;
    
    //удар о левый край экрна
    if(x < self.dataStore.ballRadius)
    {
        self.dataStore.dX = self.dataStore.speedX;
        x = 2 * self.dataStore.ballRadius - x;
        
    }
    //удар о правый край
    else if(x > self.dataStore.width - self.dataStore.ballRadius)
    {
        self.dataStore.dX = self.dataStore.speedX * (-1);
        x = 2 * (self.dataStore.width - self.dataStore.ballRadius) - x;
        
    }
    
    
    
    
    //удар о верх экрана
    if(y  <  self.dataStore.ballRadius)
    {
        self.dataStore.dY = self.dataStore.speedY;

    }
    
    //удар о низ экрана
    else if( y > self.dataStore.height - self.dataStore.ballRadius)
    {
        
        //проверка смены статуса (если удар не повторный)
        [self.scoreControllerDelegate checkScore:BallLoosed];
        
        //отскок
        self.dataStore.dY = self.dataStore.speedY * (-1);
        self.dataStore.aiCalculated = NO;
        
        
    } else if (y > self.dataStore.height - self.dataStore.playerRacketIndent + self.dataStore.ballRadius)
    {
        //зона пропуска мяча, статус не контролируется, поскольку мяч может покинуть зону толькол после отскока от низа экрана, то проверяем только эти события
        
        
    }
    else if (y > self.dataStore.height - self.dataStore.playerRacketIndent - self.dataStore.playerRacketHeight  - self.dataStore.ballRadius)
    {
        //зона действия ракетки, мяч в промежуточном состоянии, может быть отбит или пропущен
        //если статус еще не менялся, то он будет актулизарован
        [self.scoreControllerDelegate checkScore:BallInAction];

    }
    else
    {
        //мяч выше ракетки, зона отбитого мяча
        //если статус еще не менялся, то он будет актулизарован
        [self.scoreControllerDelegate checkScore:BallStriked];

    }
    
    
    if (x > self.dataStore.playerRacketCenterX - self.dataStore.racketHalfWidth - self.dataStore.ballRadius)
    {
        //мяч на левом краю (зона 1)
        if (x < self.dataStore.playerRacketCenterX - self.dataStore.racketHalfWidth)
        {
            if ( y > self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent - self.dataStore.ballRadius)
            {
                //мяч в плоскости ракетки
                if ( y > self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent - self.dataStore.ballRadius)
                {
                    
                    //1.1
                    if (y < self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent)
                    {
                //на больших радиусах мяча приходится дополнительно проверять, что расстояние от центра до угла стало меньше радиуса
                        if (( x - (self.dataStore.playerRacketCenterX - self.dataStore.racketHalfWidth))*(x - (self.dataStore.playerRacketCenterX - self.dataStore.racketHalfWidth)) +   (y - (self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent))*(y - (self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent)) < self.dataStore.ballRadius*self.dataStore.ballRadius)
                        {
                            // расстояния от угла до центра мяча меньше радиуса
                            self.dataStore.dX = self.dataStore.speedX * (-1) ;
                            self.dataStore.dY = self.dataStore.speedY * (-1);
                            self.dataStore.aiCalculated = NO;
                        }
                    }
                    //1.2
                    else if (y < self.dataStore.height - self.dataStore.playerRacketIndent)
                    {
                        self.dataStore.dX = self.dataStore.speedX * (-1);
                    }
                    //1.3
                    else if (y < self.dataStore.height - self.dataStore.playerRacketIndent + self.dataStore.ballRadius)
                    {
                        self.dataStore.dY = self.dataStore.speedY;
                    }
                    //мяч ниже ракетки пользователя
                    else
                    {
                       
                    }
                }
            }
            
            
            
        }
        //мяч в пределах ширины ракетки (зона 2 и 3)
        else if (x < self.dataStore.playerRacketCenterX + self.dataStore.racketHalfWidth)
        {
            if ( y > self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent - self.dataStore.ballRadius)
            {
                //зона 2 - если выше середины, отскок вверх
                if ( y < self.dataStore.height - self.dataStore.playerRacketIndent - self.dataStore.playerRacketHeight/2  )
                {
                    self.dataStore.dY = self.dataStore.speedY * (-1);
                    self.dataStore.aiCalculated = NO;
                    
                }
                //зона 3 - если ниже середины, но не ниже толщины ракетки, то отскок вниз
                else if (y < self.dataStore.height - self.dataStore.playerRacketIndent + self.dataStore.ballRadius  )
                {
                    self.dataStore.dY = self.dataStore.speedY;
                }
            }
        }
        //мяч на правом краю (зона 4)
        else if (x < self.dataStore.playerRacketCenterX + self.dataStore.racketHalfWidth + self.dataStore.ballRadius)
        {
            //мяч в плоскости ракетки
            if ( y > self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent - self.dataStore.ballRadius)
            {
              //4.1
                if (y < self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent)
                {
                    //на больших радиусах мяча приходится дополнительно проверять, что расстояние от центра до угла стало меньше радиуса
                    if ((x - (self.dataStore.playerRacketCenterX + self.dataStore.racketHalfWidth))*(x - (self.dataStore.playerRacketCenterX + self.dataStore.racketHalfWidth)) +   (y - (self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent))*(y - (self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent)) < self.dataStore.ballRadius*self.dataStore.ballRadius)
                    {
                        // расстояния от угла до центра мяча меньше радиуса
                        self.dataStore.dX = self.dataStore.speedX;
                        self.dataStore.dY = self.dataStore.speedY * (-1);
                        self.dataStore.aiCalculated = NO;
                    }
                }
                //4.2
                else if (y < self.dataStore.height - self.dataStore.playerRacketIndent)
                {
                    self.dataStore.dX = self.dataStore.speedX;
                }
                //4.3
                else if (y < self.dataStore.height - self.dataStore.playerRacketIndent + self.dataStore.ballRadius)
                {
                    self.dataStore.dY = self.dataStore.speedY;
                }
            }
        }
    }
    
    
    //отскок от ракетки с ИИ
    if ( self.dataStore.dY < 0 && y < self.dataStore.aiRacketIndent + self.dataStore.aiRacketHeight + self.dataStore.ballRadius)
    {
        
        //мяч в пределах ширины ракетки
        if (x > self.dataStore.aiRacketCenterX - self.dataStore.racketHalfWidth + 10 && x < self.dataStore.aiRacketCenterX + self.dataStore.racketHalfWidth - 10 )
        {
            //смена угла отскока, имитация случайного отклонения
            [self changeDirection];
            
            //отскок
            self.dataStore.dY = self.dataStore.speedY;
        }
    }
    
    self.dataStore.ballCenterX = x;
    self.dataStore.ballCenterY = y;
    
    [ball moveTo:x :y];
}

/**
 Немного меняет направление движения мяча при ударе о ракетку AI, имитация случайного отклонения
 */
- (void) changeDirection
{
    if (self.dataStore.dX > 0)
    {
        if (self.dataStore.speedX  < 7)
        {
            self.dataStore.speedX  = self.dataStore.speedX + 1;
            self.dataStore.dX  = self.dataStore.speedX;
            self.dataStore.speedY  = self.dataStore.speedY - 1;
        }
        
    } else {
        
        if (self.dataStore.speedX > 2 )
        {
            self.dataStore.speedX  = self.dataStore.speedX - 1;
            self.dataStore.dX  = self.dataStore.speedX * (-1);
            self.dataStore.speedY  = self.dataStore.speedY + 1;
        }
        
    }
}


- (void) moveBallOnPlayerRacketMovement:(double)x
{
    //мяч по высоте на уровне ракетки
    if (self.dataStore.ballCenterY > self.dataStore.height - self.dataStore.playerRacketIndent - self.dataStore.playerRacketHeight  && self.dataStore.ballCenterY < self.dataStore.height - self.dataStore.playerRacketIndent  )
    {
        //  справа
        if (self.dataStore.ballCenterX > self.dataStore.playerRacketCenterX)
        {
            double playerRacketRightEdge = self.dataStore.playerRacketCenterX + self.dataStore.racketHalfWidth + self.dataStore.ballRadius;
            //наезд ракетки на мяч сдвигает мяч
            if (self.dataStore.ballCenterX < playerRacketRightEdge)
            {
                self.dataStore.ballCenterX = playerRacketRightEdge;
                self.dataStore.dX = self.dataStore.speedX;
                
            }
        }
        //слева
        else
        {
            double playerRacketLeftEdge = self.dataStore.playerRacketCenterX - self.dataStore.racketHalfWidth - self.dataStore.ballRadius;
            
            //наезд ракетки на мяч сдвигает мяч
            if (self.dataStore.ballCenterX > playerRacketLeftEdge)
            {
                self.dataStore.ballCenterX = playerRacketLeftEdge;
                self.dataStore.dX = self.dataStore.speedX * (-1);
            }
        }
    }
    
    self.dataStore.playerRacketCenterX = x;
}


@end
