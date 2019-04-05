//
//  ScoreControllerDelegate.m
//  PingPong
//
//  Created by Павел Нехорошкин on 04.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "ScoreControllerDelegate.h"

@interface ScoreControllerDelegate()
@property (nonatomic,weak) DataStore *dataStore;
@property (nonatomic,weak) ViewController *controller;
@end


@implementation ScoreControllerDelegate

- (instancetype)initWithDataStore:(DataStore *)dataStore controller:(ViewController *)controller
{
    self = [super init];
    if (self) {
        _dataStore = dataStore;
        _controller = controller;
    }
    return self;
}

/**
 Проверка выполнения условий для начисления бонусных или штрафных очков от отбитый или пропущенный мяч

 @param ballState <#ballState description#>
 */
-(void) checkScore:(BallState)ballState
{
    
    if (self.dataStore.ballState == ballState){
        //статус не меняется, действий не требуется
        return;
    }
    
    //получено событие о возможной смене статуса, нужно проверить условия и начислить или снять очки
    //если сумма очков меняется нужно обновить  view на экране через вызов метода ViewController
    switch (self.dataStore.ballState) {
           
        case BallInAction:
            {
                switch (ballState) {
                    case BallStriked:
                        {
                            //мяч отбит
                            self.dataStore.ballState = BallStriked;
                            self.dataStore.score += self.dataStore.bonusForStrikedBall;
                            [self.controller changeScore:self.dataStore.score];
                            [self.controller animateScore:self.dataStore.bonusForStrikedBall];
                        }
                        break;
                    case BallLoosed:
                        {
                            //мяч пропущен
                            self.dataStore.ballState = BallLoosed;
                            self.dataStore.score -= self.dataStore.penaltyForLoosingBall;
                            [self.controller changeScore:self.dataStore.score];
                            [self.controller animateScore:(self.dataStore.penaltyForLoosingBall * (-1))];

                        }
                        break;
                    default:
                        break;
                }
            }
            break;
            
        case BallLoosed:
            {
                if (ballState == BallStriked)
                {
                    
                        //мяч ушел за пределы действия ракетки, пропуск мяча уже был засчитан, отскока в зону пропуска уже быть не может, поэтому выполняем смену состояния
                        self.dataStore.ballState = BallStriked;
                }
                
                        //если мяч после пропуска попал в зону действия ракетки мяч, он все еще считается пропущенным, к тому же может отскочить обратно  в зону пропуска, чтобы не засчитывать штраф за пропуск дважды  статус не меняем, то же самое когда мяч остался в зоне пропуска
               
            }
            break;
            
        case BallStriked:
    
            //из свободной зоны мяч может попасть только в зону действия ракетки или остаться в свободной зоне
            if (ballState == BallInAction)
            {
                    //мяч в пределах действия ракетки, попал сюда из свободной зоны, поэтому выполняем смену состояния
                    self.dataStore.ballState = BallInAction;
            }
            break;
            
        default:
            break;
    }
    
    
}
@end




