//
//  ViewController.m
//  PingPong
//
//  Created by Павел Нехорошкин on 30.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "MainScreen.h"
#import "Ball.h"
#import "PlayerRacketView.h"
#import "AIRacketView.h"
#import "AIRacketController.h"
#import "MenuButton.h"
#import "Score.h"
#import "BallState.h"
#import "Menu.h"



@interface ViewController ()
@property (nonatomic, weak) Ball *ball;
@property (nonatomic) BOOL isPlayerRacketNeedsToRefresh;
@property (nonatomic, weak) PlayerRacketView *playerRacket;
@property (nonatomic, weak) AIRacketView *aiRacket;
@property (nonatomic, weak) MenuButton *menuButton;
@property (nonatomic, weak) Menu *menu;
@property (nonatomic, weak) UILabel *score;
@property (nonatomic, weak) NSTimer *timer;

@end



@implementation ViewController




- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.dataStore.width,self.dataStore.height)];
    [view setBackgroundColor: UIColor.whiteColor];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.dataStore.time target:self selector:@selector(refreshScreenByTimer) userInfo:nil repeats:YES];
    timer.tolerance = 0.002;
    self.timer=timer;
    
}


/**
 Создать элементы интерфейса
 */
-(void) createUI
{
    Ball *ball = [[Ball alloc] initWithScreenFrame:self.view.frame radius:self.dataStore.ballRadius];
    self.ball = ball;
    [self.view addSubview:ball];
    
    PlayerRacketView *playerRacket = [[PlayerRacketView alloc] initWithController:self screenFrame:self.view.frame indent:self.dataStore.playerRacketIndent  width:self.dataStore.racketHalfWidth*2 height:self.dataStore.playerRacketHeight];
    self.playerRacket = playerRacket;
    [self.view addSubview:playerRacket];
    
    AIRacketView *aiRacket = [[AIRacketView alloc] initWithScreenFrame:self.view.frame indent:self.dataStore.aiRacketIndent width:self.dataStore.racketHalfWidth*2 height:self.dataStore.aiRacketHeight ];
    self.aiRacket = aiRacket;
    [self.view addSubview:aiRacket];
    
    
    MenuButton *menuButton = [[MenuButton alloc] initWithController:self];
    self.menuButton = menuButton;
    [self.view addSubview:menuButton];
    
    
    Score *score = [[Score alloc] initWithScreenFrame:self.view.frame];
    self.score = score;
    [self.view addSubview:score];
    
    Menu *menu = [[Menu alloc] initWithController:self];
    
    self.menu = menu;
    [self.view addSubview:menu];
    
    
}

/**
  Изменение данных и представлений по таймеру
 */
- (void) refreshScreenByTimer
{
    if (self.isPlayerRacketNeedsToRefresh)
    {
        //пользователь сдвинул ракетку, обработать результат
        [self.playerRacket moveTo:self.dataStore.playerRacketCenterX ];
    }

    //обновления положения и состояния мяча
    [self.ballControllerDeltgate mooveBall:self.ball];

    //обновление положения AI ракетки
    [self aiRacketMove];
    
}



/**
 Обработка действий пользователя по перемещению ракетки

 @param x - новый центр ракетки
 */
-(void) playerMovedRacketTo:(double)x
{
    //коррект ровка сдвига - ракетка не выходит за границам экрана
    if (x < self.dataStore.racketHalfWidth)
    {
        x = self.dataStore.racketHalfWidth;
    }
    else if (x  > self.dataStore.width - self.dataStore.racketHalfWidth)
    {
        x  = self.dataStore.width - self.dataStore.racketHalfWidth;
    }
    
    //ракетка может сдвинуть мяч при движении
    [self.ballControllerDeltgate moveBallOnPlayerRacketMovement:x];
    
    //новое положение ракетки должно быть обновлено
    self.isPlayerRacketNeedsToRefresh = YES;
    
}


/**
 Размещение центра ракетки c AI в точку попадания мяча
 */
-(void) aiRacketMove
{
    
    if (self.dataStore.dY > 0)
    {
        //мяч летит вниз, расчет не требуется
        return;
    }
    
    //для текущего маршрута мяча расчет уже выполнен, перерасчет не требуется
    if (self.dataStore.aiCalculated)
    {
        return;
    }
    
    //мяч в пределах лоступа ракетки игрока и может изменить направление, перерасчет не требуется
    if ( self.dataStore.ballCenterY > self.dataStore.height - self.dataStore.playerRacketHeight - self.dataStore.playerRacketIndent - self.dataStore.ballRadius - 10)
    {
        return;
    }
    
    //Расчитать точку столкновения с мячом
   [self.aiRacketControllerDelegate aiRacketChangePosition:self.aiRacket];
    
    //Разместить ракетку с AI в точке столкновения с мячом
}


