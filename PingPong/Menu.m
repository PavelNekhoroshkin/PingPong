//
//  Menu.m
//  PingPong
//
//  Created by Павел Нехорошкин on 02.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "Menu.h"


@interface Menu()
@property (nonatomic, weak)  UISlider *ballRadius;
@property (nonatomic, weak)  UISlider *racketHalfWidth;
@property (nonatomic, weak)  UISlider *speed;
@property (nonatomic, weak)  UISlider *playerRacketHeight;
@property (nonatomic, weak)  UISlider *playerRacketIndent;
@end


@implementation Menu

- (instancetype)initWithController:(ViewController *)controller
{
    self = [super init];
    if (self) {
        _controller = controller;
        CGRect frame = CGRectMake(40, 40, controller.view.frame.size.width - 80, controller.view.frame.size.height - 80 );
        self.frame = frame;
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 5;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 10;
        self.center = CGPointMake(controller.view.center.x, controller.view.center.y + controller.view.frame.size.height);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 50, 20, 100, 40)];
        [label setText:@"MENU"];
        label.textColor = UIColor.redColor;
        [label setFont:[UIFont boldSystemFontOfSize:32]];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        [self addSubview:label];

        
        UILabel *ballRadiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 60, 45)];
        [ballRadiusLabel setText:@"Ball radius"];
        ballRadiusLabel.textColor = UIColor.redColor;
        [ballRadiusLabel setFont:[UIFont boldSystemFontOfSize:18]];
        ballRadiusLabel.textAlignment = NSTextAlignmentLeft;
        ballRadiusLabel.numberOfLines = 2;
        [self addSubview:ballRadiusLabel];
        
        UISlider *ballRadius = [[UISlider alloc]initWithFrame:CGRectMake(90, 100, 130, 40)];
        ballRadius.minimumValue = 10;
        ballRadius.maximumValue = 60;
        [ballRadius setThumbTintColor:UIColor.blueColor];
        self.ballRadius = ballRadius;
        [self addSubview:ballRadius];
        
        UILabel *racketHalfWidthLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 60, 45)];
        [racketHalfWidthLabel setText:@"Racket width"];
        racketHalfWidthLabel.textColor = UIColor.redColor;
        [racketHalfWidthLabel setFont:[UIFont boldSystemFontOfSize:18]];
        racketHalfWidthLabel.textAlignment = NSTextAlignmentLeft;
        racketHalfWidthLabel.numberOfLines = 2;
        [self addSubview:racketHalfWidthLabel];
        
        UISlider *racketHalfWidth = [[UISlider alloc]initWithFrame:CGRectMake(90, 150, 130, 40)];
        racketHalfWidth.minimumValue = 10;
        racketHalfWidth.maximumValue = 100;
        [racketHalfWidth setThumbTintColor:UIColor.blueColor];
        self.racketHalfWidth = racketHalfWidth;
        [self addSubview:racketHalfWidth];
        
        UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 60, 45)];
        [speedLabel setText:@"Speed"];
        speedLabel.textColor = UIColor.redColor;
        [speedLabel setFont:[UIFont boldSystemFontOfSize:18]];
        speedLabel.textAlignment = NSTextAlignmentLeft;
        speedLabel.numberOfLines = 2;
        [self addSubview:speedLabel];
        
        UISlider *speed = [[UISlider alloc]initWithFrame:CGRectMake(90, 200, 130, 40)];
        speed.minimumValue = 50;
        speed.maximumValue = 70;
        [speed setThumbTintColor:UIColor.blueColor];
        self.speed = speed;

        [self addSubview:speed];
        
        
        UILabel *playerRacketHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 80, 45)];
        [playerRacketHeightLabel setText:@"Racket thikness"];
        playerRacketHeightLabel.textColor = UIColor.redColor;
        [playerRacketHeightLabel setFont:[UIFont boldSystemFontOfSize:18]];
        playerRacketHeightLabel.textAlignment = NSTextAlignmentLeft;
        playerRacketHeightLabel.numberOfLines = 2;
        [self addSubview:playerRacketHeightLabel];
        
        UISlider *playerRacketHeight = [[UISlider alloc]initWithFrame:CGRectMake(90, 250, 130, 40)];
        playerRacketHeight.minimumValue = 5;
        playerRacketHeight.maximumValue = 200;
        [playerRacketHeight setThumbTintColor:UIColor.blueColor];
        self.playerRacketHeight = playerRacketHeight;
        [self addSubview:playerRacketHeight];
        
        UILabel *playerRacketIndentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 60, 45)];
        [playerRacketIndentLabel setText:@"Racket indent"];
        playerRacketIndentLabel.textColor = UIColor.redColor;
        [playerRacketIndentLabel setFont:[UIFont boldSystemFontOfSize:18]];
        playerRacketIndentLabel.textAlignment = NSTextAlignmentLeft;
        playerRacketIndentLabel.numberOfLines = 2;
        [self addSubview:playerRacketIndentLabel];
        
        UISlider *playerRacketIndent = [[UISlider alloc] initWithFrame:CGRectMake(90, 300, 130, 40)];
        playerRacketIndent.minimumValue = 10;
        playerRacketIndent.maximumValue = 300;
        [playerRacketIndent setThumbTintColor:UIColor.blueColor];
        self.playerRacketIndent = playerRacketIndent;

        [self addSubview:playerRacketIndent];
        
        UIButton *resume = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-40, self.frame.size.height-50, 80, 40)];
        [resume setTitle:@"RESUME" forState:UIControlStateNormal];
        resume.titleLabel.textAlignment = NSTextAlignmentCenter;
        [resume.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [resume setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [resume addTarget:self action:@selector(resumeFromMenu) forControlEvents:UIControlEventTouchDown];
        [self addSubview:resume];
    }
    return self;
}

- (void) setParams:(NSDictionary*)params
{
    self.ballRadius.value = [params[@"ballRadius"] floatValue];
    self.speed.value = 1.0/[params[@"time"] floatValue];
    self.racketHalfWidth.value = [params[@"racketHalfWidth"] floatValue];
    self.playerRacketHeight.value = [params[@"playerRacketHeight"] floatValue];
    self.playerRacketIndent.value = [params[@"playerRacketIndent"] floatValue];

}

- (void) openMenu
{
    [UIView animateWithDuration:0.7 animations:^{
        self.center = CGPointMake(self.controller.view.center.x, self.controller.view.center.y);
    }];
}

- (void) resumeFromMenu
{
    [self.controller resumeFromMenuWithParams:@{@"racketHalfWidth":@(self.racketHalfWidth.value), @"time":@(self.speed.value), @"ballRadius":@(self.ballRadius.value), @"playerRacketHeight":@(self.playerRacketHeight.value), @"playerRacketIndent":@(self.playerRacketIndent.value)}];
}

- (void) closeMenu
{
    
    [UIView animateWithDuration:0.7 animations:^{
        self.center = CGPointMake(self.controller.view.center.x, self.controller.view.center.y + self.controller.view.frame.size.height);
    }];
}

@end
