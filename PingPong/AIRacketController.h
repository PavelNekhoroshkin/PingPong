//
//  AIRacketController.h
//  PingPong
//
//  Created by Павел Нехорошкин on 04.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//
#import "DataStore.h"
#import "AIRacketView.h"
@class AIRacketView;

@protocol AIRacketController <NSObject>

-(instancetype) initWithDataStore:(DataStore *)dataStore;
-(void) aiRacketChangePosition:(AIRacketView *)aiRacket;

@end
