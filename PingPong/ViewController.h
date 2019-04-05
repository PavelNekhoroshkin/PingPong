//
//  ViewController.h
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "AIRacketController.h"
#import "BallController.h"


@protocol AIRacketController;
@protocol BallController;

@interface ViewController : UIViewController

@property (nonatomic, strong) DataStore *dataStore;
@property (nonatomic, strong) id<AIRacketController> aiRacketControllerDelegate;
@property (nonatomic, strong) id<BallController> ballControllerDeltgate;

- (void) playerMovedRacketTo:(double)x;
- (void) openMenu;
- (void) resumeFromMenuWithParams:(NSDictionary *)params;
- (void) changeScore:(int)score;
- (void) animateScore:(double)scorePoint;

@end

