//
//  MenuButton.m
//  PingPong
//
//  Created by Павел Нехорошкин on 02.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "MenuButton.h"

@interface MenuButton()

@property (nonatomic, weak) ViewController *controller;

@end


@implementation MenuButton


/**
 Кнопка вызова меню

 @param controller <#controller description#>
 @return <#return value description#>
 */
- (instancetype) initWithController:(ViewController *)controller
{
    self = [super init];
    
    if (self) {
        
        _controller = controller;
        self.frame = CGRectMake(controller.view.frame.size.width - 70, 80, 60, 30);
        [self setTitle:@"MENU" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addTarget:controller action:@selector(openMenu)
         forControlEvents:UIControlEventTouchDown];

    }
    return self;
}

@end
