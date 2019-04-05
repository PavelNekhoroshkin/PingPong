//
//  Menu.h
//  PingPong
//
//  Created by Павел Нехорошкин on 02.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Menu : UIView
@property (nonatomic, weak)  ViewController *controller;
@property (nonatomic, weak)  NSDictionary *params;

- (instancetype)initWithController:(ViewController *)controller;
- (void) setParams:(NSDictionary*)params;
- (void) openMenu;
- (void) closeMenu;

@end

NS_ASSUME_NONNULL_END
