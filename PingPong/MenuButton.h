//
//  MenuButton.h
//  PingPong
//
//  Created by Павел Нехорошкин on 02.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuButton : UIButton
- (instancetype) initWithController:(ViewController *)controller;

@end

NS_ASSUME_NONNULL_END
