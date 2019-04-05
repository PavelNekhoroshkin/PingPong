//
//  AICalculator.m
//  PingPong
//
//  Created by Павел Нехорошкин on 01.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "AIRacketControllerDelegate.h"
#import "DataStore.h"

@interface AIRacketControllerDelegate()
@property (nonatomic, strong) DataStore *dataStore;
@end

@implementation AIRacketControllerDelegate
-(instancetype) initWithDataStore:(DataStore *)dataStore
{
    self = [super init];
    if (self) {
        _dataStore = dataStore;
    }
    return self;
}


/**
 Рассчитать место удара мяча и переместить ракетку

 @param aiRacket - указатель на view ракетки
 */
-(void) aiRacketChangePosition:(AIRacketView *) aiRacket
{

    double moveWidth = self.dataStore.width - 2 * self.dataStore.ballRadius;
    
    double count = (self.dataStore.ballCenterY - self.dataStore.aiRacketIndent - self.dataStore.aiRacketHeight - self.dataStore.ballRadius) / self.dataStore.dY * (-1);
    
    double aiRacketCalculatedCentrerX = count * self.dataStore.dX + self.dataStore.ballCenterX - self.dataStore.ballRadius;
    
    if (aiRacketCalculatedCentrerX < 0){
        aiRacketCalculatedCentrerX = aiRacketCalculatedCentrerX * (-1);
    }
    
    while ( aiRacketCalculatedCentrerX > 2 * moveWidth )
    {
        aiRacketCalculatedCentrerX = aiRacketCalculatedCentrerX - 2 * moveWidth;
        
    }
    
    if ( aiRacketCalculatedCentrerX >  moveWidth)
    {
        aiRacketCalculatedCentrerX = 2 * moveWidth - aiRacketCalculatedCentrerX;
    }
    
    aiRacketCalculatedCentrerX = aiRacketCalculatedCentrerX + self.dataStore.ballRadius;
    
    
    
    if (aiRacketCalculatedCentrerX < self.dataStore.racketHalfWidth) {
        aiRacketCalculatedCentrerX = self.dataStore.racketHalfWidth;
    }
    if (aiRacketCalculatedCentrerX > self.dataStore.width - self.dataStore.racketHalfWidth) {
        aiRacketCalculatedCentrerX = self.dataStore.width - self.dataStore.racketHalfWidth;
    }
    
    self.dataStore.aiCalculated = YES;
    self.dataStore.aiRacketCenterX = aiRacketCalculatedCentrerX;
    
    [aiRacket moveTo: aiRacketCalculatedCentrerX];

}

@end