/**
 Отобразить меню настроек
 */
-(void) openMenu
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self.menu setParams:                                         @{@"racketHalfWidth":@(self.dataStore.racketHalfWidth), @"time":@(self.dataStore.time), @"ballRadius":@(self.dataStore.ballRadius), @"playerRacketHeight":@(self.dataStore.playerRacketHeight), @"playerRacketIndent":@(self.dataStore.playerRacketIndent)}];
    
    [self.menu openMenu];
  
}


/**
 Получить новые настройки при выходе из меню и возобновить игру
 Новые настройки передаются в контроллер, сохраняются в модели и используются для изменния в игре
 
 @param params - словарь с параметрами
 */
-(void) resumeFromMenuWithParams:(NSDictionary *)params
{
    
    self.dataStore.ballRadius = [params[@"ballRadius"] floatValue];
    self.dataStore.time = 1.0/[params[@"time"] floatValue];
    self.dataStore.racketHalfWidth = [params[@"racketHalfWidth"] floatValue];
    self.dataStore.playerRacketHeight = [params[@"playerRacketHeight"] floatValue];
    self.dataStore.playerRacketIndent = [params[@"playerRacketIndent"] floatValue];
    
    
   
    [self.ball removeFromSuperview];
    Ball *ball = [[Ball alloc] initWithScreenFrame:self.view.frame radius:self.dataStore.ballRadius];
    self.ball = ball;
    [self.view addSubview:ball];

    
    [self.playerRacket removeFromSuperview];
    PlayerRacketView *playerRacket = [[PlayerRacketView alloc] initWithController:self screenFrame:self.view.frame indent:self.dataStore.playerRacketIndent  width:self.dataStore.racketHalfWidth*2 height:self.dataStore.playerRacketHeight];
    self.playerRacket = playerRacket;
    [self.view addSubview:playerRacket];
    
    [self.aiRacket removeFromSuperview]; AIRacketView *aiRacket = [[AIRacketView alloc] initWithScreenFrame:self.view.frame indent:self.dataStore.aiRacketIndent width:self.dataStore.racketHalfWidth*2 height:self.dataStore.aiRacketHeight ];
    self.aiRacket = aiRacket;
    [self.view addSubview:aiRacket];
    
    [self.view bringSubviewToFront:self.menu];

    [self.menu closeMenu];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.dataStore.time target:self selector:@selector(refreshScreenByTimer) userInfo:nil repeats:YES];
    timer.tolerance = 0.002;
    self.timer=timer;
    

}

/**
 Отображение суммы набранных очков на экране

 @param score - количество набранных очков
 */
- (void) changeScore:(int)score
{
    [self.score setText:[NSString stringWithFormat:@"%d", score]];
}


/**
 Отображение начисленных очков и штрафов рядом местом удара.

 @param scorePoint - размер начисленного бонуса или штрафа
 */
- (void) animateScore:(double)scorePoint
{
    UILabel *scorePointLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.dataStore.ballCenterX - 20, self.dataStore.ballCenterY - 50, 40, 40)];
//    scorePointLabel.backgroundColor = UIColor.lightGrayColor;
    scorePointLabel.textColor = UIColor.redColor;
    scorePointLabel.textAlignment = NSTextAlignmentCenter;
    scorePointLabel.layer.cornerRadius = 20;
    scorePointLabel.clipsToBounds = YES;
    scorePointLabel.layer.shadowOpacity = 0.7;
    scorePointLabel.layer.shadowRadius = 4;
    scorePointLabel.layer.shadowOffset =  CGSizeMake( 0.0,  0.0);

    [scorePointLabel setText:[NSString stringWithFormat:@"%.0f", scorePoint]];
    scorePointLabel.layer.opacity = 0.8;

    [self.view addSubview:scorePointLabel];

    [UIView animateWithDuration:1.0 animations:^{
        scorePointLabel.center =CGPointMake(self.dataStore.ballCenterX + 5, self.dataStore.ballCenterY - 80);
        scorePointLabel.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [scorePointLabel removeFromSuperview];
    }];
    
}

@end

